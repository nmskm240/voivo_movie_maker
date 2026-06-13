// Dart imports:
import 'dart:io';

// Package imports:
import 'package:path/path.dart' as p;

// Project imports:
import 'package:voivo_movie_maker/constants.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/infra/asset_factory.dart';

final class DirectoryAssetStore implements IProjectAssetStore {
  DirectoryAssetStore(Directory directory)
    : _assetDirectory = Directory(p.join(directory.path, assetDirectoryName)) {
    if (!_assetDirectory.existsSync()) {
      _assetDirectory.createSync(recursive: true);
    }
  }

  final Directory _assetDirectory;

  @override
  Stream<List<int>> load(ProjectAsset asset) {
    final file = File(p.join(_assetDirectory.path, asset.fileName));
    if (!file.existsSync()) {
      throw StateError('Asset file is missing: ${asset.name}');
    }

    return file.openRead();
  }

  @override
  Future<ProjectAsset> save(File file) async {
    final asset = await ProjectAssetFactory.fromFile(file);
    final destination = File(p.join(_assetDirectory.path, asset.fileName));
    await file.copy(destination.path);
    return asset;
  }
}
