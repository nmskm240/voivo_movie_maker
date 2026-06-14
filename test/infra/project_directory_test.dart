// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

// Project imports:
import 'package:voivo_movie_maker/constants.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/infra/project_directory.dart';

void main() {
  test('resolves project paths below the projects directory', () {
    final projectsDirectory = Directory(p.join('workspace', 'projects'));
    final projectId = ProjectId.create();

    final directory = ProjectDirectory.inProjects(projectsDirectory, projectId);

    final expectedRoot = p.join(projectsDirectory.path, projectId.value);
    expect(directory.root.path, expectedRoot);
    expect(directory.projectFile.path, p.join(expectedRoot, projectFileName));
    expect(
      directory.assetsDirectory.path,
      p.join(expectedRoot, assetDirectoryName),
    );
  });
}
