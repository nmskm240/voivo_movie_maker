// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/timeline_clip_info.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';

part 'timeline_track_info.freezed.dart';

@freezed
sealed class TimelineTrackInfo with _$TimelineTrackInfo {
  const factory TimelineTrackInfo({required List<TimelineClipInfo> clips}) =
      _TimelineTrackInfo;

  factory TimelineTrackInfo.fromEntity(TimelineTrack entity) {
    return TimelineTrackInfo(
      clips: entity.clips.map(TimelineClipInfo.fromEntity).toList(),
    );
  }
}
