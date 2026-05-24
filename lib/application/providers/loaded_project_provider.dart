import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/infra/project_repository.dart';

part "loaded_project_provider.freezed.dart";
part "loaded_project_provider.g.dart";

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
    final project = await repository.load();
    await repository.save(project);
    return ProjectSnapshot(project: project);
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
    await snapshot.project.assetStorage.add(asset, bytes);
    state = AsyncData(snapshot.copyWith(revision: snapshot.revision + 1));
    await ref.read(projectRepositoryProvider).save(snapshot.project);
  }
}
