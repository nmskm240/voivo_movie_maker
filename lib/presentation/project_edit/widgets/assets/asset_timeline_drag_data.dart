import 'package:voivo_movie_maker/domain/project_assets.dart';

final class AssetTimelineDragData {
  const AssetTimelineDragData({required this.asset, required this.storage});

  final ProjectAsset asset;
  final ProjectAssetStorage storage;
}
