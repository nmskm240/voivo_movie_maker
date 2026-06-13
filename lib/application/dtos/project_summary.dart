// Project imports:
import 'package:voivo_movie_maker/domain/project.dart';

final class ProjectSummary {
  const ProjectSummary._(this.id, this.name);

  final ProjectId id;
  final String name;

  factory ProjectSummary.fromProject(Project project) {
    return ProjectSummary._(project.id, project.name);
  }
}
