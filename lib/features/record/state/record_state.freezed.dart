// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InputSheetState {
  String get selectedMood => throw _privateConstructorUsedError;
  List<String> get selectedStamps => throw _privateConstructorUsedError;

  /// Create a copy of InputSheetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InputSheetStateCopyWith<InputSheetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputSheetStateCopyWith<$Res> {
  factory $InputSheetStateCopyWith(
    InputSheetState value,
    $Res Function(InputSheetState) then,
  ) = _$InputSheetStateCopyWithImpl<$Res, InputSheetState>;
  @useResult
  $Res call({String selectedMood, List<String> selectedStamps});
}

/// @nodoc
class _$InputSheetStateCopyWithImpl<$Res, $Val extends InputSheetState>
    implements $InputSheetStateCopyWith<$Res> {
  _$InputSheetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InputSheetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedMood = null, Object? selectedStamps = null}) {
    return _then(
      _value.copyWith(
            selectedMood: null == selectedMood
                ? _value.selectedMood
                : selectedMood // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedStamps: null == selectedStamps
                ? _value.selectedStamps
                : selectedStamps // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InputSheetStateDataImplCopyWith<$Res>
    implements $InputSheetStateCopyWith<$Res> {
  factory _$$InputSheetStateDataImplCopyWith(
    _$InputSheetStateDataImpl value,
    $Res Function(_$InputSheetStateDataImpl) then,
  ) = __$$InputSheetStateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String selectedMood, List<String> selectedStamps});
}

/// @nodoc
class __$$InputSheetStateDataImplCopyWithImpl<$Res>
    extends _$InputSheetStateCopyWithImpl<$Res, _$InputSheetStateDataImpl>
    implements _$$InputSheetStateDataImplCopyWith<$Res> {
  __$$InputSheetStateDataImplCopyWithImpl(
    _$InputSheetStateDataImpl _value,
    $Res Function(_$InputSheetStateDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InputSheetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedMood = null, Object? selectedStamps = null}) {
    return _then(
      _$InputSheetStateDataImpl(
        selectedMood: null == selectedMood
            ? _value.selectedMood
            : selectedMood // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedStamps: null == selectedStamps
            ? _value._selectedStamps
            : selectedStamps // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$InputSheetStateDataImpl
    with DiagnosticableTreeMixin
    implements _InputSheetStateData {
  const _$InputSheetStateDataImpl({
    this.selectedMood = AppText.moodOkay,
    final List<String> selectedStamps = const [],
  }) : _selectedStamps = selectedStamps;

  @override
  @JsonKey()
  final String selectedMood;
  final List<String> _selectedStamps;
  @override
  @JsonKey()
  List<String> get selectedStamps {
    if (_selectedStamps is EqualUnmodifiableListView) return _selectedStamps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStamps);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InputSheetState(selectedMood: $selectedMood, selectedStamps: $selectedStamps)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InputSheetState'))
      ..add(DiagnosticsProperty('selectedMood', selectedMood))
      ..add(DiagnosticsProperty('selectedStamps', selectedStamps));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputSheetStateDataImpl &&
            (identical(other.selectedMood, selectedMood) ||
                other.selectedMood == selectedMood) &&
            const DeepCollectionEquality().equals(
              other._selectedStamps,
              _selectedStamps,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedMood,
    const DeepCollectionEquality().hash(_selectedStamps),
  );

  /// Create a copy of InputSheetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InputSheetStateDataImplCopyWith<_$InputSheetStateDataImpl> get copyWith =>
      __$$InputSheetStateDataImplCopyWithImpl<_$InputSheetStateDataImpl>(
        this,
        _$identity,
      );
}

abstract class _InputSheetStateData implements InputSheetState {
  const factory _InputSheetStateData({
    final String selectedMood,
    final List<String> selectedStamps,
  }) = _$InputSheetStateDataImpl;

  @override
  String get selectedMood;
  @override
  List<String> get selectedStamps;

  /// Create a copy of InputSheetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InputSheetStateDataImplCopyWith<_$InputSheetStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecordState {
  List<Record> get records => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of RecordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordStateCopyWith<RecordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordStateCopyWith<$Res> {
  factory $RecordStateCopyWith(
    RecordState value,
    $Res Function(RecordState) then,
  ) = _$RecordStateCopyWithImpl<$Res, RecordState>;
  @useResult
  $Res call({List<Record> records, bool isSubmitting, String? errorMessage});
}

/// @nodoc
class _$RecordStateCopyWithImpl<$Res, $Val extends RecordState>
    implements $RecordStateCopyWith<$Res> {
  _$RecordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = null,
    Object? isSubmitting = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            records: null == records
                ? _value.records
                : records // ignore: cast_nullable_to_non_nullable
                      as List<Record>,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecordStateImplCopyWith<$Res>
    implements $RecordStateCopyWith<$Res> {
  factory _$$RecordStateImplCopyWith(
    _$RecordStateImpl value,
    $Res Function(_$RecordStateImpl) then,
  ) = __$$RecordStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Record> records, bool isSubmitting, String? errorMessage});
}

/// @nodoc
class __$$RecordStateImplCopyWithImpl<$Res>
    extends _$RecordStateCopyWithImpl<$Res, _$RecordStateImpl>
    implements _$$RecordStateImplCopyWith<$Res> {
  __$$RecordStateImplCopyWithImpl(
    _$RecordStateImpl _value,
    $Res Function(_$RecordStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = null,
    Object? isSubmitting = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$RecordStateImpl(
        records: null == records
            ? _value._records
            : records // ignore: cast_nullable_to_non_nullable
                  as List<Record>,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RecordStateImpl with DiagnosticableTreeMixin implements _RecordState {
  const _$RecordStateImpl({
    final List<Record> records = const [],
    this.isSubmitting = false,
    this.errorMessage,
  }) : _records = records;

  final List<Record> _records;
  @override
  @JsonKey()
  List<Record> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RecordState(records: $records, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RecordState'))
      ..add(DiagnosticsProperty('records', records))
      ..add(DiagnosticsProperty('isSubmitting', isSubmitting))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordStateImpl &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_records),
    isSubmitting,
    errorMessage,
  );

  /// Create a copy of RecordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordStateImplCopyWith<_$RecordStateImpl> get copyWith =>
      __$$RecordStateImplCopyWithImpl<_$RecordStateImpl>(this, _$identity);
}

abstract class _RecordState implements RecordState {
  const factory _RecordState({
    final List<Record> records,
    final bool isSubmitting,
    final String? errorMessage,
  }) = _$RecordStateImpl;

  @override
  List<Record> get records;
  @override
  bool get isSubmitting;
  @override
  String? get errorMessage;

  /// Create a copy of RecordState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordStateImplCopyWith<_$RecordStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HistoryState {
  List<Record> get records => throw _privateConstructorUsedError;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryStateCopyWith<HistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryStateCopyWith<$Res> {
  factory $HistoryStateCopyWith(
    HistoryState value,
    $Res Function(HistoryState) then,
  ) = _$HistoryStateCopyWithImpl<$Res, HistoryState>;
  @useResult
  $Res call({List<Record> records});
}

/// @nodoc
class _$HistoryStateCopyWithImpl<$Res, $Val extends HistoryState>
    implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? records = null}) {
    return _then(
      _value.copyWith(
            records: null == records
                ? _value.records
                : records // ignore: cast_nullable_to_non_nullable
                      as List<Record>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HistoryStateImplCopyWith<$Res>
    implements $HistoryStateCopyWith<$Res> {
  factory _$$HistoryStateImplCopyWith(
    _$HistoryStateImpl value,
    $Res Function(_$HistoryStateImpl) then,
  ) = __$$HistoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Record> records});
}

/// @nodoc
class __$$HistoryStateImplCopyWithImpl<$Res>
    extends _$HistoryStateCopyWithImpl<$Res, _$HistoryStateImpl>
    implements _$$HistoryStateImplCopyWith<$Res> {
  __$$HistoryStateImplCopyWithImpl(
    _$HistoryStateImpl _value,
    $Res Function(_$HistoryStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? records = null}) {
    return _then(
      _$HistoryStateImpl(
        records: null == records
            ? _value._records
            : records // ignore: cast_nullable_to_non_nullable
                  as List<Record>,
      ),
    );
  }
}

/// @nodoc

class _$HistoryStateImpl with DiagnosticableTreeMixin implements _HistoryState {
  const _$HistoryStateImpl({final List<Record> records = const []})
    : _records = records;

  final List<Record> _records;
  @override
  @JsonKey()
  List<Record> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HistoryState(records: $records)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HistoryState'))
      ..add(DiagnosticsProperty('records', records));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryStateImpl &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_records));

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryStateImplCopyWith<_$HistoryStateImpl> get copyWith =>
      __$$HistoryStateImplCopyWithImpl<_$HistoryStateImpl>(this, _$identity);
}

abstract class _HistoryState implements HistoryState {
  const factory _HistoryState({final List<Record> records}) =
      _$HistoryStateImpl;

  @override
  List<Record> get records;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryStateImplCopyWith<_$HistoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
