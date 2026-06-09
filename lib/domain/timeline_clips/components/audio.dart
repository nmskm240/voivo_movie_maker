import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';

part 'audio.g.dart';

@JsonSerializable()
class AudioComponent implements ClipComponent {
  AudioComponent({this.volume = 1, this.muted = false}) : assert(volume >= 0);

  factory AudioComponent.fromJson(Map<String, Object?> json) =>
      _$AudioComponentFromJson(json);

  double volume;
  bool muted;

  Map<String, Object?> toJson() => _$AudioComponentToJson(this);
}
