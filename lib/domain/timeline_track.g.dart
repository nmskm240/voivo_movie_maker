// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineTrack _$TimelineTrackFromJson(Map<String, dynamic> json) =>
    TimelineTrack(
      clips:
          (json['clips'] as List<dynamic>?)?.map(
            (e) => const TimelineClipJsonConverter().fromJson(
              e as Map<String, Object?>,
            ),
          ) ??
          const [],
    );

Map<String, dynamic> _$TimelineTrackToJson(TimelineTrack instance) =>
    <String, dynamic>{
      'clips': instance.clips
          .map(const TimelineClipJsonConverter().toJson)
          .toList(),
    };
