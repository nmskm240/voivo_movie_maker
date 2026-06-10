// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageComponent _$ImageComponentFromJson(Map<String, dynamic> json) =>
    ImageComponent(
      size: _$JsonConverterFromJson<Map<String, Object?>, Size>(
        json['size'],
        const SizeJsonConverter().fromJson,
      ),
      id: const ClipComponentIdJsonConverter().fromJson(json['id'] as String?),
    );

Map<String, dynamic> _$ImageComponentToJson(ImageComponent instance) =>
    <String, dynamic>{
      'id': const ClipComponentIdJsonConverter().toJson(instance.id),
      'size': const SizeJsonConverter().toJson(instance.size),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);
