# Niwa — タスク管理

## 🚧 残タスク

### ストア申請
- [ ] プライバシーポリシーを作成・公開（AdMob 使用のため必須）
- [ ] Google Play Console にアプリ登録・審査提出
- [ ] Stripe の「事業のウェブサイト」欄に GitHub Pages の URL を登録

### iOS
- [ ] iOS AdMob App ID を本番用に差し替え（現在テスト ID）
- [ ] `NSUserTrackingUsageDescription` を Info.plist に追加（ATT）
- [ ] APNs 証明書を Firebase Console に登録
- [ ] App Store Connect にアプリ登録・審査提出（MVP 後）

---

## ✅ リリース前チェックリスト

### AdMob
- [ ] Android AdMob バナー Unit ID を本番用に差し替え（`.env.json` の `ADMOB_BANNER_ID_ANDROID`）
- [ ] iOS AdMob バナー Unit ID を本番用に差し替え（`.env.json` の `ADMOB_BANNER_ID_IOS`）
- [ ] iOS `Info.plist` の `GADApplicationIdentifier` を本番 App ID に差し替え
- [ ] 実機でバナー広告が表示されることを確認

### Firebase
- [ ] Firestore セキュリティルールが `docs/db-spec.md` 通りに設定されているか確認
- [ ] FCM 通知が実機で届くことを確認（Android）
- [ ] FCM 通知が実機で届くことを確認（iOS、APNs 登録後）

### 動作確認
- [ ] 記録の作成・削除が正常に動作するか
- [ ] アカウント削除後に Firestore データが全件消えているか
- [ ] AI フィードバックが JST 23:00 に生成・通知されるか（Cloud Scheduler ログ確認）
- [ ] 履歴・日別詳細画面でフィードバックが表示されるか

---

## ✅ 完了済み

- [x] Firebase プロジェクト作成・Flutter 連携
- [x] Google 認証（firebase_auth + google_sign_in）
- [x] 記録機能（気分・スタンプ・テキスト入力）
- [x] 記録削除機能
- [x] アカウント削除機能（Firestore 全データ削除 + Auth 削除）
- [x] AI フィードバックバッチ（Cloud Functions + Gemini 2.5 Flash）
- [x] FCM トークン取得・Firestore 保存・更新
- [x] AdMob バナー広告（home_screen に表示）
- [x] Android AdMob App ID 本番設定済み
- [x] 履歴画面・日別詳細画面
- [x] 設定画面（サインアウト・アカウント削除・Buy Me a Coffee）
- [x] アプリアイコン設定（flutter_launcher_icons）
- [x] GitHub Pages ランディングページ（Stripe 審査用）
- [x] Cloud Functions スケジュール UTC 修正（JST 23:00 → UTC 14:00）
