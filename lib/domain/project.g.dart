// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
  width: (json['width'] as num?)?.toDouble() ?? 1920,
  height: (json['height'] as num?)?.toDouble() ?? 1080,
  fps: (json['fps'] as num?)?.toInt() ?? 30,
  sampleRate: (json['sampleRate'] as num?)?.toInt() ?? 48,
  assets: ProjectAssetCatalog.fromJson(json['assets'] as Map<String, dynamic>),
  timeline: Timeline.fromJson(json['timeline'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
  'width': instance.width,
  'height': instance.height,
  'fps': instance.fps,
  'sampleRate': instance.sampleRate,
  'assets': instance.assets.toJson(),
  'timeline': instance.timeline.toJson(),
};
