import { onSchedule } from 'firebase-functions/v2/scheduler';
import { defineSecret } from 'firebase-functions/params';
import * as admin from 'firebase-admin';
import { GoogleGenerativeAI } from '@google/generative-ai';

const GEMINI_API_KEY = defineSecret('GEMINI_API_KEY');

admin.initializeApp();

export const generateDailyFeedback = onSchedule(
  {
    schedule: '0 14 * * *',  // UTC 14:00 = JST 23:00
    secrets: [GEMINI_API_KEY],
  },
  async () => {
    const db = admin.firestore();
    const today = jstDateString();
    console.log(`[START] generateDailyFeedback date=${today}`);

    const usersSnap = await db.collection('users').get();
    console.log(`[INFO] users count=${usersSnap.size}`);

    for (const userDoc of usersSnap.docs) {
      try {
        await processUser(db, userDoc.id, today);
      } catch (e) {
        console.error(`[ERROR] userId=${userDoc.id}:`, e);
      }
    }
    console.log('[DONE] generateDailyFeedback');
  }
);

async function processUser(db: admin.firestore.Firestore, userId: string, date: string) {
  console.log(`[processUser] userId=${userId} date=${date}`);

  const entriesSnap = await db
    .collection('records')
    .doc(userId)
    .collection('entries')
    .where('date', '==', date)
    .get();

  console.log(`[processUser] entries count=${entriesSnap.size}`);
  if (entriesSnap.empty) return;

  const feedbackRef = db
    .collection('ai_feedbacks')
    .doc(userId)
    .collection('days')
    .doc(date);

  const existing = await feedbackRef.get();
  if (existing.exists) {
    console.log(`[processUser] feedback already exists, skip`);
    return;
  }

  const recordText = entriesSnap.docs
    .map((d) => {
      const data = d.data();
      const mood = `- 気分: ${data['mood']}`;
      const text = data['text'] ? `\n  内容: ${data['text']}` : '';
      return mood + text;
    })
    .join('\n');

  console.log(`[processUser] calling Gemini...`);
  const feedback = await callGemini(recordText);
  console.log(`[processUser] Gemini response received, saving...`);
  await feedbackRef.set({ ...feedback, generatedAt: admin.firestore.FieldValue.serverTimestamp() });
  console.log(`[processUser] feedback saved for userId=${userId}`);

  const userSnap = await db.collection('users').doc(userId).get();
  const fcmToken = userSnap.data()?.['fcmToken'] as string | undefined;
  if (fcmToken) {
    await admin.messaging().send({
      token: fcmToken,
      notification: {
        title: '庭から手紙が届きました 🌱',
        body: feedback.affirmation.slice(0, 60) + '…',
      },
    });
  }
}

async function callGemini(recordText: string) {
  const genAI = new GoogleGenerativeAI(GEMINI_API_KEY.value());
  const model = genAI.getGenerativeModel({ model: 'gemini-2.5-flash' });

  const prompt = `
あなたは「Niwa」というアプリの、優しく寄り添うAIコンパニオンです。
ユーザーの今日の記録を読んで、以下のJSON形式でフィードバックを返してください。

【今日の記録】
${recordText}

【出力フォーマット（JSONのみ返してください）】
{
  "affirmation": "今日の記録への寄り添いメッセージ（2〜3文、やわらかく温かい口調で）",
  "emotion": {
    "positive_rate": 数値(0〜100),
    "trend": "上向き" または "横ばい" または "下向き",
    "summary": "感情傾向の要約（1文）"
  },
  "steps": [
    "明日の小さな一歩1（具体的かつ低ハードル）",
    "明日の小さな一歩2（具体的かつ低ハードル）"
  ]
}
`.trim();

  const result = await model.generateContent(prompt);
  const text = result.response.text().trim()
    .replace(/^```json\n?/, '')
    .replace(/\n?```$/, '');
  return JSON.parse(text);
}

function jstDateString(): string {
  const now = new Date();
  const jst = new Date(now.getTime() + 9 * 60 * 60 * 1000);
  return jst.toISOString().slice(0, 10);
}
