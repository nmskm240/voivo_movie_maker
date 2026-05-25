// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpeakerStyle _$SpeakerStyleFromJson(Map<String, dynamic> json) =>
    _SpeakerStyle(
      speakerName: json['speakerName'] as String,
      styleName: json['styleName'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$SpeakerStyleToJson(_SpeakerStyle instance) =>
    <String, dynamic>{
      'speakerName': instance.speakerName,
      'styleName': instance.styleName,
      'id': instance.id,
    };
