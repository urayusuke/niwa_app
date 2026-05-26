class AppConfig {
  AppConfig._();

  static const buyMeCoffeeUrl    = 'https://buy.stripe.com/test_9B6dR92L7aVE8LC8ccaMU01';
  static const batchHour         = 23;
  static const aiMaxSteps        = 2;

  static const adBannerIdAndroid = String.fromEnvironment('ADMOB_BANNER_ID_ANDROID');
  static const adBannerIdIos     = String.fromEnvironment('ADMOB_BANNER_ID_IOS');

  /// テスト時に --dart-define=DISABLE_ADS=true で広告を無効化
  static const adsDisabled = bool.fromEnvironment('DISABLE_ADS');

  /// 広告非表示の一時購入 商品ID（Play Console 登録後に本番IDに差し替え）
  static const removeAdsProductId = 'niwa_remove_ads';
}
