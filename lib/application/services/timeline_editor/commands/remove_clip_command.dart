// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

class RemoveClipCommand implements TimelineEditorCommand {
  const RemoveClipCommand(this.clipId);

  final TimelineClipId clipId;

  @override
  bool canExecute(Timeline timeline) {
    return timeline.tracks.any((track) => track.containsById(clipId));
  }

  @override
  void execute(Timeline timeline) {
    timeline.getTrackByClipId(clipId).removeClip(clipId);
  }
}
