import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class RemoveClipComponentCommand implements TimelineEditorCommand {
  const RemoveClipComponentCommand(this.clipId, this.componentId);

  final TimelineClipId clipId;
  final ClipComponentId componentId;

  @override
  bool canExecute(Timeline timeline) {
    return timeline.getClipById(clipId).containsComponent(componentId);
  }

  @override
  void execute(Timeline timeline) {
    timeline.getClipById(clipId).removeComponent(componentId);
  }
}
