// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedTimelineClipId)
final selectedTimelineClipIdProvider = SelectedTimelineClipIdProvider._();

final class SelectedTimelineClipIdProvider
    extends $NotifierProvider<SelectedTimelineClipId, TimelineClipId?> {
  SelectedTimelineClipIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTimelineClipIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTimelineClipIdHash();

  @$internal
  @override
  SelectedTimelineClipId create() => SelectedTimelineClipId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimelineClipId? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimelineClipId?>(value),
    );
  }
}

String _$selectedTimelineClipIdHash() =>
    r'd424733cae1c0303ed5ef0017d91e31379fff343';

abstract class _$SelectedTimelineClipId extends $Notifier<TimelineClipId?> {
  TimelineClipId? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TimelineClipId?, TimelineClipId?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TimelineClipId?, TimelineClipId?>,
              TimelineClipId?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
