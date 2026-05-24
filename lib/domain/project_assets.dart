import 'package:cuid2/cuid2.dart';
import 'package:json_annotation/json_annotation.dart';

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
  const ProjectAsset({
    required this.id,
    required this.name,
    required this.kind,
  });

  factory ProjectAsset.fromJson(Map<String, Object?> json) =>
      _$ProjectAssetFromJson(json);

  @AssetIdJsonConverter()
  final AssetId id;
  final String name;
  final ProjectAssetKind kind;

  Map<String, Object?> toJson() => _$ProjectAssetToJson(this);
}

enum ProjectAssetKind { image, video, audio }

class AssetIdJsonConverter implements JsonConverter<AssetId, String> {
  const AssetIdJsonConverter();

  @override
  AssetId fromJson(String json) => AssetId.fromString(json);

  @override
  String toJson(AssetId object) => object.value;
}

abstract interface class ProjectAssetStorage {
  Iterable<ProjectAsset> get assets;

  ProjectAsset? findById(AssetId assetId);
  ProjectAsset getById(AssetId assetId);
  Stream<List<int>> getBytes(ProjectAsset asset);
  Stream<List<int>> getBytesById(AssetId assetId);
  Future<void> add(ProjectAsset asset, Stream<List<int>> bytes);
  Future<void> remove(AssetId assetId);
}
