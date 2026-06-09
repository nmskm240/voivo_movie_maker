// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextComponent _$TextComponentFromJson(Map<String, dynamic> json) =>
    TextComponent(
      text: json['text'] as String? ?? 'Text',
      fontFamily: json['fontFamily'] as String? ?? 'Noto Sans CJK JP',
      size: (json['size'] as num?)?.toDouble() ?? 24,
      color: _$JsonConverterFromJson<int, Color>(
        json['color'],
        const ColorJsonConverter().fromJson,
      ),
    );

Map<String, dynamic> _$TextComponentToJson(TextComponent instance) =>
    <String, dynamic>{
      'text': instance.text,
      'fontFamily': instance.fontFamily,
      'size': instance.size,
      'color': const ColorJsonConverter().toJson(instance.color),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);
