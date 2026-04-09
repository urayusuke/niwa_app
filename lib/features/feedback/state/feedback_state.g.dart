// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedbackByDateHash() => r'93db945a8f52aa15e566c05e674fb0e7e297efc5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [feedbackByDate].
@ProviderFor(feedbackByDate)
const feedbackByDateProvider = FeedbackByDateFamily();

/// See also [feedbackByDate].
class FeedbackByDateFamily extends Family<AsyncValue<AiFeedback?>> {
  /// See also [feedbackByDate].
  const FeedbackByDateFamily();

  /// See also [feedbackByDate].
  FeedbackByDateProvider call(String date) {
    return FeedbackByDateProvider(date);
  }

  @override
  FeedbackByDateProvider getProviderOverride(
    covariant FeedbackByDateProvider provider,
  ) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'feedbackByDateProvider';
}

/// See also [feedbackByDate].
class FeedbackByDateProvider extends AutoDisposeStreamProvider<AiFeedback?> {
  /// See also [feedbackByDate].
  FeedbackByDateProvider(String date)
    : this._internal(
        (ref) => feedbackByDate(ref as FeedbackByDateRef, date),
        from: feedbackByDateProvider,
        name: r'feedbackByDateProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$feedbackByDateHash,
        dependencies: FeedbackByDateFamily._dependencies,
        allTransitiveDependencies:
            FeedbackByDateFamily._allTransitiveDependencies,
        date: date,
      );

  FeedbackByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final String date;

  @override
  Override overrideWith(
    Stream<AiFeedback?> Function(FeedbackByDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FeedbackByDateProvider._internal(
        (ref) => create(ref as FeedbackByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<AiFeedback?> createElement() {
    return _FeedbackByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedbackByDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeedbackByDateRef on AutoDisposeStreamProviderRef<AiFeedback?> {
  /// The parameter `date` of this provider.
  String get date;
}

class _FeedbackByDateProviderElement
    extends AutoDisposeStreamProviderElement<AiFeedback?>
    with FeedbackByDateRef {
  _FeedbackByDateProviderElement(super.provider);

  @override
  String get date => (origin as FeedbackByDateProvider).date;
}

String _$todayFeedbackHash() => r'151084edcadf56418b92393afd6252a9aa57e4ae';

/// See also [todayFeedback].
@ProviderFor(todayFeedback)
final todayFeedbackProvider = AutoDisposeStreamProvider<AiFeedback?>.internal(
  todayFeedback,
  name: r'todayFeedbackProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayFeedbackHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayFeedbackRef = AutoDisposeStreamProviderRef<AiFeedback?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
