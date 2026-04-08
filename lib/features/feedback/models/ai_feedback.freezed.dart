// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_feedback.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmotionSummary _$EmotionSummaryFromJson(Map<String, dynamic> json) {
  return _EmotionSummary.fromJson(json);
}

/// @nodoc
mixin _$EmotionSummary {
  @JsonKey(name: 'positive_rate')
  int get positiveRate => throw _privateConstructorUsedError;
  String get trend => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;

  /// Serializes this EmotionSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmotionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmotionSummaryCopyWith<EmotionSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmotionSummaryCopyWith<$Res> {
  factory $EmotionSummaryCopyWith(
    EmotionSummary value,
    $Res Function(EmotionSummary) then,
  ) = _$EmotionSummaryCopyWithImpl<$Res, EmotionSummary>;
  @useResult
  $Res call({
    @JsonKey(name: 'positive_rate') int positiveRate,
    String trend,
    String summary,
  });
}

/// @nodoc
class _$EmotionSummaryCopyWithImpl<$Res, $Val extends EmotionSummary>
    implements $EmotionSummaryCopyWith<$Res> {
  _$EmotionSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmotionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positiveRate = null,
    Object? trend = null,
    Object? summary = null,
  }) {
    return _then(
      _value.copyWith(
            positiveRate: null == positiveRate
                ? _value.positiveRate
                : positiveRate // ignore: cast_nullable_to_non_nullable
                      as int,
            trend: null == trend
                ? _value.trend
                : trend // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmotionSummaryImplCopyWith<$Res>
    implements $EmotionSummaryCopyWith<$Res> {
  factory _$$EmotionSummaryImplCopyWith(
    _$EmotionSummaryImpl value,
    $Res Function(_$EmotionSummaryImpl) then,
  ) = __$$EmotionSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'positive_rate') int positiveRate,
    String trend,
    String summary,
  });
}

/// @nodoc
class __$$EmotionSummaryImplCopyWithImpl<$Res>
    extends _$EmotionSummaryCopyWithImpl<$Res, _$EmotionSummaryImpl>
    implements _$$EmotionSummaryImplCopyWith<$Res> {
  __$$EmotionSummaryImplCopyWithImpl(
    _$EmotionSummaryImpl _value,
    $Res Function(_$EmotionSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmotionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positiveRate = null,
    Object? trend = null,
    Object? summary = null,
  }) {
    return _then(
      _$EmotionSummaryImpl(
        positiveRate: null == positiveRate
            ? _value.positiveRate
            : positiveRate // ignore: cast_nullable_to_non_nullable
                  as int,
        trend: null == trend
            ? _value.trend
            : trend // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmotionSummaryImpl implements _EmotionSummary {
  const _$EmotionSummaryImpl({
    @JsonKey(name: 'positive_rate') required this.positiveRate,
    required this.trend,
    required this.summary,
  });

  factory _$EmotionSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmotionSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'positive_rate')
  final int positiveRate;
  @override
  final String trend;
  @override
  final String summary;

  @override
  String toString() {
    return 'EmotionSummary(positiveRate: $positiveRate, trend: $trend, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmotionSummaryImpl &&
            (identical(other.positiveRate, positiveRate) ||
                other.positiveRate == positiveRate) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, positiveRate, trend, summary);

  /// Create a copy of EmotionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmotionSummaryImplCopyWith<_$EmotionSummaryImpl> get copyWith =>
      __$$EmotionSummaryImplCopyWithImpl<_$EmotionSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmotionSummaryImplToJson(this);
  }
}

abstract class _EmotionSummary implements EmotionSummary {
  const factory _EmotionSummary({
    @JsonKey(name: 'positive_rate') required final int positiveRate,
    required final String trend,
    required final String summary,
  }) = _$EmotionSummaryImpl;

  factory _EmotionSummary.fromJson(Map<String, dynamic> json) =
      _$EmotionSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'positive_rate')
  int get positiveRate;
  @override
  String get trend;
  @override
  String get summary;

  /// Create a copy of EmotionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmotionSummaryImplCopyWith<_$EmotionSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiFeedback _$AiFeedbackFromJson(Map<String, dynamic> json) {
  return _AiFeedback.fromJson(json);
}

