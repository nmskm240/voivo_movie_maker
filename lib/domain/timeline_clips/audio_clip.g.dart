// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_clip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioClip _$AudioClipFromJson(Map<String, dynamic> json) => AudioClip(
  id: TimelineClipId.fromJson(json['id'] as Map<String, dynamic>),
  startFrame: (json['startFrame'] as num).toInt(),
  assetId: AssetId.fromJson(json['assetId'] as Map<String, dynamic>),
  durationFrames: (json['durationFrames'] as num?)?.toInt() ?? 10,
  audio: json['audio'] == null
      ? null
      : ClipAudio.fromJson(json['audio'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AudioClipToJson(AudioClip instance) => <String, dynamic>{
  'startFrame': instance.startFrame,
  'durationFrames': instance.durationFrames,
  'audio': instance.audio.toJson(),
  'id': instance.id.toJson(),
  'assetId': instance.assetId.toJson(),
};
