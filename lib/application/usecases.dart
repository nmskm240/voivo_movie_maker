import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers/project_repository.dart';
import 'package:voivo_movie_maker/domain/project.dart';

part "usecases.g.dart";

@riverpod
Future<List<Project>> fetchProjects(Ref ref) async {
  final repository = ref.watch(projectRepositoryProvider);
  final projects = await repository.findAny();
  return projects;
}

@riverpod
Future<ProjectId> createProject(Ref ref, {String name = "untitled"}) async {
  final repository = ref.watch(projectRepositoryProvider);
  final project = Project.empty(name: name);
  await repository.save(project);
  return project.id;
}
