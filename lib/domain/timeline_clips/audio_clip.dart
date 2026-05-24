import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/json_converters.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/traits/audio.dart';

part 'audio_clip.g.dart';

@JsonSerializable(explicitToJson: true)
class AudioClip extends TimelineClip with AudibleClip {
  AudioClip({
    required super.id,
    required super.startFrame,
    required this.assetId,
    super.durationFrames,
    ClipAudio? audio,
  }) : audio = audio ?? const ClipAudio();

  factory AudioClip.fromJson(Map<String, Object?> json) =>
      _$AudioClipFromJson(json);

  @override
  @JsonKey(includeFromJson: false)
  TimelineClipKind get kind => TimelineClipKind.audio;
  @override
  final ClipAudio audio;
  @TimelineClipIdJsonConverter()
  @override
  TimelineClipId get id => super.id;
  @AssetIdJsonConverter()
  AssetId assetId;

  Map<String, Object?> toJson() {
    return {..._$AudioClipToJson(this), 'kind': kind.name};
  }

  void update({AssetId? assetId}) {
    this.assetId = assetId ?? this.assetId;
  }
}
