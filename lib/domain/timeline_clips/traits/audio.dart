import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

part 'audio.g.dart';

@JsonSerializable()
class ClipAudio {
  const ClipAudio({this.volume = 1, this.muted = false}) : assert(volume >= 0);

  factory ClipAudio.fromJson(Map<String, Object?> json) =>
      _$ClipAudioFromJson(json);

  final double volume;
  final bool muted;

  Map<String, Object?> toJson() => _$ClipAudioToJson(this);
}

mixin AudibleClip on TimelineClip {
  ClipAudio get audio;
}
