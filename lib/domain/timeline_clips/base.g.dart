// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineClipId _$TimelineClipIdFromJson(Map<String, dynamic> json) =>
    TimelineClipId(json['value'] as String);

Map<String, dynamic> _$TimelineClipIdToJson(TimelineClipId instance) =>
    <String, dynamic>{'value': instance.value};

TimelineClip _$TimelineClipFromJson(Map<String, dynamic> json) => TimelineClip(
  id: TimelineClipId.fromJson(json['id'] as Map<String, dynamic>),
  startFrame: (json['startFrame'] as num).toInt(),
  durationFrames: (json['durationFrames'] as num?)?.toInt() ?? 10,
  components:
      (json['components'] as List<dynamic>?)?.map(
        (e) => const ClipComponentJsonConverter().fromJson(
          e as Map<String, Object?>,
        ),
      ) ??
      const [],
);

Map<String, dynamic> _$TimelineClipToJson(TimelineClip instance) =>
    <String, dynamic>{
      'id': instance.id.toJson(),
      'components': instance.components
          .map(const ClipComponentJsonConverter().toJson)
          .toList(),
      'startFrame': instance.startFrame,
      'durationFrames': instance.durationFrames,
    };
