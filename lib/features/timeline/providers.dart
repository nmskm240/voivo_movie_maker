import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_info.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';

part 'providers.g.dart';

@riverpod
TimelineInfo timelineInfo(Ref ref) {
  final timeline = ref.watch(loadedProjectProvider).project.timeline;
  return TimelineInfo.fromEntity(timeline);
}

@riverpod
class SelectedTimelineTrackIndex extends _$SelectedTimelineTrackIndex {
  @override
  int? build() {
    return null;
  }

  void select(int index) {
    state = index;
  }

  void clear() {
    state = null;
  }
}
