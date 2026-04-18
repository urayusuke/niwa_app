import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niwa_app/app/routes/app_route.dart';
import 'package:niwa_app/common/ad_banner.dart';
import 'package:niwa_app/common/constants/app_colors.dart';
import 'package:niwa_app/common/constants/app_sizes.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/common/widgets/record_card.dart';
import 'package:niwa_app/features/feedback/models/ai_feedback.dart';
import 'package:niwa_app/features/feedback/state/feedback_state.dart';
import 'package:niwa_app/features/record/state/record_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(recordNotifierProvider).records;
    final feedbackAsync = ref.watch(todayFeedbackProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.push(AppRoute.settings);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const AdBanner(),
          Expanded(
            child: records.isEmpty
          ? const _EmptyState()
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.spacingMd,
                AppSizes.spacingMd,
                AppSizes.spacingMd,
                80,
              ),
              itemCount: records.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return feedbackAsync.whenOrNull(
                        data: (feedback) => feedback != null
                            ? _FeedbackCard(feedback: feedback)
                            : const SizedBox.shrink(),
                      ) ??
                      const SizedBox.shrink();
                }
                return RecordCard(record: records[index - 1]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showInputSheet(context);
        },
        icon: const Icon(Icons.eco_outlined),
        label: const Text(AppText.fabLabel),
      ),
    );
  }

  void _showInputSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _InputSheet(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppText.homeEmpty,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacingMd),
          Text(
            '下のボタンから、今日の気持ちを残せます',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceMuted,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({required this.feedback});
  final AiFeedback feedback;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.cardPadding,
              AppSizes.cardPadding,
              AppSizes.cardPadding,
              0,
            ),
            child: Row(
              children: [
                const Text('🔥', style: TextStyle(fontSize: AppSizes.feedbackIconSize)),
                const SizedBox(width: AppSizes.spacingXs2),
                Text(
                  AppText.feedbackFrom,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.tertiary,
                      ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(AppSizes.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.aiFeedback,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Text(
              feedback.affirmation,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.background,
                    height: AppSizes.feedbackLineHeight,
                  ),
            ),
          ),
          if (feedback.steps.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.cardPadding,
                0,
                AppSizes.cardPadding,
                AppSizes.cardPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.feedbackSteps,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.tertiary,
                        ),
                  ),
                  const SizedBox(height: AppSizes.spacingSm),
                  ...feedback.steps.map(
                    (step) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.spacingXs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(color: AppColors.tertiary)),
                          Expanded(
                            child: Text(
                              step,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _InputSheet extends ConsumerStatefulWidget {
  const _InputSheet();

  @override
  ConsumerState<_InputSheet> createState() => _InputSheetState();
}

class _InputSheetState extends ConsumerState<_InputSheet> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final sheetState = ref.read(inputSheetNotifierProvider);
    await ref.read(recordNotifierProvider.notifier).addRecord(
          mood: sheetState.selectedMood,
          text: _textController.text.trim(),
          stamps: sheetState.selectedStamps,
        );
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppText.recordSuccess)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sheetState = ref.watch(inputSheetNotifierProvider);
    final sheetNotifier = ref.read(inputSheetNotifierProvider.notifier);
    final isSubmitting = ref.watch(recordNotifierProvider).isSubmitting;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppSizes.spacingLg,
        AppSizes.spacingLg,
        AppSizes.spacingLg,
        AppSizes.spacingLg + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppText.fabLabel, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSizes.spacingMd),
          // 気分選択
          Wrap(
            spacing: AppSizes.spacingSm,
            children: AppText.moods.map((mood) {
              final isSelected = sheetState.selectedMood == mood;
              return ChoiceChip(
                label: Text(
                  mood,
                  style: TextStyle(
                    color: isSelected ? AppColors.background : AppColors.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                showCheckmark: false,
                selectedColor: AppColors.tertiary,
                backgroundColor: AppColors.surface,
                side: BorderSide(
                  color: isSelected ? AppColors.tertiary : AppColors.secondary,
                  width: isSelected ? 0 : AppSizes.borderWidthThin,
                ),
                onSelected: (_) {
                  sheetNotifier.selectMood(mood);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppSizes.spacingMd),
          // スタンプ選択
          Text(
            AppText.inputStampsLabel,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.onSurfaceMuted,
                ),
          ),
          const SizedBox(height: AppSizes.spacingSm),
          Wrap(
            spacing: AppSizes.spacingSm,
            runSpacing: AppSizes.spacingSm,
            children: AppText.stamps.map((stamp) {
              final isSelected = sheetState.selectedStamps.contains(stamp);
              return FilterChip(
                label: Text(
                  stamp,
                  style: TextStyle(
                    color: isSelected ? AppColors.background : AppColors.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                showCheckmark: false,
                selectedColor: AppColors.tertiary,
                backgroundColor: AppColors.surface,
                side: BorderSide(
                  color: isSelected ? AppColors.tertiary : AppColors.secondary,
                  width: isSelected ? 0 : AppSizes.borderWidthThin,
                ),
                onSelected: (_) {
                  sheetNotifier.toggleStamp(stamp);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppSizes.spacingMd),
          TextField(
            controller: _textController,
            maxLines: null,
            decoration: const InputDecoration(hintText: AppText.recordHint),
          ),
          const SizedBox(height: AppSizes.spacingMd),
          FilledButton(
            onPressed: isSubmitting
                ? null
                : () {
                    _submit();
                  },
            child: isSubmitting
                ? const SizedBox(
                    height: AppSizes.loadingIndicatorSize,
                    width: AppSizes.loadingIndicatorSize,
                    child: CircularProgressIndicator(strokeWidth: AppSizes.loadingStrokeWidth),
                  )
                : const Text(AppText.recordSubmit),
          ),
        ],
      ),
    );
  }
}
