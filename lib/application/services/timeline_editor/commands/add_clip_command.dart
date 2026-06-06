import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

class AddClipCommand implements TimelineEditorCommand {
  const AddClipCommand({
    required this.targetTrackIndex,
    required this.startFrame,
    required this.clip,
  });

  final int targetTrackIndex;
  final int startFrame;
  final TimelineClip clip;

  @override
  bool canExecute(Timeline timeline) {
    return targetTrackIndex >= 0 && targetTrackIndex < timeline.tracks.length;
  }

  @override
  void execute(Timeline timeline) {
    final track = timeline.tracks.elementAt(targetTrackIndex);
    track.addClip(clip);
  }
}
