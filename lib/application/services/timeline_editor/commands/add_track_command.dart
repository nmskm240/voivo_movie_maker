// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

class AddTrackCommand implements TimelineEditorCommand {
  const AddTrackCommand();

  @override
  bool canExecute(Timeline timeline) => true;

  @override
  void execute(Timeline timeline) {
    timeline.addTrack();
  }
}
