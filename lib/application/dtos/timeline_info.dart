import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_track_info.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part 'timeline_info.freezed.dart';

@freezed
sealed class TimelineInfo with _$TimelineInfo {
  const factory TimelineInfo({required List<TimelineTrackInfo> tracks}) =
      _TimelineInfo;

  factory TimelineInfo.fromEntity(Timeline entity) {
    return TimelineInfo(
      tracks: entity.tracks.map(TimelineTrackInfo.fromEntity).toList(),
    );
  }
}
