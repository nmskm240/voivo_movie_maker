// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

part 'timeline_clip_info.freezed.dart';

@freezed
sealed class TimelineClipInfo with _$TimelineClipInfo {
  const factory TimelineClipInfo({
    required TimelineClipId id,
    required int startFrame,
    required int durationFrames,
  }) = _TimelineClipInfo;

  factory TimelineClipInfo.fromEntity(TimelineClip entity) {
    return TimelineClipInfo(
      id: entity.id,
      startFrame: entity.startFrame,
      durationFrames: entity.durationFrames,
    );
  }
}
