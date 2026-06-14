// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:vector_math/vector_math.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';

class ProjectPaintContext {
  const ProjectPaintContext({
    required this.projectSize,
    this.imageAssets = const {},
  });

  final Size projectSize;
  final Map<AssetId, Image> imageAssets;

  Offset resolvePosition(Vector2 position) {
    return Offset(
      projectSize.width / 2 + position.x,
      projectSize.height / 2 + position.y,
    );
  }

  Image? resolveImage(AssetId assetId) => imageAssets[assetId];
}
