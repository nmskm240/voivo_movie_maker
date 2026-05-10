import 'package:flutter/widgets.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_ruler.dart';

class TimelineAutoScroller {
  const TimelineAutoScroller({
    required this.viewportKey,
    required this.horizontalScrollController,
    required this.verticalScrollController,
    required this.timelineDurationFrames,
    this.edgeSize = 56.0,
    this.maxStep = 28.0,
  });

  final GlobalKey viewportKey;
  final ScrollController horizontalScrollController;
  final ScrollController verticalScrollController;
  final int timelineDurationFrames;
  final double edgeSize;
  final double maxStep;

  void autoScrollForDrag(
    Offset globalPosition, {
    bool horizontal = true,
    bool vertical = true,
  }) {
    final renderBox = _viewportRenderBox;
    if (renderBox == null) {
      return;
    }

    final localPosition = renderBox.globalToLocal(globalPosition);
    final size = renderBox.size;

    if (horizontal) {
      _autoScrollAxis(
        controller: horizontalScrollController,
        position: localPosition.dx,
        extent: size.width,
      );
    }
    if (vertical) {
      _autoScrollAxis(
        controller: verticalScrollController,
        position: localPosition.dy - TimelineRuler.height,
        extent: size.height - TimelineRuler.height,
      );
    }
  }

  int frameAtGlobalPosition(Offset globalPosition) {
    final renderBox = _viewportRenderBox;
    if (renderBox == null) {
      return 0;
    }

    final localPosition = renderBox.globalToLocal(globalPosition);
    final scrollOffset = horizontalScrollController.hasClients
        ? horizontalScrollController.offset
        : 0.0;
    return (localPosition.dx + scrollOffset).floor().clamp(
      0,
      timelineDurationFrames - 1,
    );
  }

  RenderBox? get _viewportRenderBox {
    final context = viewportKey.currentContext;
    if (context == null) {
      return null;
    }

    return context.findRenderObject() as RenderBox?;
  }

  void _autoScrollAxis({
    required ScrollController controller,
    required double position,
    required double extent,
  }) {
    if (!controller.hasClients || extent <= 0) {
      return;
    }

    final leadingOverflow = edgeSize - position;
    final trailingOverflow = position - (extent - edgeSize);
    final direction = leadingOverflow > 0
        ? -1.0
        : trailingOverflow > 0
        ? 1.0
        : 0.0;
    if (direction == 0) {
      return;
    }

    final overflow = direction < 0 ? leadingOverflow : trailingOverflow;
    final step = (overflow / edgeSize).clamp(0.15, 1.0) * maxStep * direction;
    final nextOffset = (controller.offset + step).clamp(
      controller.position.minScrollExtent,
      controller.position.maxScrollExtent,
    );
    controller.jumpTo(nextOffset);
  }
}
