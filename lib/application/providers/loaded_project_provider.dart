import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers/project_repository.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';

part "loaded_project_provider.freezed.dart";
part "loaded_project_provider.g.dart";

final loadedProjectIdProvider = Provider<ProjectId?>((ref) => null);

@freezed
sealed class ProjectSnapshot with _$ProjectSnapshot {
  const factory ProjectSnapshot({
    required Project project,
    @Default(0) int revision,
  }) = _ProjectSnapshot;
}

@riverpod
class ProjectPath extends _$ProjectPath {
  @override
  Directory build() {
    return Directory(
      p.join('/home/am240/ドキュメント/projects/voivo_movie_maker', '.dev_project'),
    );
  }

  void set(Directory directory) {
    state = directory;
  }
}

@riverpod
class LoadedProject extends _$LoadedProject {
  @override
  Future<ProjectSnapshot> build() async {
    final repository = ref.watch(projectRepositoryProvider);
    final projectId = ref.watch(loadedProjectIdProvider);
    if (projectId != null) {
      final project = await repository.getById(projectId);
      return ProjectSnapshot(project: project);
    }

    final project = await _loadExistingOrCreate(repository);
    return ProjectSnapshot(project: project);
  }

  Future<Project> _loadExistingOrCreate(IProjectRepository repository) async {
    final projects = await repository.findAny();
    if (projects.isNotEmpty) {
      return projects.first;
    }
    final project = Project.empty();
    await repository.save(project);
    return project;
  }

  Future<void> markChanged({bool save = true}) async {
    final snapshot = state.requireValue;
    state = AsyncData(snapshot.copyWith(revision: snapshot.revision + 1));
    if (save) {
      await ref.read(projectRepositoryProvider).save(snapshot.project);
    }
  }

  Future<void> save() async {
    final snapshot = state.requireValue;
    await ref.read(projectRepositoryProvider).save(snapshot.project);
  }

  Future<void> addAsset(ProjectAsset asset, Stream<List<int>> bytes) async {
    final snapshot = state.requireValue;
    snapshot.project.assets.add(asset);
    state = AsyncData(snapshot.copyWith(revision: snapshot.revision + 1));
    await ref.read(projectRepositoryProvider).save(snapshot.project);
  }
}
