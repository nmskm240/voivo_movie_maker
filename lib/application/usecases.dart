// Dart imports:
import 'dart:io';
import 'dart:ui' show Size;

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/project_summary.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/export/export_operation.dart';
import 'package:voivo_movie_maker/application/services/export/export_result.dart';
import 'package:voivo_movie_maker/application/services/export/project_exporter.dart';
import 'package:voivo_movie_maker/application/services/export/ffmpeg_project_encoder.dart';
import 'package:voivo_movie_maker/application/services/export/project_frame_stream_writer.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame_builder.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

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

@Riverpod(dependencies: [project, projectAssetStore])
Future<ProjectAsset> importProjectAsset(Ref ref, File file) async {
  final project = await ref.watch(projectProvider.future);
  final store = ref.watch(projectAssetStoreProvider);
  final repository = ref.watch(projectRepositoryProvider);
  final asset = await store.save(file);

  try {
    project.assets.add(asset);
    try {
      await repository.save(project);
    } catch (_) {
      project.assets.remove(asset.id);
      rethrow;
    }
    return asset;
  } catch (error, stackTrace) {
    try {
      await store.delete(asset);
    } catch (_) {
      // Preserve the original import failure.
    }
    Error.throwWithStackTrace(error, stackTrace);
  }
}

@Riverpod(dependencies: [project, projectImageResources, timelineEditor])
Future<TimelineClip?> addImageClipToTimeline(
  Ref ref, {
  required int trackIndex,
  required ProjectAsset asset,
  required int startFrame,
}) async {
  final project = await ref.watch(projectProvider.future);
  if (asset.kind != ProjectAssetKind.image ||
      project.assets.findById(asset.id) == null) {
    return null;
  }

  final imageResources = ref.watch(projectImageResourcesProvider);
  final timelineEditor = ref.read(timelineEditorProvider);
  final image = await imageResources.load(asset);
  final clip = TimelineClip(
    id: TimelineClipId.create(),
    startFrame: startFrame,
    durationFrames: 90,
    components: [
      TransformComponent(),
      ImageComponent(
        assetId: asset.id,
        size: Size(image.width.toDouble(), image.height.toDouble()),
      ),
    ],
  );
  final command = AddClipCommand(targetTrackIndex: trackIndex, clip: clip);
  if (!command.canExecute(project.timeline)) {
    return null;
  }

  await timelineEditor.execute(project, command);
  return clip;
}

@Riverpod(dependencies: [project, projectImageResources])
Future<ExportResult?> exportProject(Ref ref, ExportOperation operation) async {
  final project = await ref.watch(projectProvider.future);
  final imageResources = ref.read(projectImageResourcesProvider);
  await imageResources.loadAll(
    project.assets.assets.where(
      (asset) => asset.kind == ProjectAssetKind.image,
    ),
  );
  final exporter = ProjectExporter(
    encoder: FfmpegProjectEncoder(
      frameStreamWriter: ProjectFrameStreamWriter(
        frameBuilder: ProjectFrameBuilder(imageAssets: imageResources.images),
      ),
    ),
  );
  return exporter.export(project, operation: operation);
}
