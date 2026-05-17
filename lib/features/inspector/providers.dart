import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

part 'providers.g.dart';

@riverpod
class SelectedTimelineClipId extends _$SelectedTimelineClipId {
  @override
  TimelineClipId? build() {
    return null;
  }

  void select(TimelineClipId clipId) {
    state = clipId;
  }

  void clear() {
    state = null;
  }
}

@riverpod
TimelineClip? selectedTimelineClip(Ref ref) {
  final selectedClipId = ref.watch(selectedTimelineClipIdProvider);
  if (selectedClipId == null) {
    return null;
  }

  final timeline = ref.watch(loadedProjectProvider).project.timeline;
  for (final clip in timeline.tracks.expand((track) => track.clips)) {
    if (clip.id == selectedClipId) {
      return clip;
    }
  }
  return null;
}
