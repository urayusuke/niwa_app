# Niwa — アプリ仕様

## プロジェクト概要

| 項目 | 内容 |
|---|---|
| アプリ名 | Niwa（ニワ） |
| プロジェクト名 | `niwa_app` |
| Bundle ID | `com.bluehawaii.niwa_app` |
| コンセプト | 夜の庭に焚き火がともる秘密基地。低カロリーな自己肯定感の育成 |
| 状態管理 | Riverpod（riverpod_annotation） |
| モデル | Freezed + json_serializable |
| ルーティング | go_router |
| バックエンド | Firebase（Auth・Firestore・Functions・FCM） |
| AI | Gemini 2.5 Flash（毎日23時バッチ） |
| 広告 | AdMob バナーのみ |

## MVPスコープ

### やること
- 本人の記録機能（気分・できたこと・感情アイコン・スタンプ）
- AIフィードバック（毎日23時バッチ生成）
- バナー広告（AdMob）
- 開発者支援ボタン（Buy Me a Coffee）
- プッシュ通知（FCM）

### やらないこと（MVP除外）
- 支援者ダッシュボード
- フォロー・DM・既読通知などの関係性機能
- 音声入力・著名人の名言
- 動画リワード広告
- サブスクリプション課金

---

## デザイン仕様

### 世界観

> 「ネイビーの夜空の下、ブラウンの土の上に、イエローの焚き火のような灯りがともる秘密基地」

ダークテーマベース。AIフィードバックエリアだけ淡いイエローにして「焚き火が届いた」感を演出する。

### フォント

- **Zen Maru Gothic**（Google Fonts）
- `app_theme.dart` で一元定義。直接 `GoogleFonts.zenMaruGothic()` を呼ばない

### カラーパレット

| 役割 | 定数名 | HEX |
|---|---|---|
| 背景 | `AppColors.background` | `#0d1b3e` |
| カード背景 | `AppColors.surface` | `#1A2F5E` |
| プライマリ | `AppColors.primary` | `#0d1b3e` |
| アクセント | `AppColors.secondary` | `#E5B94E` |
| AIエリア | `AppColors.aiFeedback` | `#FFF8E7` |
| テキスト | `AppColors.onSurface` | `#E8EAF0` |
| サブテキスト | `AppColors.onSurfaceMuted` | `#9AA3B2` |

### 各画面の指針

#### ホーム画面（夜の庭を眺める）
- 背景：`AppColors.background`
- 記録カード：`FilledCard`・`AppColors.surface`・`AppSizes.radiusLg`
- AIフィードバックエリア：カード内に `AppColors.aiFeedback` の Container
- FAB：右下・`AppColors.tertiary`・`Icons.eco_outlined`
- AppBar：`elevation: 0`・`centerTitle: true`

#### 入力（BottomSheet）
- `showModalBottomSheet` で下からせり上がる（画面遷移しない）
- 気分セレクター：`ChoiceChip` 横並び4段階・選択時 `AppColors.tertiary`
- スタンプ：`Wrap` + `FilterChip`・複数選択可
- テキスト入力：`maxLines: null`（自動拡張）
- 送信後：SnackBar `AppText.recordSuccess` → BottomSheetを閉じる

#### 設定画面
- `ListView` + `ListTile`
- 開発者支援：`Icons.coffee_outlined`・`url_launcher` で外部遷移
