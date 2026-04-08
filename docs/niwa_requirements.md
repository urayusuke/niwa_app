# Niwa — MVP 要件定義書

> Claude Code に渡す用のリファレンスドキュメント  
> 2026年3月 ドラフト v1.0

---

## 1. プロダクト概要

| 項目 | 内容 |
|---|---|
| アプリ名 | Niwa（ニワ） |
| コンセプト | 非同期・非対称・低カロリーな自己肯定感の育成 |
| 世界観 | ネイビーの夜の庭に、イエローの焚き火がともる秘密基地 |
| 目的 | 孤独を減らしつつ、関係コストを負わずに「できたこと」を蓄積できる安全な居場所 |
| プラットフォーム | iOS / Android（Flutter） |
| フェーズ | MVP — ユーザーの反応を見てから機能を拡張する |

### App Store 説明文（申請用）

```
Niwa（ニワ）は、今日あったことを
そっと残せる、あなただけの庭です。

できたこと、感じたこと、小さな一歩。
誰にも見せなくていい。比べなくていい。
ただ、ここに残しておく。

毎日AIがあなたの記録を読んで、
やさしいことばと明日のヒントを届けます。
```

---

## 2. プロジェクト情報

```bash
flutter create --org com.bluehawaii niwa_app
cd niwa_app
```

| 項目 | 値 |
|---|---|
| プロジェクト名 | `niwa_app` |
| Bundle ID（iOS） | `com.bluehawaii.niwa_app` |
| Package名（Android） | `com.bluehawaii.niwa_app` |
| App Store表示名 | `Niwa` |

---

## 3. MVPスコープ

### やること

- 本人の記録機能（気分・できたこと・感情アイコン・スタンプ）
- AIフィードバック（毎日23時バッチ生成）
- バナー広告（AdMob）— 画面上部に常設
- 開発者支援ボタン（Buy Me a Coffee）— 設定画面に任意リンク
- プッシュ通知（FCM）— フィードバック生成後に通知

### やらないこと（MVP除外）

- 支援者ダッシュボード・レポート閲覧
- フォロー・DM・既読通知などの関係性機能
- 音声入力
- 著名人の名言表示
- 動画リワード広告
- サブスクリプション課金（反応見てから追加）

---

## 4. アーキテクチャ

### ディレクトリ構成（厳守）

```
lib/
├── app/
│   ├── routes/           # go_router
│   └── services/         # Firebase初期化・グローバルProvider
├── features/
│   └── [feature_name]/
│       ├── models/       # Freezedモデル
│       ├── repository/   # Firestore操作
│       ├── state/        # State + Notifier（1ファイルにまとめる）
│       └── screens/      # ConsumerWidget（UIのみ）
├── common/               # 共有ウィジェット
└── main.dart
```

**制約事項**
- 指定外のディレクトリ（`bindings/` `utils/` `helpers/` 等）は絶対に作成しない
- `state/` はStateクラスとNotifierを1ファイルにまとめる
- `screens/` はUIの描画のみ、ロジックは持たない

### 採用パターン

| レイヤー | 役割 | 備考 |
|---|---|---|
| `models/` | Freezedデータ構造のみ | `fromFirestore` を生やす |
| `repository/` | Firestore操作のみ | ビジネスロジックは持たない |
| `state/` | Stateクラス＋Notifier | ViewModelに相当 |
| `screens/` | UIの描画のみ | `ref.watch` して表示するだけ |

---

## 5. 技術スタック

| レイヤー | 技術・サービス | 備考 |
|---|---|---|
| フロントエンド | Flutter（iOS / Android） | クロスプラットフォーム |
| 状態管理 | flutter_riverpod + riverpod_annotation | `@riverpod` アノテーション使用 |
| モデル | freezed + json_serializable | コード生成 |
| ルーティング | go_router | |
| 認証 | Firebase Authentication | メール・Googleログイン |
| データベース | Cloud Firestore | 記録・フィードバック保存 |
| バッチ処理 | Cloud Functions v2 | 毎日23時 Scheduled Function |
| プッシュ通知 | Firebase Cloud Messaging（FCM） | 無制限・無料 |
| AI API | Gemini 2.5 Flash（Google） | 最安クラス |
| 広告 | Google AdMob | バナーのみ |
| 支援ボタン | Buy Me a Coffee | 外部リンクのみ |
| フォント | Zen Maru Gothic（Google Fonts） | 丸みのあるゴシック体 |

