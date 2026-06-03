// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_assets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetId _$AssetIdFromJson(Map<String, dynamic> json) =>
    AssetId(json['value'] as String);

Map<String, dynamic> _$AssetIdToJson(AssetId instance) => <String, dynamic>{
  'value': instance.value,
};

ProjectAsset _$ProjectAssetFromJson(Map<String, dynamic> json) => ProjectAsset(
  name: json['name'] as String,
  kind: $enumDecode(_$ProjectAssetKindEnumMap, json['kind']),
  id: json['id'] == null
      ? null
      : AssetId.fromJson(json['id'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProjectAssetToJson(ProjectAsset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': _$ProjectAssetKindEnumMap[instance.kind]!,
    };

const _$ProjectAssetKindEnumMap = {
  ProjectAssetKind.image: 'image',
  ProjectAssetKind.video: 'video',
  ProjectAssetKind.audio: 'audio',
};

ProjectAssetCatalog _$ProjectAssetCatalogFromJson(Map<String, dynamic> json) =>
    ProjectAssetCatalog(
      assets:
          (json['assets'] as List<dynamic>?)?.map(
            (e) => ProjectAsset.fromJson(e as Map<String, dynamic>),
          ) ??
          const [],
    );

Map<String, dynamic> _$ProjectAssetCatalogToJson(
  ProjectAssetCatalog instance,
) => <String, dynamic>{'assets': instance.assets.toList()};
