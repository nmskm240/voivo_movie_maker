// Dart imports:
import 'dart:io';

// Package imports:
import 'package:path/path.dart' as p;

// Project imports:
import 'package:voivo_movie_maker/constants.dart';
import 'package:voivo_movie_maker/domain/project.dart';

final class ProjectDirectory {
  const ProjectDirectory(this.root);

  factory ProjectDirectory.inProjects(
    Directory projectsDirectory,
    ProjectId projectId,
  ) {
    return ProjectDirectory(
      Directory(p.join(projectsDirectory.path, projectId.value)),
    );
  }

  final Directory root;

  File get projectFile => File(p.join(root.path, projectFileName));
  Directory get assetsDirectory =>
      Directory(p.join(root.path, assetDirectoryName));
}
