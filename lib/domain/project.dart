import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  Project({
    this.width = 1920,
    this.height = 1080,
    this.fps = 30,
    this.sampleRate = 48,
    required this.assets,
    required this.timeline,
  });

  factory Project.empty() {
    return Project(assets: ProjectAssetCatalog(), timeline: Timeline.empty());
  }
  factory Project.fromJson(Map<String, Object?> json) =>
      _$ProjectFromJson(json);

  final double width;
  final double height;
  final int fps;
  final int sampleRate;
  final ProjectAssetCatalog assets;
  final Timeline timeline;

  Map<String, Object?> toJson() => _$ProjectToJson(this);
}

abstract interface class IProjectReader {
  Future<Project> read();
}

abstract interface class IProjectWriter {
  Future<void> write(Project project);
}
