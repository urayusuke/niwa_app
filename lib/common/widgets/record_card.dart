import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niwa_app/common/constants/app_colors.dart';
import 'package:niwa_app/common/constants/app_sizes.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/features/record/models/record.dart';
import 'package:niwa_app/features/record/state/record_state.dart';

class RecordCard extends ConsumerWidget {
  const RecordCard({super.key, required this.record});
  final Record record;

  Future<void> _onDeleteTap(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(AppText.deleteConfirmTitle),
          content: const Text(AppText.deleteConfirmBody),
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
                AppText.deleteConfirm,
                style: TextStyle(color: Colors.redAccent,),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await ref.read(recordNotifierProvider.notifier).deleteRecord(recordId: record.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting = ref.watch(recordNotifierProvider).isDeleting;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingBetweenButtons),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    record.mood,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.tertiary,
                        ),
                  ),
                ),
                if (isDeleting)
                  const SizedBox(
                    height: AppSizes.loadingIndicatorSize,
                    width: AppSizes.loadingIndicatorSize,
                    child: CircularProgressIndicator(
                      strokeWidth: AppSizes.loadingStrokeWidth,
                    ),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    iconSize: AppSizes.spacingMd,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: AppColors.onSurfaceMuted,
                    onPressed: () {
                      _onDeleteTap(context, ref);
                    },
                  ),
              ],
            ),
            if (record.stamps.isNotEmpty) ...[
              const SizedBox(height: AppSizes.spacingSm),
              Wrap(
                spacing: AppSizes.spacingSm,
                runSpacing: AppSizes.spacingXs,
                children: record.stamps.map((stamp) {
                  return Chip(
                    label: Text(
                      stamp,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.tertiary,
                          ),
                    ),
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: const BorderSide(color: AppColors.tertiary, width: 0.5),
                    backgroundColor: Colors.transparent,
                  );
                }).toList(),
              ),
            ],
            if (record.text.isNotEmpty) ...[
              const SizedBox(height: AppSizes.spacingSm),
              Text(record.text, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
