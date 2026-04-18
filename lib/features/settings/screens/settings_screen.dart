import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niwa_app/common/constants/app_config.dart';
import 'package:niwa_app/common/constants/app_sizes.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/features/auth/state/auth_state.dart';
import 'package:url_launcher/url_launcher.dart';

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
            textColor: Colors.redAccent,
            iconColor: Colors.redAccent,
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
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(AppText.settingsVersion),
            trailing: Text('1.0.0'),
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
              style: TextStyle(color: Colors.redAccent),
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
