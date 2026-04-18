import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niwa_app/common/constants/app_colors.dart';
import 'package:niwa_app/common/constants/app_sizes.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/common/widgets/record_card.dart';
import 'package:niwa_app/features/feedback/models/ai_feedback.dart';
import 'package:niwa_app/features/feedback/state/feedback_state.dart';
import 'package:niwa_app/features/record/state/record_state.dart';

class DayDetailScreen extends ConsumerWidget {
  const DayDetailScreen({super.key, required this.date});
  final String date;

  String _formatDate(String date) {
    final dt = DateTime.parse(date);
    const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
    final weekday = weekdays[dt.weekday - 1];
    return '${dt.month}月${dt.day}日（$weekday）';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allRecords = ref.watch(historyNotifierProvider).records;
    final records = allRecords.where((r) => r.date == date).toList();
    final feedbackAsync = ref.watch(feedbackByDateProvider(date));

    return Scaffold(
      appBar: AppBar(
        title: Text(_formatDate(date)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.spacingMd,
          AppSizes.spacingMd,
          AppSizes.spacingMd,
          AppSizes.spacingMd,
        ),
        itemCount: records.length + 1,
        itemBuilder: (context, index) {
          if (index == records.length) {
            return feedbackAsync.when(
              data: (feedback) => feedback != null
                  ? _FeedbackCard(feedback: feedback)
                  : _FeedbackPending(),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            );
          }
          return RecordCard(record: records[index]);
        },
      ),
    );
  }
}

class _FeedbackPending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.spacingMd),
      child: Text(
        AppText.dayDetailFeedbackEmpty,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onSurfaceMuted,
            ),
        textAlign: TextAlign.center,
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
      margin: const EdgeInsets.only(top: AppSizes.spacingMd),
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

