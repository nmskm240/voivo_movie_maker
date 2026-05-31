import 'dart:io';

import 'package:cuid2/cuid2.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/json_converters.dart';

part 'project_assets.g.dart';

class AssetId {
  const AssetId._(this.value);
  factory AssetId.create() {
    return AssetId._(cuid());
  }
  factory AssetId.fromString(String value) {
    if (value.isEmpty) {
      throw ArgumentError.value(value, 'value', 'AssetId cannot be empty');
    }
    if (!isCuid(value)) {
      throw ArgumentError.value(value, 'value', 'Invalid asset ID format');
    }
    return AssetId._(value);
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

@JsonSerializable()
class ProjectAsset {
  ProjectAsset({required this.name, required this.kind, AssetId? id})
    : id = id ?? AssetId.create();

  factory ProjectAsset.fromJson(Map<String, Object?> json) =>
      _$ProjectAssetFromJson(json);

  @AssetIdJsonConverter()
  final AssetId id;
  final String name;
  final ProjectAssetKind kind;
  String get fileName => id.value;

  Map<String, Object?> toJson() => _$ProjectAssetToJson(this);
}

enum ProjectAssetKind { image, video, audio }

@JsonSerializable()
class ProjectAssetCatalog {
  ProjectAssetCatalog({Iterable<ProjectAsset> assets = const []})
    : _assets = assets.toList();

  factory ProjectAssetCatalog.fromJson(Map<String, Object?> json) =>
      _$ProjectAssetCatalogFromJson(json);

  final List<ProjectAsset> _assets;
  Iterable<ProjectAsset> get assets => List.unmodifiable(_assets);

  ProjectAsset? findById(AssetId assetId) {
    try {
      return _assets.firstWhere((asset) => asset.id == assetId);
    } catch (e) {
      return null;
    }
  }

  void add(ProjectAsset asset) {
    if (_assets.any((saved) => saved.id == asset.id)) {
      throw ArgumentError.value(asset.id, 'asset.id', 'Duplicate asset ID');
    }
    if (_assets.any((saved) => saved.name == asset.name)) {
      throw ArgumentError.value(
        asset.name,
        'asset.name',
        'Duplicate asset name',
      );
    }
    _assets.add(asset);
  }

  void remove(AssetId assetId) {
    _assets.removeWhere((asset) => asset.id == assetId);
  }

  Map<String, Object?> toJson() => _$ProjectAssetCatalogToJson(this);
}

abstract interface class IProjectAssetStore {
  Stream<List<int>> load(ProjectAsset asset);
  Future<ProjectAsset> save(File file);
}

abstract interface class ProjectAssetStorage {
  // Iterable<ProjectAsset> get assets;

  // ProjectAsset? findById(AssetId assetId);
  // ProjectAsset getById(AssetId assetId);
  // Stream<List<int>> getBytes(ProjectAsset asset);
  // Stream<List<int>> getBytesById(AssetId assetId);
  // Future<void> add(ProjectAsset asset, Stream<List<int>> bytes);
  // Future<void> remove(AssetId assetId);
}

