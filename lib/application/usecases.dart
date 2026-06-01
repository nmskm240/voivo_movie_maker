import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/dtos/project_summary.dart';
import 'package:voivo_movie_maker/application/providers/project_repository.dart';
import 'package:voivo_movie_maker/domain/project.dart';

part "usecases.g.dart";

@riverpod
Future<List<ProjectSummary>> fetchProjectSummaries(Ref ref) async {
  final repository = ref.watch(projectRepositoryProvider);
  final projects = await repository.findAny();
  return projects.map(ProjectSummary.fromProject).toList();
}

@riverpod
Future<ProjectId> createProject(Ref ref, {String name = "untitled"}) async {
  final repository = ref.watch(projectRepositoryProvider);
  final project = Project.empty(name: name);
  await repository.save(project);
  return project.id;
}
