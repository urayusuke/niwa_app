import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niwa_app/app/services/fcm_service.dart';
import 'package:niwa_app/features/auth/models/auth_user.dart';
import 'package:niwa_app/features/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    AuthUser? user,
    @Default(false) bool isLoading,
    @Default(false) bool isNewUser,
  }) = _AuthState;
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    ref.listen(
      authRepositoryProvider,
      (_, repo) {},
    );
    ref.watch(authRepositoryProvider).authStateChanges().listen((user) {
      bool isNewUser = false;
      if (user != null) {
        final createdAt = user.createdAt;
        if (createdAt != null) {
          final age = DateTime.now().difference(createdAt);
          isNewUser = age.inSeconds < 30;
        }
        ref.read(fcmServiceProvider).initialize(user.uid);
      }
      state = state.copyWith(user: user, isNewUser: isNewUser);
    });
    return const AuthState();
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
    } catch (e) {
      debugPrint('[ERROR] auth.signInWithGoogle: $e');
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void clearNewUser() {
    state = state.copyWith(isNewUser: false);
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}
