// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_select_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TimelineSelectionState)
final timelineSelectionStateProvider = TimelineSelectionStateProvider._();

final class TimelineSelectionStateProvider
    extends $NotifierProvider<TimelineSelectionState, TimelineSelection> {
  TimelineSelectionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineSelectionStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timelineSelectionStateHash();

  @$internal
  @override
  TimelineSelectionState create() => TimelineSelectionState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimelineSelection value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimelineSelection>(value),
    );
  }
}

String _$timelineSelectionStateHash() =>
    r'7cb1aca8a396f8cdb1261f222bf21129d4701f15';

abstract class _$TimelineSelectionState extends $Notifier<TimelineSelection> {
  TimelineSelection build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TimelineSelection, TimelineSelection>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TimelineSelection, TimelineSelection>,
              TimelineSelection,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
