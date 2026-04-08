# Niwa — DB仕様

## records/{userId}/entries/{docId}

| フィールド | 型 | 内容 |
|---|---|---|
| `mood` | String | 気分ラベル |
| `text` | String | 自由記述 |
| `date` | String | YYYY-MM-DD |
| `createdAt` | Timestamp | 投稿日時 |

## ai_feedbacks/{userId}/days/{date}

| フィールド | 型 | 内容 |
|---|---|---|
| `affirmation` | String | 寄り添いメッセージ |
| `emotion.positive_rate` | Number | ポジティブ率（0〜100） |
| `emotion.trend` | String | 上向き／横ばい／下向き |
| `emotion.summary` | String | 感情傾向の要約 |
| `steps` | Array\<String\> | スモールステップ2件 |
| `generatedAt` | Timestamp | 生成日時 |

## users/{userId}

| フィールド | 型 | 内容 |
|---|---|---|
| `fcmToken` | String | FCMデバイストークン |
| `createdAt` | Timestamp | 登録日時 |

## セキュリティルール

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /records/{userId}/entries/{entryId} {
      allow read, write: if request.auth.uid == userId;
    }
    match /ai_feedbacks/{userId}/days/{date} {
      allow read: if request.auth.uid == userId;
      allow write: if false;
    }
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }
  }
}
```
