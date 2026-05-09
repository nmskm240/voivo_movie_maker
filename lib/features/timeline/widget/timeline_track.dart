import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_track_info.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_clip.dart';

class TimelineTrackView extends StatelessWidget {
  const TimelineTrackView({
    required this.track,
    required this.index,
    required this.onSeekFrame,
    required this.onAddClip,
    super.key,
  });

  final TimelineTrackInfo track;
  final int index;
  final ValueChanged<int> onSeekFrame;
  final ValueChanged<int> onAddClip;

  static const height = 56.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TimelineTrackView.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (details) {
                onSeekFrame(details.localPosition.dx.floor());
              },
              onDoubleTapDown: (details) {
                onAddClip(details.localPosition.dx.floor());
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven
                      ? const Color(0xff161b1f)
                      : const Color(0xff11161a),
                  border: const Border(
                    bottom: BorderSide(color: Color(0xff2b3339)),
                  ),
                ),
              ),
            ),
          ),
          for (final clip in track.clips)
            Positioned(
              top: 4,
              bottom: 4,
              left: clip.startFrame.toDouble(),
              width: clip.durationFrames.toDouble(),
              child: TimelineClipView(trackIndex: index, clip: clip),
            ),
        ],
      ),
    );
  }
}
