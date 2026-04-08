import 'package:freezed_annotation/freezed_annotation.dart';

part 'record.freezed.dart';
part 'record.g.dart';

@freezed
abstract class Record with _$Record {
  const factory Record({
    required String id,
    required String mood,
    required String text,
    required String date,
    required DateTime createdAt,
    @Default([]) List<String> stamps,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
