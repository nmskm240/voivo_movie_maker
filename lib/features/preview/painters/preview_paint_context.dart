import 'dart:ui';

import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';

class PreviewPaintContext {
  const PreviewPaintContext({
    required this.projectSize,
    required this.imagesByAssetId,
  });

  final Size projectSize;
  final Map<AssetId, Image> imagesByAssetId;

  Offset resolvePosition(Vector2 position) {
    return Offset(
      projectSize.width / 2 + position.x,
      projectSize.height / 2 + position.y,
    );
  }
}
