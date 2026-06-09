import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part "providers.g.dart";

@riverpod
IProjectRepository projectRepository(Ref ref) {
  throw UnimplementedError();
}

@riverpod
ProjectId projectId(Ref ref) {
  throw UnimplementedError();
}

@Riverpod(dependencies: [projectId])
Future<Project> project(Ref ref) async {
  final repository = ref.watch(projectRepositoryProvider);
  final id = ref.watch(projectIdProvider);
  debugPrint('Loading project for projectId: $id');
  return repository.getById(id);
}

@Riverpod(name: 'timelineProvider', dependencies: [project])
class CurrentTimeline extends _$CurrentTimeline {
  @override
  Future<Timeline> build() async {
    final project = await ref.watch(projectProvider.future);
    return project.timeline;
  }

  void notifyChanged() {
    ref.notifyListeners();
  }
}
