import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:voivo_movie_maker/domain/project_assets.dart';

final class DirectoryAssetStorage implements ProjectAssetStorage {
  DirectoryAssetStorage(
    Directory directory, {
    Iterable<ProjectAsset> assets = const [],
  }) : _directory = directory,
       _assetDirectory = Directory(p.join(directory.path, 'assets')),
       _assetsById = _indexAssets(assets) {
    _ensureReadySync();
  }

  final Directory _directory;
  final Directory _assetDirectory;
  final Map<AssetId, ProjectAsset> _assetsById;

  @override
  Iterable<ProjectAsset> get assets => List.unmodifiable(_assetsById.values);

  @override
  ProjectAsset? findById(AssetId assetId) {
    return _assetsById[assetId];
  }

  @override
  ProjectAsset getById(AssetId assetId) {
    final asset = findById(assetId);
    if (asset == null) {
      throw ArgumentError.value(assetId, 'assetId', 'Unknown project asset');
    }
    return asset;
  }

  @override
  Stream<List<int>> getBytes(ProjectAsset asset) {
    final file = _fileFor(asset);
    if (!file.existsSync()) {
      throw StateError('Asset file is missing: ${asset.name}');
    }

    return file.openRead();
  }

  @override
  Stream<List<int>> getBytesById(AssetId assetId) {
    return getBytes(getById(assetId));
  }

  @override
  Future<void> add(ProjectAsset asset, Stream<List<int>> bytes) async {
    if (_assetsById.containsKey(asset.id)) {
      throw ArgumentError.value(asset.id, 'asset.id', 'Duplicate asset');
    }
    if (_assetsById.values.any((saved) => saved.name == asset.name)) {
      throw ArgumentError.value(asset.name, 'asset.name', 'Duplicate asset');
    }

    await _ensureReady();
    final file = _fileFor(asset);
    final sink = file.openWrite();
    try {
      await for (final chunk in bytes) {
        sink.add(chunk);
      }
    } catch (_) {
      await sink.close();
      if (await file.exists()) {
        await file.delete();
      }
      rethrow;
    }
    await sink.close();

    _assetsById[asset.id] = asset;
  }

  @override
  Future<void> remove(AssetId assetId) async {
    final asset = _assetsById.remove(assetId);
    if (asset == null) {
      return;
    }

    final file = _fileFor(asset);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> _ensureReady() async {
    if (!await _directory.exists()) {
      await _directory.create(recursive: true);
    }
    if (!await _assetDirectory.exists()) {
      await _assetDirectory.create(recursive: true);
    }
  }

  void _ensureReadySync() {
    if (!_directory.existsSync()) {
      _directory.createSync(recursive: true);
    }
    if (!_assetDirectory.existsSync()) {
      _assetDirectory.createSync(recursive: true);
    }
  }

  File _fileFor(ProjectAsset asset) {
    final fileName = p.basename(asset.name);
    if (fileName != asset.name) {
      throw ArgumentError.value(
        asset.name,
        'asset.name',
        'Asset name must be a file name, not a path',
      );
    }
    return File(p.join(_assetDirectory.path, fileName));
  }

  static Map<AssetId, ProjectAsset> _indexAssets(
    Iterable<ProjectAsset> assets,
  ) {
    final assetsById = <AssetId, ProjectAsset>{};
    for (final asset in assets) {
      if (assetsById.containsKey(asset.id)) {
        throw ArgumentError.value(asset.id, 'asset.id', 'Duplicate asset');
      }
      if (assetsById.values.any((saved) => saved.name == asset.name)) {
        throw ArgumentError.value(asset.name, 'asset.name', 'Duplicate asset');
      }
      assetsById[asset.id] = asset;
    }
    return assetsById;
  }
}
