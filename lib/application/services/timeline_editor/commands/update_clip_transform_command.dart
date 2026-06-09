import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/transform.dart';

class UpdateClipTransformCommand implements TimelineEditorCommand {
  const UpdateClipTransformCommand(
    this.clipId, {
    this.position,
    this.scale,
    this.rotation,
  });

  final TimelineClipId clipId;
  final Vector2? position;
  final Vector2? scale;
  final double? rotation;

  @override
  bool canExecute(Timeline timeline) {
    return timeline.getClipById(clipId).hasComponent<TransformComponent>();
  }

  @override
  void execute(Timeline timeline) {
    timeline
        .getClipById(clipId)
        .component<TransformComponent>()
        ?.update(position: position, scale: scale, rotation: rotation);
  }
}
