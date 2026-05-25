// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timelineInfo)
final timelineInfoProvider = TimelineInfoProvider._();

final class TimelineInfoProvider
    extends $FunctionalProvider<TimelineInfo, TimelineInfo, TimelineInfo>
    with $Provider<TimelineInfo> {
  TimelineInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timelineInfoHash();

  @$internal
  @override
  $ProviderElement<TimelineInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimelineInfo create(Ref ref) {
    return timelineInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimelineInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimelineInfo>(value),
    );
  }
}

String _$timelineInfoHash() => r'9e45ef1897df01bf96abab7c2af9ea8bc5c99fd7';

@ProviderFor(SelectedTimelineTrackIndex)
final selectedTimelineTrackIndexProvider =
    SelectedTimelineTrackIndexProvider._();

final class SelectedTimelineTrackIndexProvider
    extends $NotifierProvider<SelectedTimelineTrackIndex, int?> {
  SelectedTimelineTrackIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTimelineTrackIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTimelineTrackIndexHash();

  @$internal
  @override
  SelectedTimelineTrackIndex create() => SelectedTimelineTrackIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$selectedTimelineTrackIndexHash() =>
    r'03ccfb34d51ab149886efd040667f18f77eda0d3';

abstract class _$SelectedTimelineTrackIndex extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
