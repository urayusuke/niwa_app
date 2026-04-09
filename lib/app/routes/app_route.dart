abstract final class AppRoute {
  static const home     = '/';
  static const history  = '/history';
  static const login    = '/login';
  static const welcome  = '/welcome';
  static const settings = '/settings';

  static String historyDetail(String date) => '/history/$date';
}
