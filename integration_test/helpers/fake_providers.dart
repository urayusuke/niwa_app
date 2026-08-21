import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niwa_app/app/services/fcm_service.dart';
import 'package:niwa_app/features/auth/repository/auth_repository.dart';
import 'package:niwa_app/features/feedback/repository/feedback_repository.dart';
import 'package:niwa_app/features/record/repository/record_repository.dart';

const testUid = 'test-uid';
const testEmail = 'test@example.com';

/// テストごとに新しいインスタンスを生成する。
/// グローバルシングルトンにすると、MockFirebaseAuth の authStateChanges stream が
/// 2回目以降のテストで user を emit しなくなり、/login にリダイレクトされる。
FakeFirebaseFirestore createFakeFirestore() => FakeFirebaseFirestore();

MockFirebaseAuth createFakeAuth() => MockFirebaseAuth(
  signedIn: true,
  mockUser: MockUser(uid: testUid, email: testEmail),
);

class _NoOpFcmService implements FcmService {
  @override
  Future<void> initialize(String userId) async {}
}

List<Override> buildTestOverrides({
  required FakeFirebaseFirestore firestore,
  required MockFirebaseAuth auth,
}) {
  return [
    authRepositoryProvider.overrideWith(
      (ref) => AuthRepository(auth, firestore),
    ),
    recordRepositoryProvider.overrideWith(
      (ref) => RecordRepository(firestore, testUid),
    ),
    feedbackRepositoryProvider.overrideWith(
      (ref) => FeedbackRepository(firestore, testUid),
    ),
    fcmServiceProvider.overrideWith((ref) => _NoOpFcmService()),
  ];
}
