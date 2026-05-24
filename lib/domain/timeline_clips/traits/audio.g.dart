// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClipAudio _$ClipAudioFromJson(Map<String, dynamic> json) => ClipAudio(
  volume: (json['volume'] as num?)?.toDouble() ?? 1,
  muted: json['muted'] as bool? ?? false,
);

Map<String, dynamic> _$ClipAudioToJson(ClipAudio instance) => <String, dynamic>{
  'volume': instance.volume,
  'muted': instance.muted,
};
