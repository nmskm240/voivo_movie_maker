import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_track_info.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_clip.dart';

class TimelineTrackView extends StatefulWidget {
  const TimelineTrackView({
    required this.track,
    required this.index,
    required this.onSeekFrame,
    required this.onAddClip,
    required this.onMoveClip,
    required this.onResizeClip,
    super.key,
  });

  final TimelineTrackInfo track;
  final int index;
  final ValueChanged<int> onSeekFrame;
  final ValueChanged<int> onAddClip;
  final void Function(String clipId, int startFrame) onMoveClip;
  final void Function(String clipId, int startFrame, int durationFrames)
  onResizeClip;

  static const height = 56.0;

  @override
  State<TimelineTrackView> createState() => _TimelineTrackViewState();
}

class _TimelineTrackViewState extends State<TimelineTrackView> {
  double _dragStartGlobalX = 0;
  int _dragStartFrame = 0;
  int _dragStartDurationFrames = 1;
  int _dragStartEndFrame = 1;

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
                widget.onSeekFrame(details.localPosition.dx.floor());
              },
              onDoubleTapDown: (details) {
                widget.onAddClip(details.localPosition.dx.floor());
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.index.isEven
                      ? const Color(0xff161b1f)
                      : const Color(0xff11161a),
                  border: const Border(
                    bottom: BorderSide(color: Color(0xff2b3339)),
                  ),
                ),
              ),
            ),
          ),
          for (final clip in widget.track.clips)
            Positioned(
              top: 4,
              bottom: 4,
              left: clip.startFrame.toDouble(),
              width: clip.durationFrames.toDouble(),
              child: TimelineClipView(
                clip: clip,
                onMoveStart: (details) {
                  _startDrag(details, clip.startFrame, clip.durationFrames);
                },
                onMoveUpdate: (details) {
                  final startFrame = _dragStartFrame + _deltaFrames(details);
                  widget.onMoveClip(clip.id, startFrame);
                },
                onStartResizeStart: (details) {
                  _startDrag(details, clip.startFrame, clip.durationFrames);
                },
                onStartResizeUpdate: (details) {
                  final startFrame = (_dragStartFrame + _deltaFrames(details))
                      .clamp(0, _dragStartEndFrame - 1);
                  widget.onResizeClip(
                    clip.id,
                    startFrame,
                    _dragStartEndFrame - startFrame,
                  );
                },
                onEndResizeStart: (details) {
                  _startDrag(details, clip.startFrame, clip.durationFrames);
                },
                onEndResizeUpdate: (details) {
                  final nextDurationFrames =
                      _dragStartDurationFrames + _deltaFrames(details);
                  final durationFrames = nextDurationFrames < 1
                      ? 1
                      : nextDurationFrames;
                  widget.onResizeClip(clip.id, _dragStartFrame, durationFrames);
                },
              ),
            ),
        ],
      ),
    );
  }

  void _startDrag(
    DragStartDetails details,
    int startFrame,
    int durationFrames,
  ) {
    _dragStartGlobalX = details.globalPosition.dx;
    _dragStartFrame = startFrame;
    _dragStartDurationFrames = durationFrames;
    _dragStartEndFrame = startFrame + durationFrames;
  }

  int _deltaFrames(DragUpdateDetails details) {
    return (details.globalPosition.dx - _dragStartGlobalX).round();
  }
}
