import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

class ClipTransform {
  ClipTransform({Vector2? position, Vector2? scale, this.rotation = 0})
    : position = position ?? Vector2.zero(),
      scale = scale ?? Vector2.all(1);

  final Vector2 position;
  final Vector2 scale;
  final double rotation;
}

mixin WithTransform on TimelineClip {
  ClipTransform get transform;
}
