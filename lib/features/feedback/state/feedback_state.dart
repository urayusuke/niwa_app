import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niwa_app/features/feedback/models/ai_feedback.dart';
import 'package:niwa_app/features/feedback/repository/feedback_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feedback_state.g.dart';

@riverpod
Stream<AiFeedback?> todayFeedback(Ref ref) {
  final today = _today();
  return ref
      .watch(feedbackRepositoryProvider)
      .watchTodayFeedback(today)
      .handleError((Object e) {
    debugPrint('[ERROR] feedback.watchTodayFeedback: $e');
  });
}

String _today() {
  final now = DateTime.now();
  return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
}
