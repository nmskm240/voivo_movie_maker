import 'dart:io';
import 'dart:ui' show Size;

// Package imports:
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/project_summary.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/export/export_operation.dart';
import 'package:voivo_movie_maker/application/services/export/export_result.dart';
import 'package:voivo_movie_maker/application/services/export/project_exporter.dart';
import 'package:voivo_movie_maker/application/services/export/ffmpeg_project_encoder.dart';
import 'package:voivo_movie_maker/application/services/export/project_frame_stream_writer.dart';
import 'package:voivo_movie_maker/application/services/project_asset_importer.dart';
import 'package:voivo_movie_maker/application/services/rendering/project_frame_builder.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/application/services/asset_name_formatter.dart';
import 'package:voivo_movie_maker/application/services/voice_generator.dart';
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

@riverpod
Future<void> deleteProject(Ref ref, ProjectId projectId) async {
  await ref.watch(projectRepositoryProvider).delete(projectId);
}

@Riverpod(dependencies: [project])
Future<void> renameProjectAsset(
  Ref ref, {
  required AssetId assetId,
  required String name,
}) async {
  final repository = ref.read(projectRepositoryProvider);
  final project = await ref.watch(projectProvider.future);
  final current = project.assets.findById(assetId);
  if (current == null || current.name == name) {
    return;
  }

  final previousName = current.name;
  project.assets.rename(assetId, name);
  try {
    await repository.save(project);
  } catch (_) {
    project.assets.rename(assetId, previousName);
    rethrow;
  }
}

@Riverpod(
  dependencies: [
    project,
    projectAssetImporter,
    projectImageCache,
    projectAudioCache,
  ],
)
Future<ProjectAsset?> importProjectAsset(Ref ref) async {
  final importer = ref.read(projectAssetImporterProvider);
  final repository = ref.read(projectRepositoryProvider);
  final projectFuture = ref.watch(projectProvider.future);
  final evictAssetCache = _assetCacheEvictor(
    evictImageCache: ref.read(projectImageCacheProvider).evict,
    evictAudioCache: ref.read(projectAudioCacheProvider).evict,
  );
  final picked = await FilePicker.pickFiles(
    type: FileType.custom,
    allowedExtensions: const ['jpg', 'jpeg', 'png', 'mp3', 'wav'],
  );
  final path = picked?.files.single.path;
  if (path == null) {
    return null;
  }

  final project = await projectFuture;
  final file = File(path);
  final result = await importer.importFile(project, file);
  try {
    await repository.save(project);
    evictAssetCache(result.asset);
    return result.asset;
  } catch (_) {
    await result.rollback();
    rethrow;
  }
}

@Riverpod(dependencies: [project, projectAssetImporter, projectAudioCache])
Future<ProjectAsset> createVoiceAsset(
  Ref ref, {
  required String dialogue,
  required int speakerId,
  Directory? temporaryDirectory,
}) async {
  final importer = ref.read(projectAssetImporterProvider);
  final repository = ref.read(projectRepositoryProvider);
  final evictAudioCache = ref.read(projectAudioCacheProvider).evict;
  final voiceGeneratorFuture = ref.watch(voiceGeneratorProvider.future);
  final project = await ref.watch(projectProvider.future);
  final voiceGenerator = await voiceGeneratorFuture;
  final speakerStyle = voiceGenerator.speakerStyles.firstWhere(
    (style) => style.id == speakerId,
  );
  final audioBytes = await voiceGenerator.synthesize(
    text: dialogue,
    speakerId: speakerId,
  );
  final fileName = AssetNameFormatter.voice(
    speakerName: speakerStyle.speakerName,
    dialogue: dialogue,
  );
  final directory = temporaryDirectory ?? await getTemporaryDirectory();
  final file = File(p.join(directory.path, p.basename(fileName)));
  await file.writeAsBytes(audioBytes);

  try {
    final result = await importer.importFile(project, file);
    try {
      await repository.save(project);
      evictAudioCache(result.asset.id);
      return result.asset;
    } catch (_) {
      await result.rollback();
      rethrow;
    }
  } finally {
    if (await file.exists()) {
      await file.delete();
    }
  }
}

void Function(ProjectAsset asset) _assetCacheEvictor({
  required void Function(AssetId assetId) evictImageCache,
  required void Function(AssetId assetId) evictAudioCache,
}) {
  return (asset) {
    switch (asset.kind) {
      case ProjectAssetKind.image:
        evictImageCache(asset.id);
        break;
      case ProjectAssetKind.audio:
        evictAudioCache(asset.id);
        break;
      case ProjectAssetKind.video:
        break;
    }
  };
}

@Riverpod(dependencies: [project, projectImageCache, timelineEditor])
Future<TimelineClip?> addImageClipToTimeline(
  Ref ref, {
  required int trackIndex,
  required ProjectAsset asset,
  required int startFrame,
}) async {
  final imageCache = ref.watch(projectImageCacheProvider);
  final timelineEditor = ref.read(timelineEditorProvider);
  final project = await ref.watch(projectProvider.future);
  if (asset.kind != ProjectAssetKind.image ||
      project.assets.findById(asset.id) == null) {
    return null;
  }

  final image = await imageCache.load(asset);
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

@Riverpod(dependencies: [project, projectAudioCache, timelineEditor])
Future<TimelineClip?> addAudioClipToTimeline(
  Ref ref, {
  required int trackIndex,
  required ProjectAsset asset,
  required int startFrame,
}) async {
  final timelineEditor = ref.read(timelineEditorProvider);
  final audioCache = ref.watch(projectAudioCacheProvider);
  final project = await ref.watch(projectProvider.future);
  if (asset.kind != ProjectAssetKind.audio ||
      project.assets.findById(asset.id) == null) {
    return null;
  }

  await audioCache.load(asset);
  final clip = TimelineClip(
    id: TimelineClipId.create(),
    startFrame: startFrame,
    durationFrames: 90,
    components: [AudioComponent(assetId: asset.id)],
  );
  final command = AddClipCommand(targetTrackIndex: trackIndex, clip: clip);
  if (!command.canExecute(project.timeline)) {
    return null;
  }

  await timelineEditor.execute(project, command);
  return clip;
}

@Riverpod(dependencies: [project, projectImageCache, projectAudioCache])
Future<ExportResult?> exportProject(Ref ref, ExportOperation operation) async {
  final imageCache = ref.read(projectImageCacheProvider);
  final audioCache = ref.read(projectAudioCacheProvider);
  final project = await ref.watch(projectProvider.future);
  await imageCache.loadAll(
    project.assets.assets.where(
      (asset) => asset.kind == ProjectAssetKind.image,
    ),
  );
  await audioCache.loadAll(
    project.assets.assets.where(
      (asset) => asset.kind == ProjectAssetKind.audio,
    ),
  );
  final exporter = ProjectExporter(
    encoder: FfmpegProjectEncoder(
      audioAssets: audioCache.values,
      frameStreamWriter: ProjectFrameStreamWriter(
        frameBuilder: ProjectFrameBuilder(imageAssets: imageCache.values),
      ),
    ),
  );
  return exporter.export(project, operation: operation);
}
