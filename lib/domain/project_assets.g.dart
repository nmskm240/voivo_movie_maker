// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_assets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectAsset _$ProjectAssetFromJson(Map<String, dynamic> json) => ProjectAsset(
  id: const AssetIdJsonConverter().fromJson(json['id'] as String),
  name: json['name'] as String,
  kind: $enumDecode(_$ProjectAssetKindEnumMap, json['kind']),
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
