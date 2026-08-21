import 'package:integration_test/integration_test.dart';

import 'home_test.dart' as home;
import 'history_test.dart' as history;
import 'day_detail_test.dart' as day_detail;
import 'settings_test.dart' as settings;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  home.main();
  history.main();
  day_detail.main();
  settings.main();
}
