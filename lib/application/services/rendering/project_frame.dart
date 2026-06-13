import 'dart:ui';

import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class ProjectFrame {
  ProjectFrame({
    required this.projectSize,
    required this.frameNumber,
    required Iterable<TimelineClip> clips,
  }) : clips = List.unmodifiable(clips);

  final Size projectSize;
  final int frameNumber;
  final List<TimelineClip> clips;
}
