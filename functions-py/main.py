import json
import re
from datetime import datetime, timezone, timedelta

import firebase_admin
from firebase_admin import firestore, messaging
from firebase_functions import scheduler_fn, params
import google.generativeai as genai

GEMINI_API_KEY = params.SecretParam("GEMINI_API_KEY")

firebase_admin.initialize_app()


@scheduler_fn.on_schedule(
    schedule="0 14 * * *",
    timezone=scheduler_fn.Timezone("Asia/Tokyo"),
    secrets=[GEMINI_API_KEY],
)
def generate_daily_feedback(event: scheduler_fn.ScheduledEvent) -> None:
    db = firestore.client()
    today = _jst_date_string()
    users = db.collection("users").stream()
    for user_doc in users:
        try:
            _process_user(db, user_doc.id, today)
        except Exception as e:
            print(f"[ERROR] userId={user_doc.id}: {e}")


def _process_user(db, user_id: str, date: str) -> None:
    entries = (
        db.collection("records")
        .document(user_id)
        .collection("entries")
        .where("date", "==", date)
        .stream()
    )
    entry_list = list(entries)
    if not entry_list:
        return

    feedback_ref = (
        db.collection("ai_feedbacks")
        .document(user_id)
        .collection("days")
        .document(date)
    )
    if feedback_ref.get().exists:
        return

    record_text = "\n".join(
        f"- 気分: {e.to_dict()['mood']}"
        + (f"\n  内容: {e.to_dict()['text']}" if e.to_dict().get("text") else "")
        for e in entry_list
    )

    feedback = _call_gemini(record_text)
    feedback["generatedAt"] = firestore.SERVER_TIMESTAMP
    feedback_ref.set(feedback)

    user_data = db.collection("users").document(user_id).get().to_dict() or {}
    fcm_token = user_data.get("fcmToken")
    if fcm_token:
        messaging.send(
            messaging.Message(
                token=fcm_token,
                notification=messaging.Notification(
                    title="庭から手紙が届きました 🌱",
                    body=feedback["affirmation"][:60] + "…",
                ),
            )
        )


def _call_gemini(record_text: str) -> dict:
    genai.configure(api_key=GEMINI_API_KEY.value)
    model = genai.GenerativeModel("gemini-2.5-flash")
    prompt = f"""
あなたは「Niwa」というアプリの、優しく寄り添うAIコンパニオンです。
ユーザーの今日の記録を読んで、以下のJSON形式でフィードバックを返してください。

【今日の記録】
{record_text}

【出力フォーマット（JSONのみ返してください）】
{{
  "affirmation": "今日の記録への寄り添いメッセージ（2〜3文、やわらかく温かい口調で）",
  "emotion": {{
    "positive_rate": 数値(0〜100),
    "trend": "上向き" または "横ばい" または "下向き",
    "summary": "感情傾向の要約（1文）"
  }},
  "steps": [
    "明日の小さな一歩1（具体的かつ低ハードル）",
    "明日の小さな一歩2（具体的かつ低ハードル）"
  ]
}}
""".strip()
    result = model.generate_content(prompt)
    text = result.text.strip()
    json_str = re.sub(r"^```json\n?", "", text)
    json_str = re.sub(r"\n?```$", "", json_str)
    return json.loads(json_str)


def _jst_date_string() -> str:
    jst = timezone(timedelta(hours=9))
    return datetime.now(tz=jst).strftime("%Y-%m-%d")
