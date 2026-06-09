import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';

part 'transform.g.dart';

@JsonSerializable()
class TransformComponent implements ClipComponent {
  TransformComponent({Vector2? position, Vector2? scale, this.rotation = 0})
    : position = position ?? Vector2.zero(),
      scale = scale ?? Vector2.all(1);

  factory TransformComponent.fromJson(Map<String, Object?> json) =>
      _$TransformComponentFromJson(json);

  @Vector2JsonConverter()
  Vector2 position;
  @Vector2JsonConverter()
  Vector2 scale;
  double rotation;

  void update({Vector2? position, Vector2? scale, double? rotation}) {
    this.position = position ?? this.position;
    this.scale = scale ?? this.scale;
    this.rotation = rotation ?? this.rotation;
  }

  Map<String, Object?> toJson() => _$TransformComponentToJson(this);
}
