import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/main.dart';

import 'helpers/fake_providers.dart';
import 'helpers/test_data.dart';

void main() {
  group('HomeScreen', () {
    late FakeFirebaseFirestore firestore;
    late MockFirebaseAuth auth;

    setUp(() {
      firestore = createFakeFirestore();
      auth = createFakeAuth();
    });

    testWidgets('TC-H-01: 記録0件 → Empty状態が表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: buildTestOverrides(firestore: firestore, auth: auth),
          child: const NiwaApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppText.homeEmpty), findsOneWidget);
      expect(find.text(AppText.fabLabel), findsOneWidget);
    });

    testWidgets('TC-H-02: FAB → InputSheet → 送信 → SnackBar・RecordCard追加', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: buildTestOverrides(firestore: firestore, auth: auth),
          child: const NiwaApp(),
        ),
      );
      await tester.pumpAndSettle();

      // FAB タップ
      await tester.tap(find.text(AppText.fabLabel));
      await tester.pumpAndSettle();

      // 気分選択
      await tester.tap(find.text('よかった'));
      await tester.pumpAndSettle();

      // スタンプ選択
      await tester.tap(find.text('ゆっくり休めた'));
      await tester.pumpAndSettle();

      // テキスト入力
      await tester.enterText(
        find.byType(TextField),
        'テスト記録',
      );
      await tester.pumpAndSettle();

      // 送信
      await tester.tap(find.text(AppText.recordSubmit));
      await tester.pumpAndSettle();

      // SnackBar
      expect(find.text(AppText.recordSuccess), findsOneWidget);

      // RecordCard に入力テキストが表示される
      expect(find.text('テスト記録'), findsOneWidget);

      // Firestore に1件保存されている
      final snap = await firestore
          .collection('records')
          .doc(testUid)
          .collection('entries')
          .get();
      expect(snap.docs.length, 1);
    });

    testWidgets('TC-H-03: RecordCard 削除 → ダイアログ確認 → カード消去', (tester) async {
      final today = DateTime.now();
      final dateStr =
          '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
      await seedRecord(firestore, date: dateStr, text: '削除テスト');

      await tester.pumpWidget(
        ProviderScope(
          overrides: buildTestOverrides(firestore: firestore, auth: auth),
          child: const NiwaApp(),
        ),
      );
      await tester.pumpAndSettle();

      // 削除ボタン
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      // 確認ダイアログ
      expect(find.text(AppText.deleteConfirmTitle), findsOneWidget);
      await tester.tap(find.text(AppText.deleteConfirm));
      await tester.pumpAndSettle();

      // カードが消えている
      expect(find.text('削除テスト'), findsNothing);

      // Firestore が空
      final snap = await firestore
          .collection('records')
          .doc(testUid)
          .collection('entries')
          .get();
      expect(snap.docs.isEmpty, true);
    });

    testWidgets('TC-H-04: AIフィードバックあり → フィードバックカード表示', (tester) async {
      final today = DateTime.now();
      final dateStr =
          '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
      await seedRecord(firestore, date: dateStr);
      await seedFeedback(
        firestore,
        date: dateStr,
        affirmation: 'よく頑張りました。',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: buildTestOverrides(firestore: firestore, auth: auth),
          child: const NiwaApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppText.feedbackFrom), findsOneWidget);
      expect(find.text('よく頑張りました。'), findsOneWidget);
    });
  });
}
