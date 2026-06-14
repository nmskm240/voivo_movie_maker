// Package imports:
import 'package:cuid2/cuid2.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part 'project.g.dart';

@JsonSerializable()
class ProjectId {
  const ProjectId(this.value);
  factory ProjectId.create() {
    return ProjectId(cuid());
  }
  factory ProjectId.fromString(String value) {
    if (value.isEmpty) {
      throw ArgumentError.value(value, "value", "ProjectId cannot be empty");
    }
    if (!isCuid(value)) {
      throw FormatException("Invalid id format");
    }
    return ProjectId(value);
  }
  factory ProjectId.fromJson(Map<String, Object?> value) =>
      _$ProjectIdFromJson(value);

  final String value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ProjectId && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;

  Map<String, Object?> toJson() => _$ProjectIdToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Project {
  Project({
    ProjectId? id,
    this.name = 'Untitled Project',
    this.width = 1920,
    this.height = 1080,
    this.fps = 30,
    this.sampleRate = 48,
    required this.assets,
    required this.timeline,
  }) : id = id ?? ProjectId.create();

  factory Project.empty({String name = 'Untitled Project'}) {
    return Project(
      name: name,
      assets: ProjectAssetCatalog(),
      timeline: Timeline.empty(),
    );
  }
  factory Project.fromJson(Map<String, Object?> json) =>
      _$ProjectFromJson(json);

  final ProjectId id;
  final String name;
  final double width;
  final double height;
  final int fps;
  final int sampleRate;
  final ProjectAssetCatalog assets;
  final Timeline timeline;

  Map<String, Object?> toJson() => _$ProjectToJson(this);
}

abstract interface class IProjectRepository {
  Future<List<Project>> findAny();
  Future<Project> getById(ProjectId id);
  Future<void> save(Project project);
  Future<void> delete(ProjectId id);
}
