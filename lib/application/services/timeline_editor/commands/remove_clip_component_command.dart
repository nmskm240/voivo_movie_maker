import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class RemoveClipComponentCommand<T extends ClipComponent>
    implements TimelineEditorCommand {
  const RemoveClipComponentCommand(this.clipId);

  final TimelineClipId clipId;

  @override
  bool canExecute(Timeline timeline) {
    return timeline.getClipById(clipId).hasComponent<T>();
  }

  @override
  void execute(Timeline timeline) {
    timeline.getClipById(clipId).removeComponent<T>();
  }
}
