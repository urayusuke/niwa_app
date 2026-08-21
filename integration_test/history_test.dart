import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/main.dart';

import 'helpers/fake_providers.dart';
import 'helpers/test_data.dart';

void main() {
  group('HistoryScreen', () {
    late FakeFirebaseFirestore firestore;
    late MockFirebaseAuth auth;

    setUp(() {
      firestore = createFakeFirestore();
      auth = createFakeAuth();
    });

    testWidgets('TC-HI-01: 記録0件 → Empty状態', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: buildTestOverrides(firestore: firestore, auth: auth),
          child: const NiwaApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(AppText.navHistory));
      await tester.pumpAndSettle();

      expect(find.text(AppText.historyEmpty), findsOneWidget);
    });

    testWidgets('TC-HI-02: 複数日付のデータ → 日付ヘッダーでグループ表示', (tester) async {
      await seedRecord(firestore, date: '2026-05-01', text: '5月1日の記録');
      await seedRecord(firestore, date: '2026-05-02', text: '5月2日の記録');

      await tester.pumpWidget(
        ProviderScope(
          overrides: buildTestOverrides(firestore: firestore, auth: auth),
          child: const NiwaApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(AppText.navHistory));
      await tester.pumpAndSettle();

      expect(find.text('5月1日（金）'), findsOneWidget);
      expect(find.text('5月2日（土）'), findsOneWidget);
      expect(find.text('5月1日の記録'), findsOneWidget);
      expect(find.text('5月2日の記録'), findsOneWidget);
    });

    testWidgets('TC-HI-03: 日付ヘッダータップ → DayDetailScreen へ遷移', (tester) async {
      await seedRecord(firestore, date: '2026-05-01', text: '詳細テスト');

      await tester.pumpWidget(
        ProviderScope(
          overrides: buildTestOverrides(firestore: firestore, auth: auth),
          child: const NiwaApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(AppText.navHistory));
      await tester.pumpAndSettle();

      await tester.tap(find.text('5月1日（金）'));
      await tester.pumpAndSettle();

      // DayDetailScreen の AppBar タイトルが表示される
      expect(find.text('5月1日（金）'), findsWidgets);
      expect(find.text('詳細テスト'), findsOneWidget);
    });
  });
}
