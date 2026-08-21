import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/main.dart';

import 'helpers/fake_providers.dart';
import 'helpers/test_data.dart';

void main() {
  group('DayDetailScreen', () {
    late FakeFirebaseFirestore firestore;
    late MockFirebaseAuth auth;

    setUp(() {
      firestore = createFakeFirestore();
      auth = createFakeAuth();
    });

    Future<void> navigateToDetail(WidgetTester tester, String date) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: buildTestOverrides(firestore: firestore, auth: auth),
          child: const NiwaApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(AppText.navHistory));
      await tester.pumpAndSettle();

      final dt = DateTime.parse(date);
      const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
      final label = '${dt.month}月${dt.day}日（${weekdays[dt.weekday - 1]}）';
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
    }

    testWidgets('TC-D-01: 記録が表示される', (tester) async {
      await seedRecord(firestore, date: '2026-05-01', text: '詳細画面テスト記録');

      await navigateToDetail(tester, '2026-05-01');

      expect(find.text('詳細画面テスト記録'), findsOneWidget);
    });

    testWidgets('TC-D-02: AIフィードバックあり → フィードバックカード表示', (tester) async {
      await seedRecord(firestore, date: '2026-05-01');
      await seedFeedback(
        firestore,
        date: '2026-05-01',
        affirmation: '今日も一歩前進しました。',
      );

      await navigateToDetail(tester, '2026-05-01');

      expect(find.text(AppText.feedbackFrom), findsOneWidget);
      expect(find.text('今日も一歩前進しました。'), findsOneWidget);
    });

    testWidgets('TC-D-03: AIフィードバックなし → 未生成プレースホルダー表示', (tester) async {
      await seedRecord(firestore, date: '2026-05-01');

      await navigateToDetail(tester, '2026-05-01');

      expect(find.text(AppText.dayDetailFeedbackEmpty), findsOneWidget);
    });
  });
}
