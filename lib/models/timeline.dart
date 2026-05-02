import 'package:flutter/material.dart';

class TimelineTrack {
  const TimelineTrack({
    required this.name,
    required this.icon,
    required this.clips,
  });

  final String name;
  final IconData icon;
  final List<TimelineClip> clips;
}

class TimelineClip {
  const TimelineClip({
    required this.title,
    required this.start,
    required this.width,
    required this.color,
  });

  final String title;
  final double start;
  final double width;
  final Color color;
}
