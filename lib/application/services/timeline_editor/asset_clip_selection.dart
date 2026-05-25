import 'dart:ui';

import 'package:voivo_movie_maker/domain/project_assets.dart';

final class AssetClipSelection {
  const AssetClipSelection({
    required this.asset,
    required this.bytes,
    this.size,
  });

  final ProjectAsset asset;
  final List<int> bytes;
  final Size? size;
}
