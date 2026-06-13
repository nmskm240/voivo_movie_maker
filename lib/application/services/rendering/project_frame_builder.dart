// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:voivo_movie_maker/application/services/rendering/project_frame.dart';
import 'package:voivo_movie_maker/domain/project.dart';

class ProjectFrameBuilder {
  const ProjectFrameBuilder();

  ProjectFrame build(Project project, int frameNumber) {
    return ProjectFrame(
      projectSize: Size(project.width, project.height),
      frameNumber: frameNumber,
      clips: project.timeline.getActiveClipsAt(frameNumber),
    );
  }
}
