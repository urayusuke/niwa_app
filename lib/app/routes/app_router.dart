import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niwa_app/features/auth/screens/login_screen.dart';
import 'package:niwa_app/features/auth/screens/welcome_screen.dart';
import 'package:niwa_app/features/auth/state/auth_state.dart';
import 'package:niwa_app/features/record/screens/home_screen.dart';
import 'package:niwa_app/features/settings/screens/settings_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

abstract final class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const welcome = '/welcome';
  static const settings = '/settings';
}

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: AppRoute.home,
    redirect: (context, state) {
      final isLoggedIn = authState.user != null;
      final isNewUser = authState.isNewUser;
      final location = state.matchedLocation;
      final isAuthRoute = location == AppRoute.login;

      if (!isLoggedIn && !isAuthRoute && location != AppRoute.welcome) {
        return AppRoute.login;
      }
      if (isLoggedIn && isNewUser) return AppRoute.welcome;
      if (isLoggedIn && isAuthRoute) return AppRoute.home;
      if (!isLoggedIn && location == AppRoute.welcome) return AppRoute.login;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoute.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoute.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoute.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoute.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
