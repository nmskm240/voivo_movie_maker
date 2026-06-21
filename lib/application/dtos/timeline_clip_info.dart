// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

part 'timeline_clip_info.freezed.dart';

@freezed
sealed class TimelineClipInfo with _$TimelineClipInfo {
  const factory TimelineClipInfo({
    required TimelineClipId id,
    required int startFrame,
    required int durationFrames,
    @Default(false) bool hasAudio,
    @Default(false) bool hasVideo,
    AssetId? audioAssetId,
    AssetId? videoAssetId,
  }) = _TimelineClipInfo;

  factory TimelineClipInfo.fromEntity(TimelineClip entity) {
    final audio = entity.component<AudioComponent>();
    final video = entity.component<VideoComponent>();
    return TimelineClipInfo(
      id: entity.id,
      startFrame: entity.startFrame,
      durationFrames: entity.durationFrames,
      hasAudio: audio != null,
      hasVideo: video != null,
      audioAssetId: audio?.assetId,
      videoAssetId: video?.assetId,
    );
  }
}
