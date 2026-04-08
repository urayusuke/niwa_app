// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmotionSummaryImpl _$$EmotionSummaryImplFromJson(Map<String, dynamic> json) =>
    _$EmotionSummaryImpl(
      positiveRate: (json['positive_rate'] as num).toInt(),
      trend: json['trend'] as String,
      summary: json['summary'] as String,
    );

Map<String, dynamic> _$$EmotionSummaryImplToJson(
  _$EmotionSummaryImpl instance,
) => <String, dynamic>{
  'positive_rate': instance.positiveRate,
  'trend': instance.trend,
  'summary': instance.summary,
};

_$AiFeedbackImpl _$$AiFeedbackImplFromJson(Map<String, dynamic> json) =>
    _$AiFeedbackImpl(
      date: json['date'] as String,
      affirmation: json['affirmation'] as String,
      emotion: EmotionSummary.fromJson(json['emotion'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$$AiFeedbackImplToJson(_$AiFeedbackImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'affirmation': instance.affirmation,
      'emotion': instance.emotion,
      'steps': instance.steps,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };
