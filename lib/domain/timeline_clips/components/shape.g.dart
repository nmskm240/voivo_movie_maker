// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shape.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShapeComponent _$ShapeComponentFromJson(Map<String, dynamic> json) =>
    ShapeComponent(
      shapeType:
          $enumDecodeNullable(_$ShapeTypeEnumMap, json['shapeType']) ??
          ShapeType.rectangle,
      size: _$JsonConverterFromJson<Map<String, Object?>, Size>(
        json['size'],
        const SizeJsonConverter().fromJson,
      ),
      color: _$JsonConverterFromJson<int, Color>(
        json['color'],
        const ColorJsonConverter().fromJson,
      ),
      id: const ClipComponentIdJsonConverter().fromJson(json['id'] as String?),
    );

Map<String, dynamic> _$ShapeComponentToJson(ShapeComponent instance) =>
    <String, dynamic>{
      'id': const ClipComponentIdJsonConverter().toJson(instance.id),
      'shapeType': _$ShapeTypeEnumMap[instance.shapeType]!,
      'size': const SizeJsonConverter().toJson(instance.size),
      'color': const ColorJsonConverter().toJson(instance.color),
    };

const _$ShapeTypeEnumMap = {
  ShapeType.rectangle: 'rectangle',
  ShapeType.ellipse: 'ellipse',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);
