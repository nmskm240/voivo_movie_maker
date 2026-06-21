// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/infra/project_assets/project_asset_cache.dart';

part "providers.g.dart";

@riverpod
IProjectRepository projectRepository(Ref ref) {
  throw UnimplementedError();
}

@riverpod
Directory projectsDirectory(Ref ref) {
  throw UnimplementedError();
}

@riverpod
ProjectId projectId(Ref ref) {
  throw UnimplementedError();
}

@riverpod
IProjectAssetStore projectAssetStore(Ref ref) {
  throw UnimplementedError();
}

@Riverpod(dependencies: [projectId])
Future<Project> project(Ref ref) async {
  final repository = ref.watch(projectRepositoryProvider);
  final id = ref.watch(projectIdProvider);
  debugPrint('Loading project for projectId: $id');
  return repository.getById(id);
}

@Riverpod(keepAlive: true, dependencies: [projectAssetStore])
ProjectImageResources projectImageResources(Ref ref) {
  final resources = ProjectImageResources(ref.watch(projectAssetStoreProvider));
  ref.onDispose(resources.dispose);
  return resources;
}

@Riverpod(dependencies: [projectImageResources])
Stream<int> projectImageResourcesRevision(Ref ref) {
  return ref.watch(projectImageResourcesProvider).revisions;
}

@Riverpod(dependencies: [project])
class TimelineNotifier extends _$TimelineNotifier {
  @override
  Future<Timeline> build() async {
    final project = await ref.watch(projectProvider.future);
    return project.timeline;
  }
}
