// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class ProjectFrame {
  ProjectFrame({
    required this.projectSize,
    required this.frameNumber,
    required Iterable<TimelineClip> clips,
    this.imageAssets = const {},
    this.videoFrames = const {},
  }) : clips = List.unmodifiable(clips);

  final Size projectSize;
  final int frameNumber;
  final List<TimelineClip> clips;
  final Map<AssetId, Image> imageAssets;
  final Map<TimelineClipId, Image> videoFrames;
}
