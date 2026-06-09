// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioComponent _$AudioComponentFromJson(Map<String, dynamic> json) =>
    AudioComponent(
      volume: (json['volume'] as num?)?.toDouble() ?? 1,
      muted: json['muted'] as bool? ?? false,
    );

Map<String, dynamic> _$AudioComponentToJson(AudioComponent instance) =>
    <String, dynamic>{'volume': instance.volume, 'muted': instance.muted};
