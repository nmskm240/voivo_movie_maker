// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineTrack _$TimelineTrackFromJson(Map<String, dynamic> json) =>
    TimelineTrack(
      clips:
          (json['clips'] as List<dynamic>?)?.map(
            (e) => TimelineClip.fromJson(e as Map<String, dynamic>),
          ) ??
          const [],
    );

Map<String, dynamic> _$TimelineTrackToJson(TimelineTrack instance) =>
    <String, dynamic>{'clips': instance.clips.map((e) => e.toJson()).toList()};
