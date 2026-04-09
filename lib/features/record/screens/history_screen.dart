import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niwa_app/app/routes/app_route.dart';
import 'package:niwa_app/common/constants/app_colors.dart';
import 'package:niwa_app/common/constants/app_sizes.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/features/record/models/record.dart';
import 'package:niwa_app/features/record/state/record_state.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(historyNotifierProvider).records;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.historyTitle),
      ),
      body: records.isEmpty
          ? const _EmptyState()
          : _RecordList(records: records),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppText.historyEmpty,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _RecordList extends StatelessWidget {
  const _RecordList({required this.records});
  final List<Record> records;

  Map<String, List<Record>> _groupByDate(List<Record> records) {
    final map = <String, List<Record>>{};
    for (final r in records) {
      map.putIfAbsent(r.date, () => []).add(r);
    }
    return map;
  }

  String _formatDate(String date) {
    final dt = DateTime.parse(date);
    const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
    final weekday = weekdays[dt.weekday - 1];
    return '${dt.month}月${dt.day}日（$weekday）';
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByDate(records);
    final dates = grouped.keys.toList();

    // flatten して ListView のアイテムリストを作る
    // 各日付に対してヘッダー + 記録カードを並べる
    final items = <_ListItem>[];
    for (final date in dates) {
      items.add(_ListItem.header(date));
      for (final record in grouped[date]!) {
        items.add(_ListItem.record(record));
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.spacingMd,
        AppSizes.spacingMd,
        AppSizes.spacingMd,
        AppSizes.spacingMd,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        if (item.date != null) {
          return _DateHeader(label: _formatDate(item.date!), rawDate: item.date!);
        }
        return _RecordCard(record: item.record!);
      },
    );
  }
}

class _ListItem {
  const _ListItem.header(this.date) : record = null;
  const _ListItem.record(this.record) : date = null;

  final String? date;
  final Record? record;
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.label, required this.rawDate});
  final String label;
  final String rawDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRoute.historyDetail(rawDate));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppSizes.spacingMd,
          bottom: AppSizes.spacingSm,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.onSurfaceMuted,
                  ),
            ),
            const SizedBox(width: AppSizes.spacingXs),
            const Icon(
              Icons.chevron_right,
              size: AppSizes.spacingMd,
              color: AppColors.onSurfaceMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  const _RecordCard({required this.record});
  final Record record;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingBetweenButtons),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record.mood,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.tertiary,
                  ),
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
