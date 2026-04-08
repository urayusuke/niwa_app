# Niwa — API仕様

## AIバッチ

| 項目 | 内容 |
|---|---|
| 実行タイミング | 毎日23:00 JST |
| 対象 | 当日記録があるユーザーのみ |
| モデル | Gemini 2.5 Flash |
| リクエスト数 | 1ユーザー1日1回 |
| 入力 | 当日の全記録をまとめて送信 |

### 出力JSONフォーマット

```json
{
  "affirmation": "寄り添いメッセージ（2〜3文）",
  "emotion": {
    "positive_rate": 75,
    "trend": "上向き",
    "summary": "感情傾向の要約"
  },
  "steps": ["明日の一歩1", "明日の一歩2"]
}
```

### Cloud Functions 実装

```typescript
import { onSchedule } from 'firebase-functions/v2/scheduler';

export const dailyFeedbackBatch = onSchedule(
  { schedule: 'every day 23:00', timeZone: 'Asia/Tokyo' },
  async () => {
    // 1. 当日記録があるユーザーをFirestoreから取得
    // 2. ユーザーごとに全記録をまとめてGemini APIに送信
    // 3. 結果をai_feedbacks/{userId}/days/{date}に保存
    // 4. FCMでプッシュ通知
  }
);
```
