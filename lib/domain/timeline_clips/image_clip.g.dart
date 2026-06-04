// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_clip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageClip _$ImageClipFromJson(Map<String, dynamic> json) => ImageClip(
  id: TimelineClipId.fromJson(json['id'] as Map<String, dynamic>),
  startFrame: (json['startFrame'] as num).toInt(),
  assetId: AssetId.fromJson(json['assetId'] as Map<String, dynamic>),
  durationFrames: (json['durationFrames'] as num?)?.toInt() ?? 10,
  transform: json['transform'] == null
      ? null
      : ClipTransform.fromJson(json['transform'] as Map<String, dynamic>),
  size: _$JsonConverterFromJson<Map<String, Object?>, Size>(
    json['size'],
    const SizeJsonConverter().fromJson,
  ),
);

Map<String, dynamic> _$ImageClipToJson(ImageClip instance) => <String, dynamic>{
  'id': instance.id.toJson(),
  'startFrame': instance.startFrame,
  'durationFrames': instance.durationFrames,
  'transform': instance.transform.toJson(),
  'assetId': instance.assetId.toJson(),
  'size': const SizeJsonConverter().toJson(instance.size),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);
