import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niwa_app/app/routes/app_route.dart';
import 'package:niwa_app/common/constants/app_colors.dart';
import 'package:niwa_app/common/constants/app_sizes.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/features/auth/state/auth_state.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '🌱',
                style: TextStyle(fontSize: 64),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacingLg),
              Text(
                AppText.welcomeTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacingSm),
              Text(
                AppText.welcomeSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceMuted,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacingXxl),
              FilledButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).clearNewUser();
                  context.go(AppRoute.home);
                },
                child: const Text(AppText.welcomeButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
