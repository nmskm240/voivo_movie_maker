// Dart imports:
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/infra/project_assets/project_asset_bytes_loader.dart';
import 'package:voivo_movie_maker/infra/project_assets/project_asset_cache.dart';
import 'package:voivo_movie_maker/infra/project_assets/project_image_decoder.dart';

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
ProjectAssetCache<ui.Image> projectImageCache(Ref ref) {
  final cache = ProjectAssetCache<ui.Image>(
    ref.watch(projectAssetStoreProvider),
    kind: ProjectAssetKind.image,
    loadAsset: decodeProjectImage,
    disposeAsset: (image) => image.dispose(),
    label: 'image',
  );
  ref.onDispose(cache.dispose);
  return cache;
}

@Riverpod(dependencies: [projectImageCache])
Stream<int> projectImageCacheRevision(Ref ref) {
  return ref.watch(projectImageCacheProvider).revisions;
}

@Riverpod(keepAlive: true, dependencies: [projectAssetStore])
ProjectAssetCache<Uint8List> projectAudioCache(Ref ref) {
  final cache = ProjectAssetCache<Uint8List>(
    ref.watch(projectAssetStoreProvider),
    kind: ProjectAssetKind.audio,
    loadAsset: loadProjectAssetBytes,
    label: 'audio',
  );
  ref.onDispose(cache.dispose);
  return cache;
}

@Riverpod(dependencies: [projectAudioCache])
Stream<int> projectAudioCacheRevision(Ref ref) {
  return ref.watch(projectAudioCacheProvider).revisions;
}

@Riverpod(keepAlive: true, dependencies: [projectAssetStore])
ProjectAssetCache<Uint8List> projectVideoCache(Ref ref) {
  final cache = ProjectAssetCache<Uint8List>(
    ref.watch(projectAssetStoreProvider),
    kind: ProjectAssetKind.video,
    loadAsset: loadProjectAssetBytes,
    label: 'video',
  );
  ref.onDispose(cache.dispose);
  return cache;
}

@Riverpod(dependencies: [projectVideoCache])
Stream<int> projectVideoCacheRevision(Ref ref) {
  return ref.watch(projectVideoCacheProvider).revisions;
}

@Riverpod(dependencies: [project])
class TimelineNotifier extends _$TimelineNotifier {
  @override
  Future<Timeline> build() async {
    final project = await ref.watch(projectProvider.future);
    return project.timeline;
  }
}
