import 'dart:async';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';

typedef ProjectAssetLoader<T> =
    Future<T> Function(IProjectAssetStore store, ProjectAsset asset);
typedef ProjectAssetDisposer<T> = void Function(T value);

class ProjectAssetCache<T> {
  ProjectAssetCache(
    this._store, {
    required ProjectAssetKind kind,
    required ProjectAssetLoader<T> loadAsset,
    ProjectAssetDisposer<T>? disposeAsset,
    String? label,
  }) : _kind = kind,
       _loadAsset = loadAsset,
       _disposeAsset = disposeAsset,
       _label = label ?? kind.name;

  final IProjectAssetStore _store;
  final ProjectAssetKind _kind;
  final ProjectAssetLoader<T> _loadAsset;
  final ProjectAssetDisposer<T>? _disposeAsset;
  final String _label;
  final _values = <AssetId, T>{};
  final _pending = <AssetId, Future<T>>{};
  final _revisions = StreamController<int>.broadcast(sync: true);
  var _revision = 0;
  var _disposed = false;

  Map<AssetId, T> get values => Map.unmodifiable(_values);
  Stream<int> get revisions => _revisions.stream;

  T? findById(AssetId assetId) => _values[assetId];

  void evict(AssetId assetId) {
    final value = _values.remove(assetId);
    if (value == null) {
      return;
    }
    _disposeAsset?.call(value);
    _revisions.add(++_revision);
  }

  Future<T> load(ProjectAsset asset) {
    if (_disposed) {
      throw StateError('Project $_label cache is disposed');
    }
    if (asset.kind != _kind) {
      throw ArgumentError.value(asset, 'asset', 'Asset is not a $_label asset');
    }
    final cached = _values[asset.id];
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
    if (_disposeAsset != null) {
      for (final value in _values.values) {
        _disposeAsset(value);
      }
    }
    _values.clear();
    _revisions.close();
  }

  Future<T> _load(ProjectAsset asset) async {
    try {
      final value = await _loadAsset(_store, asset);
      if (_disposed) {
        _disposeAsset?.call(value);
        throw StateError('Project $_label cache was disposed while loading');
      }
      _values[asset.id] = value;
      _revisions.add(++_revision);
      return value;
    } finally {
      _pending.remove(asset.id);
    }
  }
}
