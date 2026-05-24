// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_clip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextClip _$TextClipFromJson(Map<String, dynamic> json) => TextClip(
  json['text'] as String,
  id: const TimelineClipIdJsonConverter().fromJson(json['id'] as String),
  startFrame: (json['startFrame'] as num).toInt(),
  durationFrames: (json['durationFrames'] as num?)?.toInt() ?? 10,
  transform: json['transform'] == null
      ? null
      : ClipTransform.fromJson(json['transform'] as Map<String, dynamic>),
  fontFamily: json['fontFamily'] as String? ?? "Noto Sans CJK JP",
  size: (json['size'] as num?)?.toDouble() ?? 24,
  color: _$JsonConverterFromJson<int, Color>(
    json['color'],
    const ColorJsonConverter().fromJson,
  ),
);

Map<String, dynamic> _$TextClipToJson(TextClip instance) => <String, dynamic>{
  'startFrame': instance.startFrame,
  'durationFrames': instance.durationFrames,
  'transform': instance.transform.toJson(),
  'id': const TimelineClipIdJsonConverter().toJson(instance.id),
  'text': instance.text,
  'fontFamily': instance.fontFamily,
  'size': instance.size,
  'color': const ColorJsonConverter().toJson(instance.color),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);
