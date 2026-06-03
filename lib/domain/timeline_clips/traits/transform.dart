import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

part 'transform.g.dart';

@JsonSerializable()
class ClipTransform {
  ClipTransform({Vector2? position, Vector2? scale, this.rotation = 0})
    : position = position ?? Vector2.zero(),
      scale = scale ?? Vector2.all(1);

  factory ClipTransform.fromJson(Map<String, Object?> json) =>
      _$ClipTransformFromJson(json);

  @Vector2JsonConverter()
  Vector2 position;
  @Vector2JsonConverter()
  Vector2 scale;
  double rotation;

  Map<String, Object?> toJson() => _$ClipTransformToJson(this);
}

mixin WithTransform on TimelineClip {
  ClipTransform get transform;

  void updateTransform({Vector2? position, Vector2? scale, double? rotation}) {
    transform.position = position ?? transform.position;
    transform.scale = scale ?? transform.scale;
    transform.rotation = rotation ?? transform.rotation;
  }
}
