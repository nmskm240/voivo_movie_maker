// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioComponent _$AudioComponentFromJson(Map<String, dynamic> json) =>
    AudioComponent(
      volume: (json['volume'] as num?)?.toDouble() ?? 1,
      muted: json['muted'] as bool? ?? false,
      id: const ClipComponentIdJsonConverter().fromJson(json['id'] as String?),
    );

Map<String, dynamic> _$AudioComponentToJson(AudioComponent instance) =>
    <String, dynamic>{
      'id': const ClipComponentIdJsonConverter().toJson(instance.id),
      'volume': instance.volume,
      'muted': instance.muted,
    };
