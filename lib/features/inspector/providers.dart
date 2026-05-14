import 'package:riverpod_annotation/riverpod_annotation.dart';
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
