import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

class MoveClipCommand implements TimelineEditorCommand {
  const MoveClipCommand(
    this.clipId, {
    required this.targetTrackIndex,
    required this.startFrame,
  });

  final TimelineClipId clipId;
  final int targetTrackIndex;
  final int startFrame;

  @override
  bool canExecute(Timeline timeline) {
    if (targetTrackIndex < 0 || targetTrackIndex >= timeline.tracks.length) {
      return false;
    }

    final clip = timeline.getClipById(clipId);
    final targetTrack = timeline.tracks.elementAt(targetTrackIndex);
    return targetTrack.canPlaceClip(clip, startFrame: startFrame);
  }

  @override
  void execute(Timeline timeline) {
    final clip = timeline.getClipById(clipId);
    final currentTrack = timeline.getTrackByClipId(clipId);
    final currentTrackIndex = timeline.tracks.toList().indexOf(currentTrack);

    if (currentTrackIndex != targetTrackIndex) {
      timeline.moveClipToTrack(clipId, targetTrackIndex);
    }
    clip.moveTo(startFrame);
  }
}
