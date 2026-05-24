// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineTrack _$TimelineTrackFromJson(Map<String, dynamic> json) =>
    TimelineTrack(
      clips: json['clips'] == null
          ? const []
          : timelineClipsFromJson(json['clips'] as List),
    );

Map<String, dynamic> _$TimelineTrackToJson(TimelineTrack instance) =>
    <String, dynamic>{'clips': timelineClipsToJson(instance.clips)};
