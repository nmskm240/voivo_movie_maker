// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetComponent _$AssetComponentFromJson(Map<String, dynamic> json) =>
    AssetComponent(
      assetId: AssetId.fromJson(json['assetId'] as Map<String, dynamic>),
      id: const ClipComponentIdJsonConverter().fromJson(json['id'] as String?),
    );

Map<String, dynamic> _$AssetComponentToJson(AssetComponent instance) =>
    <String, dynamic>{
      'id': const ClipComponentIdJsonConverter().toJson(instance.id),
      'assetId': instance.assetId.toJson(),
    };
