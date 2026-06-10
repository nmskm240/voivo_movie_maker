import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';

part 'audio.g.dart';

@JsonSerializable()
class AudioComponent extends ClipComponent {
  AudioComponent({this.volume = 1, this.muted = false, super.id})
    : assert(volume >= 0);

  factory AudioComponent.fromJson(Map<String, Object?> json) =>
      _$AudioComponentFromJson(json);

  double volume;
  bool muted;

  @override
  int get maxInstancesPerClip => 1;

  Map<String, Object?> toJson() => _$AudioComponentToJson(this);
}
