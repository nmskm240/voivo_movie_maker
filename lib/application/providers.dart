import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/domain/project.dart';

part "providers.g.dart";

@riverpod
IProjectRepository projectRepository(Ref ref) {
  throw UnimplementedError();
}

@riverpod
ProjectId projectId(Ref ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true, dependencies: [projectId])
Future<Project> project(Ref ref) async {
  final repository = ref.watch(projectRepositoryProvider);
  final id = ref.watch(projectIdProvider);
  debugPrint('Loading project for projectId: $id');
  return await repository.getById(id);
}
