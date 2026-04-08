import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niwa_app/common/constants/app_text.dart';
import 'package:niwa_app/features/record/models/record.dart';
import 'package:niwa_app/features/record/repository/record_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_state.freezed.dart';
part 'record_state.g.dart';

@freezed
abstract class InputSheetState with _$InputSheetState {
  const factory InputSheetState({
    @Default(AppText.moodOkay) String selectedMood,
    @Default([]) List<String> selectedStamps,
  }) = _InputSheetStateData;
}

@riverpod
class InputSheetNotifier extends _$InputSheetNotifier {
  @override
  InputSheetState build() => const InputSheetState();

  void selectMood(String mood) {
    state = state.copyWith(selectedMood: mood);
  }

  void toggleStamp(String stamp) {
    final current = state.selectedStamps;
    final updated = current.contains(stamp)
        ? current.where((s) => s != stamp).toList()
        : [...current, stamp];
    state = state.copyWith(selectedStamps: updated);
  }
}

@freezed
abstract class RecordState with _$RecordState {
  const factory RecordState({
    @Default([]) List<Record> records,
    @Default(false) bool isSubmitting,
    String? errorMessage,
  }) = _RecordState;
}

@riverpod
class RecordNotifier extends _$RecordNotifier {
  @override
  RecordState build() {
    final today = _today();
    ref.watch(recordRepositoryProvider).watchTodayRecords(today).listen((records) {
      state = state.copyWith(records: records);
    });
    return const RecordState();
  }

  Future<void> addRecord({
    required String mood,
    required String text,
    required List<String> stamps,
  }) async {
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      await ref.read(recordRepositoryProvider).addRecord(
            mood: mood,
            text: text,
            date: _today(),
            stamps: stamps,
          );
    } catch (e) {
      debugPrint('[ERROR] record.addRecord: $e');
      state = state.copyWith(errorMessage: AppText.errorRecord);
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }

  String _today() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }
}