/// @nodoc
mixin _$AiFeedback {
  String get date => throw _privateConstructorUsedError;
  String get affirmation => throw _privateConstructorUsedError;
  EmotionSummary get emotion => throw _privateConstructorUsedError;
  List<String> get steps => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this AiFeedback to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiFeedbackCopyWith<AiFeedback> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiFeedbackCopyWith<$Res> {
  factory $AiFeedbackCopyWith(
    AiFeedback value,
    $Res Function(AiFeedback) then,
  ) = _$AiFeedbackCopyWithImpl<$Res, AiFeedback>;
  @useResult
  $Res call({
    String date,
    String affirmation,
    EmotionSummary emotion,
    List<String> steps,
    DateTime generatedAt,
  });

  $EmotionSummaryCopyWith<$Res> get emotion;
}

/// @nodoc
class _$AiFeedbackCopyWithImpl<$Res, $Val extends AiFeedback>
    implements $AiFeedbackCopyWith<$Res> {
  _$AiFeedbackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? affirmation = null,
    Object? emotion = null,
    Object? steps = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            affirmation: null == affirmation
                ? _value.affirmation
                : affirmation // ignore: cast_nullable_to_non_nullable
                      as String,
            emotion: null == emotion
                ? _value.emotion
                : emotion // ignore: cast_nullable_to_non_nullable
                      as EmotionSummary,
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            generatedAt: null == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of AiFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmotionSummaryCopyWith<$Res> get emotion {
    return $EmotionSummaryCopyWith<$Res>(_value.emotion, (value) {
      return _then(_value.copyWith(emotion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AiFeedbackImplCopyWith<$Res>
    implements $AiFeedbackCopyWith<$Res> {
  factory _$$AiFeedbackImplCopyWith(
    _$AiFeedbackImpl value,
    $Res Function(_$AiFeedbackImpl) then,
  ) = __$$AiFeedbackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    String affirmation,
    EmotionSummary emotion,
    List<String> steps,
    DateTime generatedAt,
  });

  @override
  $EmotionSummaryCopyWith<$Res> get emotion;
}

/// @nodoc
class __$$AiFeedbackImplCopyWithImpl<$Res>
    extends _$AiFeedbackCopyWithImpl<$Res, _$AiFeedbackImpl>
    implements _$$AiFeedbackImplCopyWith<$Res> {
  __$$AiFeedbackImplCopyWithImpl(
    _$AiFeedbackImpl _value,
    $Res Function(_$AiFeedbackImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? affirmation = null,
    Object? emotion = null,
    Object? steps = null,
    Object? generatedAt = null,
  }) {
    return _then(
      _$AiFeedbackImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        affirmation: null == affirmation
            ? _value.affirmation
            : affirmation // ignore: cast_nullable_to_non_nullable
                  as String,
        emotion: null == emotion
            ? _value.emotion
            : emotion // ignore: cast_nullable_to_non_nullable
                  as EmotionSummary,
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        generatedAt: null == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiFeedbackImpl implements _AiFeedback {
  const _$AiFeedbackImpl({
    required this.date,
    required this.affirmation,
    required this.emotion,
    required final List<String> steps,
    required this.generatedAt,
  }) : _steps = steps;

  factory _$AiFeedbackImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiFeedbackImplFromJson(json);

  @override
  final String date;
  @override
  final String affirmation;
  @override
  final EmotionSummary emotion;
  final List<String> _steps;
  @override
  List<String> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'AiFeedback(date: $date, affirmation: $affirmation, emotion: $emotion, steps: $steps, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiFeedbackImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.affirmation, affirmation) ||
                other.affirmation == affirmation) &&
            (identical(other.emotion, emotion) || other.emotion == emotion) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    affirmation,
    emotion,
    const DeepCollectionEquality().hash(_steps),
    generatedAt,
  );

  /// Create a copy of AiFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiFeedbackImplCopyWith<_$AiFeedbackImpl> get copyWith =>
      __$$AiFeedbackImplCopyWithImpl<_$AiFeedbackImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiFeedbackImplToJson(this);
  }
}

abstract class _AiFeedback implements AiFeedback {
  const factory _AiFeedback({
    required final String date,
    required final String affirmation,
    required final EmotionSummary emotion,
    required final List<String> steps,
    required final DateTime generatedAt,
  }) = _$AiFeedbackImpl;

  factory _AiFeedback.fromJson(Map<String, dynamic> json) =
      _$AiFeedbackImpl.fromJson;

  @override
  String get date;
  @override
  String get affirmation;
  @override
  EmotionSummary get emotion;
  @override
  List<String> get steps;
  @override
  DateTime get generatedAt;

  /// Create a copy of AiFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiFeedbackImplCopyWith<_$AiFeedbackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
