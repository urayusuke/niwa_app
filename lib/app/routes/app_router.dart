import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niwa_app/app/routes/app_route.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/features/auth/screens/login_screen.dart';
import 'package:niwa_app/features/auth/screens/welcome_screen.dart';
import 'package:niwa_app/features/auth/state/auth_state.dart';
import 'package:niwa_app/features/record/screens/day_detail_screen.dart';
import 'package:niwa_app/features/record/screens/history_screen.dart';
import 'package:niwa_app/features/record/screens/home_screen.dart';
import 'package:niwa_app/features/settings/screens/settings_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

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
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.history,
                builder: (context, state) => const HistoryScreen(),
                routes: [
                  GoRoute(
                    path: ':date',
                    builder: (context, state) {
                      final date = state.pathParameters['date']!;
                      return DayDetailScreen(date: date);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
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

class _AppShell extends ConsumerWidget {
  const _AppShell({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.eco_outlined),
            selectedIcon: Icon(Icons.eco),
            label: AppText.navHome,
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: AppText.navHistory,
          ),
        ],
      ),
    );
  }
}
