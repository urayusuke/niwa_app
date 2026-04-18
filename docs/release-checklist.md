# Niwa — リリース前チェックリスト

## AdMob

- [ ] AdMob コンソールでアプリを登録（Android・iOS）
- [ ] バナー広告ユニット ID を取得（Android・iOS）
- [ ] `.env.json` の `ADMOB_BANNER_ID_ANDROID` / `ADMOB_BANNER_ID_IOS` を本番 ID に差し替え
- [ ] `android/app/src/main/AndroidManifest.xml` の `APPLICATION_ID` を本番 App ID に差し替え
- [ ] `ios/Runner/Info.plist` の `GADApplicationIdentifier` を本番 App ID に差し替え

## Firebase

- [ ] Firestore セキュリティルールが `docs/db-spec.md` 通りに設定されているか確認
- [ ] FCM の iOS APNs 証明書を Firebase Console に登録

## ストア申請

- [ ] プライバシーポリシーを作成・公開（AdMob 使用のため必須）
- [ ] iOS: ATT（App Tracking Transparency）ダイアログの要否を確認
- [ ] App Store Connect / Google Play Console にアプリ登録
