// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectId _$ProjectIdFromJson(Map<String, dynamic> json) =>
    ProjectId(json['value'] as String);

Map<String, dynamic> _$ProjectIdToJson(ProjectId instance) => <String, dynamic>{
  'value': instance.value,
};

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
  id: json['id'] == null ? null : ProjectId.fromJson(json['id'] as String),
  name: json['name'] as String? ?? 'Untitled Project',
  width: (json['width'] as num?)?.toDouble() ?? 1920,
  height: (json['height'] as num?)?.toDouble() ?? 1080,
  fps: (json['fps'] as num?)?.toInt() ?? 30,
  sampleRate: (json['sampleRate'] as num?)?.toInt() ?? 48,
  assets: ProjectAssetCatalog.fromJson(json['assets'] as Map<String, dynamic>),
  timeline: Timeline.fromJson(json['timeline'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
  'id': instance.id.toJson(),
  'name': instance.name,
  'width': instance.width,
  'height': instance.height,
  'fps': instance.fps,
  'sampleRate': instance.sampleRate,
  'assets': instance.assets.toJson(),
  'timeline': instance.timeline.toJson(),
};
