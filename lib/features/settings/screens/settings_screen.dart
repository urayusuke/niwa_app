import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niwa_app/app/services/iap_service.dart';
import 'package:niwa_app/common/constants/app_config.dart';
import 'package:niwa_app/common/constants/app_colors.dart';
import 'package:niwa_app/common/constants/app_sizes.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/features/auth/state/auth_state.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'settings_screen.g.dart';

@riverpod
Future<String> appVersion(Ref ref) async {
  final info = await PackageInfo.fromPlatform();
  return info.version;
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).user;

    return Scaffold(
      appBar: AppBar(title: const Text(AppText.settingsTitle)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.spacingMd,
              AppSizes.spacingMd,
              AppSizes.spacingMd,
              4,
            ),
            child: Text(
              AppText.settingsAccount,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text(AppText.settingsEmail),
            subtitle: Text(user?.email ?? ''),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(AppText.settingsLogout),
            onTap: () {
              _confirmSignOut(context, ref);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_remove_outlined),
            title: const Text(AppText.settingsDeleteAccount),
            textColor: AppColors.danger,
            iconColor: AppColors.danger,
            onTap: () {
              _confirmDeleteAccount(context, ref);
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.spacingMd,
              AppSizes.spacingSm,
              AppSizes.spacingMd,
              4,
            ),
            child: Text(
              AppText.premiumSection,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          _PremiumTile(ref: ref),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.spacingMd,
              AppSizes.spacingSm,
              AppSizes.spacingMd,
              4,
            ),
            child: Text(
              AppText.settingsSupport,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.coffee_outlined),
            title: const Text(AppText.supportTitle),
            subtitle: const Text(AppText.supportSubtitle),
            onTap: () {
              _launchUrl(AppConfig.buyMeCoffeeUrl);
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.spacingMd,
              AppSizes.spacingSm,
              AppSizes.spacingMd,
              4,
            ),
            child: Text(
              AppText.settingsInfo,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(AppText.settingsVersion),
            trailing: Text(
              ref.watch(appVersionProvider).maybeWhen(
                    data: (v) => v,
                    orElse: () => '',
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _confirmDeleteAccount(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppText.deleteAccountTitle),
        content: const Text(AppText.deleteAccountBody),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: const Text(AppText.deleteCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
            child: const Text(
              AppText.deleteAccountButton,
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(authNotifierProvider.notifier).deleteAccount();
    }
  }

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppText.settingsLogout),
        content: const Text(AppText.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: const Text(AppText.logoutCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
            child: const Text(AppText.settingsLogout),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(authNotifierProvider.notifier).signOut();
    }
  }
}

class _PremiumTile extends ConsumerWidget {
  const _PremiumTile({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iapState = ref.watch(iapNotifierProvider);

    if (iapState.isPremium) {
      return const ListTile(
        leading: Icon(Icons.block_outlined),
        title: Text(AppText.removeAdsTitle),
        subtitle: Text(AppText.removeAdsPurchased),
      );
    }

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.block_outlined),
          title: const Text(AppText.removeAdsTitle),
          subtitle: const Text(AppText.removeAdsSubtitle),
          trailing: iapState.isLoading
              ? const SizedBox(
                  width: AppSizes.loadingIndicatorSize,
                  height: AppSizes.loadingIndicatorSize,
                  child: CircularProgressIndicator(
                    strokeWidth: AppSizes.loadingStrokeWidth,
                  ),
                )
              : FilledButton(
                  onPressed: () {
                    _purchase(context, ref);
                  },
                  child: const Text(AppText.removeAdsPurchase),
                ),
        ),
        ListTile(
          leading: const Icon(Icons.restore_outlined),
          title: const Text(AppText.removeAdsRestore),
          onTap: iapState.isLoading
              ? null
              : () {
                  _restore(context, ref);
                },
        ),
      ],
    );
  }

  Future<void> _purchase(BuildContext context, WidgetRef ref) async {
    await ref.read(iapNotifierProvider.notifier).purchase();
    final error = ref.read(iapNotifierProvider).errorMessage;
    if (error != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppText.purchaseError)),
      );
      ref.read(iapNotifierProvider.notifier).clearError();
    }
  }

  Future<void> _restore(BuildContext context, WidgetRef ref) async {
    final restored = await ref.read(iapNotifierProvider.notifier).restore();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          restored
              ? AppText.removeAdsRestoreDone
              : AppText.removeAdsRestoreNone,
        ),
      ),
    );
  }
}
