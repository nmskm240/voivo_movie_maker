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
        dependencies: <ProviderOrFamily>[
          timelineProvider,
          timelineEditorProvider,
          playbackControllerProvider,
          timelineSelectionStateProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          TimelineViewModelProvider.$allTransitiveDependencies0,
          TimelineViewModelProvider.$allTransitiveDependencies1,
          TimelineViewModelProvider.$allTransitiveDependencies2,
          TimelineViewModelProvider.$allTransitiveDependencies3,
          TimelineViewModelProvider.$allTransitiveDependencies4,
          TimelineViewModelProvider.$allTransitiveDependencies5,
        },
      );

  static final $allTransitiveDependencies0 = timelineProvider;
  static final $allTransitiveDependencies1 =
      TimelineNotifierProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      TimelineNotifierProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 = timelineEditorProvider;
  static final $allTransitiveDependencies4 = playbackControllerProvider;
  static final $allTransitiveDependencies5 = timelineSelectionStateProvider;

  @override
  String debugGetCreateSourceHash() => _$timelineViewModelHash();

  @$internal
  @override
  TimelineViewModel create() => TimelineViewModel();
}

String _$timelineViewModelHash() => r'9e0384c0d05dec3af4d9b623ba9a1fe3e5a18fe4';

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
