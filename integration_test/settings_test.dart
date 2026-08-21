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
  group('SettingsScreen', () {
    late FakeFirebaseFirestore firestore;
    late MockFirebaseAuth auth;

    setUp(() {
      firestore = createFakeFirestore();
      auth = createFakeAuth();
    });

    Future<void> navigateToSettings(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: buildTestOverrides(firestore: firestore, auth: auth),
          child: const NiwaApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
    }

    testWidgets('TC-S-01: メールアドレスが表示される', (tester) async {
      await navigateToSettings(tester);

      expect(find.text(testEmail), findsOneWidget);
    });

    testWidgets('TC-S-02: サインアウトダイアログ → キャンセル → 画面維持', (tester) async {
      await navigateToSettings(tester);

      await tester.tap(find.text(AppText.settingsLogout));
      await tester.pumpAndSettle();

      expect(find.text(AppText.logoutConfirm), findsOneWidget);

      await tester.tap(find.text(AppText.logoutCancel));
      await tester.pumpAndSettle();

      // まだ設定画面にいる（LoginScreen へ遷移していない）
      expect(find.text(AppText.settingsTitle), findsOneWidget);
    });

    testWidgets('TC-S-03: アカウント削除 → Firestore 全消去 → LoginScreen へ遷移', (tester) async {
      await seedRecord(firestore, date: '2026-05-01');
      await seedFeedback(firestore, date: '2026-05-01');

      await navigateToSettings(tester);

      await tester.tap(find.text(AppText.settingsDeleteAccount));
      await tester.pumpAndSettle();

      expect(find.text(AppText.deleteAccountTitle), findsOneWidget);

      await tester.tap(find.text(AppText.deleteAccountButton));
      await tester.pumpAndSettle();

      // LoginScreen へ遷移
      expect(find.text(AppText.loginGoogle), findsOneWidget);

      // Firestore の records が空
      final entriesSnap = await firestore
          .collection('records')
          .doc(testUid)
          .collection('entries')
          .get();
      expect(entriesSnap.docs.isEmpty, true);

      // Firestore の ai_feedbacks が空
      final daysSnap = await firestore
          .collection('ai_feedbacks')
          .doc(testUid)
          .collection('days')
          .get();
      expect(daysSnap.docs.isEmpty, true);
    });
  });
}
