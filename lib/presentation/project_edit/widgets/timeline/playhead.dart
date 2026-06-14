// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/playback_controller.dart';

class Playhead extends ConsumerStatefulWidget {
  const Playhead({required this.pixelsPerFrame, super.key});

  final double pixelsPerFrame;

  @override
  ConsumerState<Playhead> createState() => _PlayheadState();
}

class _PlayheadState extends ConsumerState<Playhead> {
  static const _dragHandleWidth = 32.0;

  int? _dragStartFrame;
  double? _dragStartGlobalX;

  @override
  Widget build(BuildContext context) {
    final currentFrame = ref.watch(
      playbackControllerProvider.select((playback) => playback.currentFrame),
    );
    final playbackController = ref.read(playbackControllerProvider.notifier);

    return Positioned(
      top: 0,
      bottom: 0,
      left: currentFrame * widget.pixelsPerFrame - _dragHandleWidth / 2,
      width: _dragHandleWidth,
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeLeftRight,
        child: GestureDetector(
          key: const ValueKey('playhead-drag-handle'),
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: (details) {
            _dragStartFrame = currentFrame;
            _dragStartGlobalX = details.globalPosition.dx;
          },
          onHorizontalDragUpdate: (details) {
            final dragStartFrame = _dragStartFrame;
            final dragStartGlobalX = _dragStartGlobalX;
            if (dragStartFrame == null || dragStartGlobalX == null) {
              return;
            }

            playbackController.seek(
              dragStartFrame +
                  ((details.globalPosition.dx - dragStartGlobalX) /
                          widget.pixelsPerFrame)
                      .round(),
            );
          },
          onHorizontalDragEnd: (_) => _resetDrag(),
          onHorizontalDragCancel: _resetDrag,
          child: const RepaintBoundary(
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: SizedBox(width: 2, height: double.infinity),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _resetDrag() {
    _dragStartFrame = null;
    _dragStartGlobalX = null;
  }
}
