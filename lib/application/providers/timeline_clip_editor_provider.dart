import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/timeline_editor_provider.dart';

typedef TimelineClipEditorArgs = ({int trackIndex, String clipId});

final timelineClipEditorProvider =
    Provider.family<TimelineClipEditor, TimelineClipEditorArgs>((ref, args) {
      return TimelineClipEditor(
        ref: ref,
        trackIndex: args.trackIndex,
        clipId: args.clipId,
      );
    });

class TimelineClipEditor {
  const TimelineClipEditor({
    required this.ref,
    required this.trackIndex,
    required this.clipId,
  });

  final Ref ref;
  final int trackIndex;
  final String clipId;

  void moveTo(int startFrame) {
    ref
        .read(timelineEditorProvider.notifier)
        .moveClip(
          trackIndex: trackIndex,
          clipId: clipId,
          startFrame: startFrame,
        );
  }

  void resizeTo({required int startFrame, required int durationFrames}) {
    ref
        .read(timelineEditorProvider.notifier)
        .resizeClip(
          trackIndex: trackIndex,
          clipId: clipId,
          startFrame: startFrame,
          durationFrames: durationFrames,
        );
  }
}