### pubspec.yaml（dependencies）

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Firebase
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
  firebase_messaging: ^15.0.0

  # State management
  flutter_riverpod: ^2.5.0
  riverpod_annotation: ^2.3.0

  # Model
  freezed_annotation: ^2.4.0
  json_annotation: ^4.9.0

  # Router
  go_router: ^14.0.0

  # Ads
  google_mobile_ads: ^5.0.0

  # Font
  google_fonts: ^6.0.0

  # Utils
  url_launcher: ^6.3.0

dev_dependencies:
  build_runner: ^2.4.0
  freezed: ^2.5.0
  riverpod_generator: ^2.4.0
  json_serializable: ^6.8.0
```

---

## 6. デザイン仕様

### 世界観

> 「ネイビーの夜空の下、ブラウンの土の上に、イエローの焚き火のような灯りがともる秘密基地」

ダークテーマベース。夜の庭・安心できる暗さを表現する。

### カラーパレット

| 役割 | 色 | HEX | 用途 |
|---|---|---|---|
| Background / Surface | ネイビー | `#0F1B2D` | 画面全体の背景 |
| Surface variant | ダークブルー | `#1A2F5E` | カード背景 |
| Primary | ネイビー | `#1A2F5E` | AppBar・主要ボタン |
| Secondary | マスタードブラウン | `#8B6914` | サブ要素・カード枠線 |
| Tertiary / FAB | マスタードイエロー | `#C8960C` | FAB・アクセント |
| AI feedback | 淡いイエロー | `#FFF8E7` | AIフィードバックエリア背景 |
| On surface | オフホワイト | `#E8EAF0` | テキスト |

### シェイプ

```dart
// 全体的に大きめの角丸
borderRadiusMd: 16.0
borderRadiusLg: 24.0
```

- 鋭角なデザインは緊張感を生むため使わない
- カード・ボタン・入力欄すべてに丸みを持たせる

### フォント

- **Zen Maru Gothic**（Google Fonts）
- 丸みのあるゴシック体で「安全な場所」を表現

### 各画面のUI指針

#### ① ホーム画面（夜の庭を眺める）

- 背景：深いネイビー
- 記録カード：`FilledCard` ダークトーンのブルー・ブラウン、角丸24px
- AIフィードバックエリア：カード下部に淡いイエローの `Container`
  - 「焚き火・ランタンの灯り」のような視覚効果
  - 寄り添いメッセージ＋明日のスモールステップ2件を表示
- FAB：右下、マスタードイエロー、アイコンは葉っぱ🌿またはスコップ
- AppBar：elevation 0、Surfaceカラーと馴染ませる、centerTitle: true

#### ② 入力（ボトムシート）

- `ModalBottomSheet` で下からせり上がる（画面遷移しない）
- 気分セレクター：`SegmentedButton` または `ChoiceChip` 横並び4段階
  - 選択時：ブラウン・イエローにじんわり点灯
- スタンプ：`Wrap` + `FilterChip`、複数選択可
  - タップ感覚＝「小石を拾うような低カロリーな動作」
- テキスト入力：`maxLines: null`（書いた分だけ広がる）
- 送信ボタン：`FilledButton` 幅いっぱい
- 完了時：SnackBar「庭に記録を置きました。今夜、手紙が届きます 🌱」→ボトムシートを静かに閉じる

#### ③ 設定画面

