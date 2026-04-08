import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_feedback.freezed.dart';
part 'ai_feedback.g.dart';

@freezed
abstract class EmotionSummary with _$EmotionSummary {
  const factory EmotionSummary({
    @JsonKey(name: 'positive_rate') required int positiveRate,
    required String trend,
    required String summary,
  }) = _EmotionSummary;

  factory EmotionSummary.fromJson(Map<String, dynamic> json) =>
      _$EmotionSummaryFromJson(json);
}

@freezed
abstract class AiFeedback with _$AiFeedback {
  const factory AiFeedback({
    required String date,
    required String affirmation,
    required EmotionSummary emotion,
    required List<String> steps,
    required DateTime generatedAt,
  }) = _AiFeedback;

  factory AiFeedback.fromJson(Map<String, dynamic> json) =>
      _$AiFeedbackFromJson(json);
}
