// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClipTransform _$ClipTransformFromJson(Map<String, dynamic> json) =>
    ClipTransform(
      position: _$JsonConverterFromJson<Map<String, Object?>, Vector2>(
        json['position'],
        const Vector2JsonConverter().fromJson,
      ),
      scale: _$JsonConverterFromJson<Map<String, Object?>, Vector2>(
        json['scale'],
        const Vector2JsonConverter().fromJson,
      ),
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ClipTransformToJson(ClipTransform instance) =>
    <String, dynamic>{
      'position': const Vector2JsonConverter().toJson(instance.position),
      'scale': const Vector2JsonConverter().toJson(instance.scale),
      'rotation': instance.rotation,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);
