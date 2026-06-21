// Dart imports:
import 'dart:async';
import 'dart:ui';

// Project imports:
import 'package:voivo_movie_maker/application/services/rendering/project_image_decoder.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';

class ProjectImageResources {
  ProjectImageResources(this._store);

  final IProjectAssetStore _store;
  final _images = <AssetId, Image>{};
  final _pending = <AssetId, Future<Image>>{};
  final _revisions = StreamController<int>.broadcast(sync: true);
  var _revision = 0;
  var _disposed = false;

  Map<AssetId, Image> get images => Map.unmodifiable(_images);
  Stream<int> get revisions => _revisions.stream;

  Image? findById(AssetId assetId) => _images[assetId];

  Future<Image> load(ProjectAsset asset) {
    if (_disposed) {
      throw StateError('Project image resources are disposed');
    }
    if (asset.kind != ProjectAssetKind.image) {
      throw ArgumentError.value(asset, 'asset', 'Asset is not an image');
    }
    final cached = _images[asset.id];
    if (cached != null) {
      return Future.value(cached);
    }
    return _pending.putIfAbsent(asset.id, () => _load(asset));
  }

  Future<void> loadAll(Iterable<ProjectAsset> assets) async {
    await Future.wait(assets.map(load));
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    for (final image in _images.values) {
      image.dispose();
    }
    _images.clear();
    _revisions.close();
  }

  Future<Image> _load(ProjectAsset asset) async {
    try {
      final image = await decodeProjectImage(_store, asset);
      if (_disposed) {
        image.dispose();
        throw StateError('Project image resources were disposed while loading');
      }
      _images[asset.id] = image;
      _revisions.add(++_revision);
      return image;
    } finally {
      _pending.remove(asset.id);
    }
  }
}
