// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:vector_math/vector_math.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class ProjectPaintContext {
  const ProjectPaintContext({
    required this.projectSize,
    this.imageAssets = const {},
    this.videoFrames = const {},
  });

  final Size projectSize;
  final Map<AssetId, Image> imageAssets;
  final Map<TimelineClipId, Image> videoFrames;

  Offset resolvePosition(Vector2 position) {
    return Offset(
      projectSize.width / 2 + position.x,
      projectSize.height / 2 + position.y,
    );
  }

  Image? resolveImage(AssetId assetId) => imageAssets[assetId];
  Image? resolveVideoFrame(TimelineClipId clipId) => videoFrames[clipId];
}
