import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

class ClipTransform {
  ClipTransform({Vector2? position, Vector2? scale, this.rotation = 0})
    : position = position ?? Vector2(0.5, 0.5),
      scale = scale ?? Vector2.all(1);

  Vector2 position;
  Vector2 scale;
  double rotation;
}

mixin WithTransform on TimelineClip {
  ClipTransform get transform;

  void updateTransform({Vector2? position, Vector2? scale, double? rotation}) {
    transform.position = position ?? transform.position;
    transform.scale = scale ?? transform.scale;
    transform.rotation = rotation ?? transform.rotation;
  }
}
