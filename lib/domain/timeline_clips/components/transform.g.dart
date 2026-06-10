// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransformComponent _$TransformComponentFromJson(Map<String, dynamic> json) =>
    TransformComponent(
      position: _$JsonConverterFromJson<Map<String, Object?>, Vector2>(
        json['position'],
        const Vector2JsonConverter().fromJson,
      ),
      scale: _$JsonConverterFromJson<Map<String, Object?>, Vector2>(
        json['scale'],
        const Vector2JsonConverter().fromJson,
      ),
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      id: const ClipComponentIdJsonConverter().fromJson(json['id'] as String?),
    );

Map<String, dynamic> _$TransformComponentToJson(TransformComponent instance) =>
    <String, dynamic>{
      'id': const ClipComponentIdJsonConverter().toJson(instance.id),
      'position': const Vector2JsonConverter().toJson(instance.position),
      'scale': const Vector2JsonConverter().toJson(instance.scale),
      'rotation': instance.rotation,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);
