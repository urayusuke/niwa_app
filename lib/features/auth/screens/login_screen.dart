import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niwa_app/common/constants/app_colors.dart';
import 'package:niwa_app/common/constants/app_sizes.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/features/auth/state/auth_state.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppText.homeTitle,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacingSm),
              Text(
                AppText.loginTitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceMuted,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spacingXxl),
              FilledButton.icon(
                onPressed: isLoading
                    ? null
                    : () async {
                        try {
                          await ref
                              .read(authNotifierProvider.notifier)
                              .signInWithGoogle();
                        } catch (_) {
                          if (context.mounted) _showError(context);
                        }
                      },
                icon: isLoading
                    ? const SizedBox(
                        height: AppSizes.loadingIndicatorSize,
                        width: AppSizes.loadingIndicatorSize,
                        child: CircularProgressIndicator(
                          strokeWidth: AppSizes.loadingStrokeWidth,
                        ),
                      )
                    : const Icon(Icons.login),
                label: const Text(AppText.loginGoogle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppText.errorGeneral)),
    );
  }
}
