// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timeline _$TimelineFromJson(Map<String, dynamic> json) => Timeline(
  tracks:
      (json['tracks'] as List<dynamic>?)?.map(
        (e) => TimelineTrack.fromJson(e as Map<String, dynamic>),
      ) ??
      const [],
);

Map<String, dynamic> _$TimelineToJson(Timeline instance) => <String, dynamic>{
  'tracks': instance.tracks.map((e) => e.toJson()).toList(),
};
