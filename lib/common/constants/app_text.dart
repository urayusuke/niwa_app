class AppText {
  AppText._();

  static const homeTitle      = 'Niwa';
  static const homeEmpty      = '今日の小さな一歩を残してみませんか';
  static const fabLabel       = '記録する';
  static const recordHint     = '今日あったことを、そっと残してください';
  static const recordSubmit   = '庭に置く';
  static const recordSuccess  = '庭に記録を置きました。今夜、手紙が届きます 🌱';

  static const moodVeryGood   = 'とても良い';
  static const moodOkay       = 'まあまあ';
  static const moodTough      = 'つらい';
  static const moodUnsure     = '何とも言えない';

  static const List<String> moods = [
    moodTough,
    'いまいち',
    moodOkay,
    'よかった',
  ];

  static const List<String> stamps = [
    '起きられた',
    'ご飯を食べた',
    '外に出た',
    '好きなことをした',
    'ゆっくり休んだ',
  ];

  static const inputStampsLabel = 'できたこと';

  static const feedbackTitle   = '今夜の手紙';
  static const feedbackFrom    = '今日の庭から';
  static const feedbackPending = '今夜23時にフィードバックが届きます';
  static const feedbackSteps   = '明日の小さな一歩';

  static const settingsTitle   = '設定';
  static const settingsAccount = 'アカウント';
  static const settingsSupport = 'サポート';
  static const settingsInfo    = 'アプリ情報';
  static const settingsEmail   = 'メールアドレス';
  static const settingsLogout  = 'ログアウト';
  static const settingsVersion = 'バージョン';
  static const supportTitle    = 'このアプリを応援する';
  static const supportSubtitle = 'コーヒー代を支援する';

  static const welcomeTitle    = 'あなたの庭ができました';
  static const welcomeSubtitle = '今日の小さな一歩から始めましょう';
  static const welcomeButton   = '庭へ行く';

  static const loginTitle      = 'あなただけの庭へ';
  static const loginGoogle     = 'Googleでログイン / 登録';
  static const logoutConfirm   = 'ログアウトしますか？';
  static const logoutCancel    = 'キャンセル';

  static const navHome      = 'ホーム';
  static const navHistory   = '記録';
  static const historyTitle = '記録の庭';
  static const historyEmpty = 'まだ記録がありません';

  static const dayDetailFeedbackEmpty = 'この日のフィードバックはまだ届いていません';

  static const errorGeneral          = 'しばらくしてからもう一度お試しください';
  static const errorNetwork          = 'ネットワークに接続できませんでした';
  static const errorRecord           = '記録を保存できませんでした。もう一度試してみてください';
}
