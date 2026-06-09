// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TimelineViewModel)
final timelineViewModelProvider = TimelineViewModelProvider._();

final class TimelineViewModelProvider
    extends $AsyncNotifierProvider<TimelineViewModel, TimelineViewState> {
  TimelineViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timelineViewModelProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[timelineProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          TimelineViewModelProvider.$allTransitiveDependencies0,
          TimelineViewModelProvider.$allTransitiveDependencies1,
          TimelineViewModelProvider.$allTransitiveDependencies2,
        ],
      );

  static final $allTransitiveDependencies0 = timelineProvider;
  static final $allTransitiveDependencies1 =
      CurrentTimelineProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      CurrentTimelineProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$timelineViewModelHash();

  @$internal
  @override
  TimelineViewModel create() => TimelineViewModel();
}

String _$timelineViewModelHash() => r'fa7f75bcd7337ee46187b57b80dd91c753868f74';

abstract class _$TimelineViewModel extends $AsyncNotifier<TimelineViewState> {
  FutureOr<TimelineViewState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<TimelineViewState>, TimelineViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TimelineViewState>, TimelineViewState>,
              AsyncValue<TimelineViewState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
