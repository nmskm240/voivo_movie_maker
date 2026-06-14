// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:voivo_movie_maker/application/services/rendering/project_frame.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';

class ProjectFrameBuilder {
  const ProjectFrameBuilder({this.imageAssets = const {}});

  final Map<AssetId, Image> imageAssets;

  ProjectFrame build(Project project, int frameNumber) {
    return ProjectFrame(
      projectSize: Size(project.width, project.height),
      frameNumber: frameNumber,
      clips: project.timeline.getActiveClipsAt(frameNumber),
      imageAssets: imageAssets,
    );
  }
}
