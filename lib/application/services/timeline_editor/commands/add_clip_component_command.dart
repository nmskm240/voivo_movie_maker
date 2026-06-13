// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class AddClipComponentCommand implements TimelineEditorCommand {
  const AddClipComponentCommand(this.clipId, this.component);

  final TimelineClipId clipId;
  final ClipComponent component;

  @override
  bool canExecute(Timeline timeline) {
    return timeline.getClipById(clipId).canAddComponent(component);
  }

  @override
  void execute(Timeline timeline) {
    timeline.getClipById(clipId).addComponent(component);
  }
}
