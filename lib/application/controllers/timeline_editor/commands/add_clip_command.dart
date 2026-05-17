import 'package:voivo_movie_maker/application/controllers/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/clip_factory.dart';

class AddClipCommand implements TimelineEditorCommand {
  const AddClipCommand({
    required this.targetTrackIndex,
    required this.startFrame,
    required this.kind,
  });

  final int targetTrackIndex;
  final int startFrame;
  final TimelineClipKind kind;

  @override
  bool canExecute(Timeline timeline) {
    return targetTrackIndex >= 0 && targetTrackIndex < timeline.tracks.length;
  }

  @override
  void execute(Timeline timeline) {
    final track = timeline.tracks.elementAt(targetTrackIndex);
    final clip = ClipFactory.create(kind, startFrame);
    track.addClip(clip);
  }
}
