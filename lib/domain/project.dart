import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

class Project {
  Project({
    this.width = 1920,
    this.height = 1080,
    this.fps = 30,
    this.sampleRate = 48,
    ProjectAssetSource? assetLibrary,
    required this.timeline,
  }) : assetSource = assetLibrary ?? ProjectAssetSource();

  factory Project.empty() {
    return Project(timeline: Timeline.empty());
  }

  final double width;
  final double height;
  final int fps;
  final int sampleRate;
  final ProjectAssetSource assetSource;
  final Timeline timeline;
}
