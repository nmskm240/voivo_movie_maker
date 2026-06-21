// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

part 'timeline_clip_view_model.g.dart';

@Riverpod(dependencies: [TimelineSelectionState])
bool timelineClipIsSelected(Ref ref, TimelineClipId clipId) {
  return ref.watch(timelineSelectionStateProvider).clipId == clipId;
}

@Riverpod(dependencies: [TimelineViewModel, TimelineSelectionState])
class TimelineClipViewModel extends _$TimelineClipViewModel {
  @override
  void build() {}

  void select(TimelineClipId clipId) {
    ref.read(timelineSelectionStateProvider.notifier).selectClip(clipId);
  }

  Future<bool> remove(TimelineClipId clipId) {
    return ref.read(timelineViewModelProvider.notifier).removeClip(clipId);
  }

  Future<bool> resize(
    TimelineClipId clipId, {
    required int startFrame,
    required int durationFrames,
  }) {
    return ref
        .read(timelineViewModelProvider.notifier)
        .resizeClip(
          clipId,
          startFrame: startFrame,
          durationFrames: durationFrames,
        );
  }
}
