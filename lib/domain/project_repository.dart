import 'package:voivo_movie_maker/domain/project.dart';

abstract interface class ProjectRepository {
  Future<Project> load();
  Future<void> save(Project project);
}
