import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_track_info.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/timeline_clip.dart';

class TimelineTrackView extends StatelessWidget {
  const TimelineTrackView({
    required this.track,
    this.selected = false,
    super.key,
  });

  final TimelineTrackInfo track;
  final bool selected;

  static const height = 56.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TimelineTrackView.height,
      child: Stack(
        children: [
          for (final clip in track.clips)
            Positioned(
              top: 4,
              bottom: 4,
              left: clip.startFrame.toDouble(),
              width: clip.durationFrames.toDouble(),
              child: TimelineClipView(
                key: GlobalObjectKey(clip.id),
                clip: clip,
              ),
            ),
        ],
      ),
    );
  }
}
