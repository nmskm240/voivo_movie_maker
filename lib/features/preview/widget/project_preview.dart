import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/image_clip.dart';
import 'package:voivo_movie_maker/features/preview/painters/project_preview_painter.dart';

class ProjectPreview extends ConsumerStatefulWidget {
  const ProjectPreview({super.key});

  @override
  ConsumerState<ProjectPreview> createState() => _ProjectPreviewState();
}

class _ProjectPreviewState extends ConsumerState<ProjectPreview> {
  final Map<AssetId, ui.Image> _imagesByAssetId = {};
  final Set<AssetId> _loadingAssetIds = {};

  @override
  Widget build(BuildContext context) {
    final projectSnapshot = ref.watch(loadedProjectProvider);
    final currentFrame = ref.watch(
      playbackControllerProvider.select((state) => state.currentFrame),
    );

    return projectSnapshot.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (projectSnapshot) {
        final project = projectSnapshot.project;
        _loadImages(project);
        return Center(
          child: AspectRatio(
            aspectRatio: project.width / project.height,
            child: ClipRect(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: CustomPaint(
                      painter: ProjectPreviewPainter(
                        project,
                        currentFrame,
                        projectSnapshot.revision,
                        imagesByAssetId: _imagesByAssetId,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _loadImages(Project project) {
    final imageAssetIds = project.timeline.tracks
        .expand((track) => track.clips)
        .whereType<ImageClip>()
        .map((clip) => clip.assetId)
        .toSet();

    _disposeRemovedImages(imageAssetIds);

    for (final assetId in imageAssetIds) {
      if (_imagesByAssetId.containsKey(assetId) ||
          _loadingAssetIds.contains(assetId)) {
        continue;
      }
      _loadingAssetIds.add(assetId);
      _loadImage(project, assetId);
    }
  }

  Future<void> _loadImage(Project project, AssetId assetId) async {
    try {
      final bytes = await _readAssetBytes(project, assetId);
      final image = await _decodeImage(bytes);
      if (!mounted) {
        image.dispose();
        return;
      }

      setState(() {
        _imagesByAssetId[assetId]?.dispose();
        _imagesByAssetId[assetId] = image;
      });
    } catch (error) {
      debugPrint('Failed to load preview image asset $assetId: $error');
    } finally {
      _loadingAssetIds.remove(assetId);
    }
  }

  Future<Uint8List> _readAssetBytes(Project project, AssetId assetId) async {
    final builder = BytesBuilder(copy: false);
    await for (final chunk in project.assetStorage.getBytesById(assetId)) {
      builder.add(chunk);
    }
    return builder.takeBytes();
  }

  Future<ui.Image> _decodeImage(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  void _disposeRemovedImages(Set<AssetId> imageAssetIds) {
    final removedAssetIds = _imagesByAssetId.keys
        .where((assetId) => !imageAssetIds.contains(assetId))
        .toList();
    for (final assetId in removedAssetIds) {
      _imagesByAssetId.remove(assetId)?.dispose();
    }
  }

  @override
  void dispose() {
    for (final image in _imagesByAssetId.values) {
      image.dispose();
    }
    super.dispose();
  }
}
