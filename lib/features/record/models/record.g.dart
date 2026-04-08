// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecordImpl _$$RecordImplFromJson(Map<String, dynamic> json) => _$RecordImpl(
  id: json['id'] as String,
  mood: json['mood'] as String,
  text: json['text'] as String,
  date: json['date'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  stamps:
      (json['stamps'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$RecordImplToJson(_$RecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mood': instance.mood,
      'text': instance.text,
      'date': instance.date,
      'createdAt': instance.createdAt.toIso8601String(),
      'stamps': instance.stamps,
    };
