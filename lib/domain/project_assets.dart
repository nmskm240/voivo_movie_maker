import 'package:cuid2/cuid2.dart';

class AssetId {
  const AssetId._(this.value);
  factory AssetId.create() {
    return AssetId._(cuid());
  }

  final String value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is AssetId && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

abstract class ProjectAsset {
  const ProjectAsset({
    required this.id,
    required this.name,
    required this.uri,
    required this.kind,
  });

  final AssetId id;
  final String name;
  final Uri uri;
  final ProjectAssetKind kind;
}

enum ProjectAssetKind { image, video, audio }

class ProjectAssetSource {
  ProjectAssetSource({Iterable<ProjectAsset> assets = const []})
    : _assets = {for (final asset in assets) asset.id: asset};

  final Map<AssetId, ProjectAsset> _assets;

  ProjectAsset? findById(AssetId assetId) {
    return _assets[assetId];
  }

  ProjectAsset getById(AssetId assetId) {
    final asset = findById(assetId);
    if (asset == null) {
      throw ArgumentError.value(assetId, 'assetId', 'Unknown project asset');
    }
    return asset;
  }

  bool containsById(AssetId assetId) {
    return _assets.containsKey(assetId);
  }

  void add(ProjectAsset asset) {
    if (containsById(asset.id)) {
      throw ArgumentError.value(
        asset.id,
        'asset.id',
        'Duplicate project asset',
      );
    }
    _assets[asset.id] = asset;
  }

  void remove(AssetId assetId) {
    _assets.remove(assetId);
  }
}
