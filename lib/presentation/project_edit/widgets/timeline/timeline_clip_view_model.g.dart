// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_clip_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timelineClipIsSelected)
final timelineClipIsSelectedProvider = TimelineClipIsSelectedFamily._();

final class TimelineClipIsSelectedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  TimelineClipIsSelectedProvider._({
    required TimelineClipIsSelectedFamily super.from,
    required TimelineClipId super.argument,
  }) : super(
         retry: null,
         name: r'timelineClipIsSelectedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = timelineSelectionStateProvider;

  @override
  String debugGetCreateSourceHash() => _$timelineClipIsSelectedHash();

  @override
  String toString() {
    return r'timelineClipIsSelectedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as TimelineClipId;
    return timelineClipIsSelected(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TimelineClipIsSelectedProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$timelineClipIsSelectedHash() =>
    r'526566abc6d30f9d57d9a0977dafb1fe0b84948b';

final class TimelineClipIsSelectedFamily extends $Family
    with $FunctionalFamilyOverride<bool, TimelineClipId> {
  TimelineClipIsSelectedFamily._()
    : super(
        retry: null,
        name: r'timelineClipIsSelectedProvider',
        dependencies: <ProviderOrFamily>[timelineSelectionStateProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          TimelineClipIsSelectedProvider.$allTransitiveDependencies0,
        ],
        isAutoDispose: true,
      );

  TimelineClipIsSelectedProvider call(TimelineClipId clipId) =>
      TimelineClipIsSelectedProvider._(argument: clipId, from: this);

  @override
  String toString() => r'timelineClipIsSelectedProvider';
}

@ProviderFor(TimelineClipViewModel)
final timelineClipViewModelProvider = TimelineClipViewModelProvider._();

final class TimelineClipViewModelProvider
    extends $NotifierProvider<TimelineClipViewModel, void> {
  TimelineClipViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineClipViewModelProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[
          timelineViewModelProvider,
          timelineSelectionStateProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          TimelineClipViewModelProvider.$allTransitiveDependencies0,
          TimelineClipViewModelProvider.$allTransitiveDependencies1,
          TimelineClipViewModelProvider.$allTransitiveDependencies2,
          TimelineClipViewModelProvider.$allTransitiveDependencies3,
          TimelineClipViewModelProvider.$allTransitiveDependencies4,
          TimelineClipViewModelProvider.$allTransitiveDependencies5,
          TimelineClipViewModelProvider.$allTransitiveDependencies6,
          TimelineClipViewModelProvider.$allTransitiveDependencies7,
          TimelineClipViewModelProvider.$allTransitiveDependencies8,
          TimelineClipViewModelProvider.$allTransitiveDependencies9,
          TimelineClipViewModelProvider.$allTransitiveDependencies10,
          TimelineClipViewModelProvider.$allTransitiveDependencies11,
          TimelineClipViewModelProvider.$allTransitiveDependencies12,
          TimelineClipViewModelProvider.$allTransitiveDependencies13,
        },
      );

  static final $allTransitiveDependencies0 = timelineViewModelProvider;
  static final $allTransitiveDependencies1 =
      TimelineViewModelProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      TimelineViewModelProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      TimelineViewModelProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      TimelineViewModelProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
      TimelineViewModelProvider.$allTransitiveDependencies4;
  static final $allTransitiveDependencies6 =
      TimelineViewModelProvider.$allTransitiveDependencies5;
  static final $allTransitiveDependencies7 =
      TimelineViewModelProvider.$allTransitiveDependencies6;
  static final $allTransitiveDependencies8 =
      TimelineViewModelProvider.$allTransitiveDependencies7;
  static final $allTransitiveDependencies9 =
      TimelineViewModelProvider.$allTransitiveDependencies8;
  static final $allTransitiveDependencies10 =
      TimelineViewModelProvider.$allTransitiveDependencies9;
  static final $allTransitiveDependencies11 =
      TimelineViewModelProvider.$allTransitiveDependencies10;
  static final $allTransitiveDependencies12 =
      TimelineViewModelProvider.$allTransitiveDependencies11;
  static final $allTransitiveDependencies13 =
      TimelineViewModelProvider.$allTransitiveDependencies12;

  @override
  String debugGetCreateSourceHash() => _$timelineClipViewModelHash();

  @$internal
  @override
  TimelineClipViewModel create() => TimelineClipViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$timelineClipViewModelHash() =>
    r'754328a8a0dcb4a1d010adb5bc756445bb6048ec';

abstract class _$TimelineClipViewModel extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
