import 'package:flutter/material.dart';

import '../models/timeline.dart';
import 'clip.dart';

class TimelinePane extends StatelessWidget {
  const TimelinePane({
    super.key,
    required this.timeline,
    required this.currentFrame,
    required this.selectedTrackIndex,
    required this.selectedClipIndex,
    required this.onSelectClip,
    required this.onScrubFrame,
    required this.onMoveClip,
  });

  final Timeline timeline;
  final int currentFrame;
  final int selectedTrackIndex;
  final int selectedClipIndex;
  final void Function(int trackIndex, int clipIndex) onSelectClip;
  final void Function(int frame) onScrubFrame;
  final void Function(int trackIndex, int clipIndex, int startFrame) onMoveClip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff14181b),
        border: Border(top: BorderSide(color: Color(0xff2b3136))),
      ),
      child: Column(
        children: [
          _TimelineHeader(
            currentFrame: currentFrame,
            timelineDurationFrames: timeline.durationFrames,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: timeline.tracks.length,
              itemBuilder: (context, trackIndex) {
                final track = timeline.tracks[trackIndex];

                return _TimelineTrackRow(
                  track: track,
                  timelineDurationFrames: timeline.durationFrames,
                  trackIndex: trackIndex,
                  selectedClipIndex: trackIndex == selectedTrackIndex
                      ? selectedClipIndex
                      : -1,
                  onSelectClip: onSelectClip,
                  onScrubFrame: onScrubFrame,
                  onMoveClip: onMoveClip,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineHeader extends StatelessWidget {
  const _TimelineHeader({
    required this.currentFrame,
    required this.timelineDurationFrames,
  });

  final int currentFrame;
  final int timelineDurationFrames;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          const SizedBox(
            width: 140,
            child: Center(
              child: Text(
                'タイムライン',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final playheadX = _frameToX(
                  currentFrame,
                  timelineDurationFrames,
                  constraints.maxWidth,
                );

                return Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _TimeRulerPainter()),
                    ),
                    Positioned(
                      left: playheadX,
                      top: 0,
                      bottom: 0,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xffff5c70)),
                        child: SizedBox(width: 2),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

int _xToFrame(double x, int timelineDurationFrames, double width) {
  if (timelineDurationFrames <= 0 || width <= 0) {
    return 0;
  }

  final ratio = (x / width).clamp(0.0, 1.0);
  return (ratio * timelineDurationFrames).round().clamp(
    0,
    timelineDurationFrames - 1,
  );
}

double _frameToX(int frame, int timelineDurationFrames, double width) {
  if (timelineDurationFrames <= 0 || width <= 0) {
    return 0;
  }

  return width * (frame / timelineDurationFrames).clamp(0.0, 1.0);
}

class _TimelineTrackRow extends StatelessWidget {
  const _TimelineTrackRow({
    required this.track,
    required this.timelineDurationFrames,
    required this.trackIndex,
    required this.selectedClipIndex,
    required this.onSelectClip,
    required this.onScrubFrame,
    required this.onMoveClip,
  });

  final TimelineTrack track;
  final int timelineDurationFrames;
  final int trackIndex;
  final int selectedClipIndex;
  final void Function(int trackIndex, int clipIndex) onSelectClip;
  final void Function(int frame) onScrubFrame;
  final void Function(int trackIndex, int clipIndex, int startFrame) onMoveClip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Color(0xff1b2024),
              border: Border(
                top: BorderSide(color: Color(0xff2b3136)),
                right: BorderSide(color: Color(0xff2b3136)),
              ),
            ),
            child: Row(
              children: [
                Icon(track.icon, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    track.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xff2b3136))),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  void scrubTo(double x) {
                    onScrubFrame(
                      _xToFrame(
                        x,
                        timelineDurationFrames,
                        constraints.maxWidth,
                      ),
                    );
                  }

                  return GestureDetector(
                    key: ValueKey('timeline-track-$trackIndex-surface'),
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragStart: (details) {
                      scrubTo(details.localPosition.dx);
                    },
                    onHorizontalDragUpdate: (details) {
                      scrubTo(details.localPosition.dx);
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(painter: _TrackGridPainter()),
                        ),
                        for (var i = 0; i < track.clips.length; i++)
                          Positioned(
                            left:
                                constraints.maxWidth *
                                track.clips[i].startRatio(
                                  timelineDurationFrames,
                                ),
                            top: 9,
                            width:
                                constraints.maxWidth *
                                track.clips[i].widthRatio(
                                  timelineDurationFrames,
                                ),
                            height: 36,
                            child: TimelineClipView(
                              clip: track.clips[i],
                              selected: i == selectedClipIndex,
                              timelineDurationFrames: timelineDurationFrames,
                              trackWidth: constraints.maxWidth,
                              onTap: () => onSelectClip(trackIndex, i),
                              onDragStart: () => onSelectClip(trackIndex, i),
                              onDragFrame: (startFrame) {
                                onMoveClip(trackIndex, i, startFrame);
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeRulerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xff3a4249)
      ..strokeWidth = 1;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (var i = 0; i <= 8; i++) {
      final x = size.width * i / 8;
      canvas.drawLine(Offset(x, 24), Offset(x, size.height), linePaint);
      textPainter.text = TextSpan(
        text: '00:${(i * 5).toString().padLeft(2, '0')}',
        style: const TextStyle(color: Color(0xffa9b3ba), fontSize: 11),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x + 6, 6));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrackGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x203a4249)
      ..strokeWidth = 1;

    for (var i = 0; i <= 16; i++) {
      final x = size.width * i / 16;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
