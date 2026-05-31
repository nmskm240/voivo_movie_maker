// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_assets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectAsset _$ProjectAssetFromJson(Map<String, dynamic> json) => ProjectAsset(
  name: json['name'] as String,
  kind: $enumDecode(_$ProjectAssetKindEnumMap, json['kind']),
  id: _$JsonConverterFromJson<String, AssetId>(
    json['id'],
    const AssetIdJsonConverter().fromJson,
  ),
);

Map<String, dynamic> _$ProjectAssetToJson(ProjectAsset instance) =>
    <String, dynamic>{
      'id': const AssetIdJsonConverter().toJson(instance.id),
      'name': instance.name,
      'kind': _$ProjectAssetKindEnumMap[instance.kind]!,
    };

const _$ProjectAssetKindEnumMap = {
  ProjectAssetKind.image: 'image',
  ProjectAssetKind.video: 'video',
  ProjectAssetKind.audio: 'audio',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

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
