// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

class ResizeClipCommand implements TimelineEditorCommand {
  const ResizeClipCommand(
    this.clipId, {
    required this.startFrame,
    required this.durationFrames,
  });

  final TimelineClipId clipId;
  final int startFrame;
  final int durationFrames;

  @override
  bool canExecute(Timeline timeline) {
    final clip = timeline.getClipById(clipId);
    final track = timeline.getTrackByClipId(clipId);
    return track.canPlaceClip(
      clip,
      startFrame: startFrame,
      durationFrames: durationFrames,
    );
  }

  @override
  void execute(Timeline timeline) {
    final clip = timeline.getClipById(clipId);
    clip.trimStartTo(startFrame);
    clip.trimEndTo(startFrame + durationFrames);
  }
}
