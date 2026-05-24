import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/commands/add_clip_command.dart';
import 'package:voivo_movie_maker/application/controllers/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/features/timeline/providers.dart';
import 'package:voivo_movie_maker/features/timeline/widget/playhead.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_add_clip_button.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_auto_scroller.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_ruler.dart';
import 'package:voivo_movie_maker/features/timeline/widget/timeline_track.dart';

const _timelineDurationFrames = 3600;

class TimelinePane extends ConsumerStatefulWidget {
  const TimelinePane({super.key});

  @override
  ConsumerState<TimelinePane> createState() => _TimelinePaneState();
}

class _TimelinePaneState extends ConsumerState<TimelinePane> {
  final _horizontalScrollController = ScrollController();
  final _verticalScrollController = ScrollController();
  final _trackListKey = GlobalKey();
  final _timelineViewportKey = GlobalKey();

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadedProject = ref.watch(loadedProjectProvider);
    return loadedProject.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (_) => _buildLoaded(context),
    );
  }

  Widget _buildLoaded(BuildContext context) {
    final playbackState = ref.watch(playbackControllerProvider);
    final playbackController = ref.read(playbackControllerProvider.notifier);
    final timeline = ref.watch(timelineInfoProvider);
    final timelineEditor = ref.read(timelineEditorProvider);
    final selectedTrackIndex = ref.watch(selectedTimelineTrackIndexProvider);
    final selectedTrackController = ref.read(
      selectedTimelineTrackIndexProvider.notifier,
    );
    final autoScroller = TimelineAutoScroller(
      viewportKey: _timelineViewportKey,
      horizontalScrollController: _horizontalScrollController,
      verticalScrollController: _verticalScrollController,
      timelineDurationFrames: _timelineDurationFrames,
    );

    return KeyedSubtree(
      key: _timelineViewportKey,
      child: Stack(
        children: [
          Scrollbar(
            controller: _horizontalScrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: _timelineDurationFrames.toDouble(),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onPanDown: (details) {
                            playbackController.seek(
                              autoScroller.frameAtGlobalPosition(
                                details.globalPosition,
                              ),
                            );
                          },
                          onHorizontalDragUpdate: (details) {
                            autoScroller.autoScrollForDrag(
                              details.globalPosition,
                              vertical: false,
                            );
                            playbackController.seek(
                              autoScroller.frameAtGlobalPosition(
                                details.globalPosition,
                              ),
                            );
                          },
                          child: const TimelineRuler(),
                        ),
                        Expanded(
                          child: Scrollbar(
                            controller: _verticalScrollController,
                            thumbVisibility: true,
                            child: ListView.builder(
                              key: _trackListKey,
                              controller: _verticalScrollController,
                              itemExtent: TimelineTrackView.height,
                              itemCount: timeline.tracks.length,
                              itemBuilder: (context, index) {
                                final track = timeline.tracks[index];
                                return TimelineTrackView(
                                  track: track,
                                  index: index,
                                  trackCount: timeline.tracks.length,
                                  trackListKey: _trackListKey,
                                  horizontalScrollController:
                                      _horizontalScrollController,
                                  trackScrollController:
                                      _verticalScrollController,
                                  onAutoScroll: autoScroller.autoScrollForDrag,
                                  onSeekFrame: playbackController.seek,
                                  onSelectTrack: () {
                                    selectedTrackController.select(index);
                                  },
                                  selected: selectedTrackIndex == index,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: playbackState.currentFrame.toDouble() - 5,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onPanDown: (details) {
                          playbackController.seek(
                            autoScroller.frameAtGlobalPosition(
                              details.globalPosition,
                            ),
                          );
                        },
                        onHorizontalDragUpdate: (details) {
                          autoScroller.autoScrollForDrag(
                            details.globalPosition,
                            vertical: false,
                          );
                          playbackController.seek(
                            autoScroller.frameAtGlobalPosition(
                              details.globalPosition,
                            ),
                          );
                        },
                        child: const SizedBox(
                          width: 12,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 5,
                                width: 2,
                                child: Playhead(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: TimelineAddClipButton(
              onSelected: (kind) async {
                final imageAsset = kind == TimelineClipKind.image
                    ? await _pickImageAsset()
                    : null;
                if (kind == TimelineClipKind.image && imageAsset == null) {
                  return;
                }

                if (imageAsset != null) {
                  await ref
                      .read(loadedProjectProvider.notifier)
                      .addAsset(
                        imageAsset.asset,
                        Stream.value(imageAsset.bytes),
                      );
                }

                timelineEditor.execute(
                  AddClipCommand(
                    targetTrackIndex: selectedTrackIndex ?? 0,
                    startFrame: playbackState.currentFrame,
                    kind: kind,
                    assetId: imageAsset?.asset.id,
                    size: imageAsset?.clipSize,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<({ProjectAsset asset, Uint8List bytes, Size clipSize})?>
  _pickImageAsset() async {
    final result = await FilePicker.pickFiles(
      type: FileType.image,
      withData: true,
    );
    final file = result?.files.singleOrNull;
    if (file == null || (file.bytes == null && file.path == null)) {
      return null;
    }
    final bytes = file.bytes ?? await file.xFile.readAsBytes();

    final image = await _decodeImage(bytes);
    final asset = ProjectAsset(
      id: AssetId.create(),
      name: file.name,
      kind: ProjectAssetKind.image,
    );

    return (asset: asset, bytes: bytes, clipSize: _defaultClipSize(image));
  }

  Future<ui.Image> _decodeImage(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Size _defaultClipSize(ui.Image image) {
    const maxWidth = 640.0;
    const maxHeight = 360.0;
    final width = image.width.toDouble();
    final height = image.height.toDouble();
    final scale = math.min(1.0, math.min(maxWidth / width, maxHeight / height));

    return Size(width * scale, height * scale);
  }
}
