// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoComponent _$VideoComponentFromJson(Map<String, dynamic> json) =>
    VideoComponent(
      assetId: AssetId.fromJson(json['assetId'] as Map<String, dynamic>),
      id: const ClipComponentIdJsonConverter().fromJson(json['id'] as String?),
    );

Map<String, dynamic> _$VideoComponentToJson(VideoComponent instance) =>
    <String, dynamic>{
      'id': const ClipComponentIdJsonConverter().toJson(instance.id),
      'assetId': instance.assetId.toJson(),
    };
