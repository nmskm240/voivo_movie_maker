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
          projectProvider,
          addAudioClipToTimelineProvider,
          addImageClipToTimelineProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          TimelineViewModelProvider.$allTransitiveDependencies0,
          TimelineViewModelProvider.$allTransitiveDependencies1,
          TimelineViewModelProvider.$allTransitiveDependencies2,
          TimelineViewModelProvider.$allTransitiveDependencies3,
          TimelineViewModelProvider.$allTransitiveDependencies4,
          TimelineViewModelProvider.$allTransitiveDependencies5,
          TimelineViewModelProvider.$allTransitiveDependencies6,
          TimelineViewModelProvider.$allTransitiveDependencies7,
          TimelineViewModelProvider.$allTransitiveDependencies8,
          TimelineViewModelProvider.$allTransitiveDependencies9,
          TimelineViewModelProvider.$allTransitiveDependencies10,
          TimelineViewModelProvider.$allTransitiveDependencies11,
        },
      );

  static final $allTransitiveDependencies0 = timelineProvider;
  static final $allTransitiveDependencies1 =
      TimelineNotifierProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      TimelineNotifierProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 = timelineEditorProvider;
  static final $allTransitiveDependencies4 =
      TimelineEditorProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies5 = playbackControllerProvider;
  static final $allTransitiveDependencies6 = timelineSelectionStateProvider;
  static final $allTransitiveDependencies7 = addAudioClipToTimelineProvider;
  static final $allTransitiveDependencies8 =
      AddAudioClipToTimelineProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies9 =
      AddAudioClipToTimelineProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies10 = addImageClipToTimelineProvider;
  static final $allTransitiveDependencies11 =
      AddImageClipToTimelineProvider.$allTransitiveDependencies2;

  @override
  String debugGetCreateSourceHash() => _$timelineViewModelHash();

  @$internal
  @override
  TimelineViewModel create() => TimelineViewModel();
}

String _$timelineViewModelHash() => r'bd73f5d00fba34c3257d390d4583501c71bcff9d';

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
