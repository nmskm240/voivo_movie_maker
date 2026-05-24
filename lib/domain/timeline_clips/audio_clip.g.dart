// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_clip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioClip _$AudioClipFromJson(Map<String, dynamic> json) => AudioClip(
  id: const TimelineClipIdJsonConverter().fromJson(json['id'] as String),
  startFrame: (json['startFrame'] as num).toInt(),
  assetId: const AssetIdJsonConverter().fromJson(json['assetId'] as String),
  durationFrames: (json['durationFrames'] as num?)?.toInt() ?? 10,
  audio: json['audio'] == null
      ? null
      : ClipAudio.fromJson(json['audio'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AudioClipToJson(AudioClip instance) => <String, dynamic>{
  'startFrame': instance.startFrame,
  'durationFrames': instance.durationFrames,
  'audio': instance.audio.toJson(),
  'id': const TimelineClipIdJsonConverter().toJson(instance.id),
  'assetId': const AssetIdJsonConverter().toJson(instance.assetId),
};