- `
#### ③ 設定画面

- `ListView` + `ListTile` で項目を並べる
- 開発者支援ボタン：
  - leading：☕ アイコン
  - title：「このアプリを応援する」
  - subtitle：「Buy Me a Coffeeを開く」
  - タップで外部ブラウザへ遷移（`url_launcher`）

---

## 7. Firestoreデータモデル

### `records/{userId}/entries/{docId}`

| フィールド | 型 | 内容 |
|---|---|---|
| `mood` | String | 気分ラベル（例：まあまあ） |
| `text` | String | 自由記述テキスト |
| `date` | String | YYYY-MM-DD（バッチ集計キー） |
| `createdAt` | Timestamp | 投稿日時 |

### `ai_feedbacks/{userId}/days/{date}`

| フィールド | 型 | 内容 |
|---|---|---|
| `affirmation` | String | 寄り添いメッセージ |
| `emotion.positive_rate` | Number | ポジティブ率（0〜100） |
| `emotion.trend` | String | 上向き／横ばい／下向き |
| `emotion.summary` | String | 感情傾向の要約 |
| `steps` | Array<String> | スモールステップ2件 |
| `generatedAt` | Timestamp | 生成日時 |

### `users/{userId}`

| フィールド | 型 | 内容 |
|---|---|---|
| `fcmToken` | String | FCMデバイストークン |
| `createdAt` | Timestamp | 登録日時 |

---

## 8. AIバッチ処理仕様

| 項目 | 内容 |
|---|---|
| 実行タイミング | 毎日23:00 JST |
| 対象 | 当日記録があるユーザーのみ |
| APIモデル | Gemini 2.5 Flash |
| リクエスト数 | 1ユーザー1日1リクエスト |
| プロンプト入力 | 当日の全記録をまとめて送信 |

### AIが生成するJSONフォーマット

```json
{
  "affirmation": "今日の記録への寄り添いメッセージ（2〜3文）",
  "emotion": {
    "positive_rate": 75,
    "trend": "上向き",
    "summary": "感情傾向の要約"
  },
  "steps": [
    "明日の小さな一歩1",
    "明日の小さな一歩2"
  ]
}
```

---

## 9. 収益構成

| 機能 | 詳細 | 実装コスト |
|---|---|---|
| バナー広告（AdMob） | 画面上部に常設・受動的表示 | 約30分 |
| 開発者支援ボタン | 設定画面にBuy Me a Coffeeリンク | 約10分 |
| サブスクリプション | 反応見てから追加（MVP除外） | — |

### コスト試算（月次）

| 項目 | DAU 100人 | DAU 1,000人 |
|---|---|---|
| Gemini 2.5 Flash API | ¥1未満 | ¥10未満 |
| Firebase（無料枠内） | ¥0 | ¥0 |
| AdMob収益（概算） | +¥300〜500 | +¥3,000〜5,000 |

---

## 10. 実装優先順位

| 順序 | タスク | 目安工数 |
|---|---|---|
| ① | Firebase プロジェクト作成・Blazeプラン切替・Flutter連携 | 〜30分 |
| ② | `app_theme.dart` テーマ定義 | 〜30分 |
| ③ | `app/routes/` go_router設定 | 〜20分 |
| ④ | `features/auth/` 認証 | 〜1時間 |
| ⑤ | `features/record/` 記録機能 | 〜1.5時間 |
| ⑥ | `features/feedback/` フィードバック表示 | 〜1時間 |
| ⑦ | Cloud Functions バッチ（Gemini連携） | 〜1.5時間 |
| ⑧ | FCMプッシュ通知 | 〜30分 |
| ⑨ | AdMobバナー広告 | 〜30分 |
| ⑩ | `features/settings/` 設定画面・Buy Me a Coffee | 〜20分 |

**合計目安：約8〜9時間**

---

## 11. Claude Codeへの投げ方

### 最初に渡すプロンプトテンプレート

```
以下の要件定義書を読んでFlutterアプリ「Niwa」を作成します。
@niwa_requirements.md

まず以下の2ファイルだけ作成してください。
1. pubspec.yaml
2. lib/app/services/app_theme.dart
```

### Feature追加時のテンプレート

```
前回までの構成を維持してください。
次に features/record/ を作成してください。

作成するファイル：
- models/record.dart（Freezed）
- repository/record_repository.dart
- state/record_state.dart（StateとNotifierを1ファイルに）
- screens/home_screen.dart
```

### 注意事項

- 1回1〜3ファイルまでに絞る
- 「指定外のディレクトリは作成しない」を毎回明記する
- 完成したファイルを都度伝えてから次に進む

---

*Niwa MVP 要件定義書 — 2026年3月*
