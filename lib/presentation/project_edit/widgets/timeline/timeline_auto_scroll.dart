// Flutter imports:
import 'package:flutter/widgets.dart';

class TimelineAutoScrollUpdate extends Notification {
  const TimelineAutoScrollUpdate(this.globalPosition, {this.onScroll});

  final Offset globalPosition;
  final ValueChanged<double>? onScroll;
}

class TimelineAutoScrollEnd extends Notification {
  const TimelineAutoScrollEnd();
}
