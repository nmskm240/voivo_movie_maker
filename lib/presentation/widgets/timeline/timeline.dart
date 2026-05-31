import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/application/providers/playback_controller_provider.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/widgets/assets/asset_timeline_drag_data.dart';
import 'package:voivo_movie_maker/presentation/widgets/timeline/providers.dart';
import 'package:voivo_movie_maker/application/services/asset_clip_picker.dart';
import 'package:voivo_movie_maker/presentation/widgets/timeline/playhead.dart';
import 'package:voivo_movie_maker/presentation/widgets/timeline/timeline_add_clip_button.dart';
import 'package:voivo_movie_maker/presentation/widgets/timeline/timeline_auto_scroller.dart';
import 'package:voivo_movie_maker/presentation/widgets/timeline/timeline_ruler.dart';
import 'package:voivo_movie_maker/presentation/widgets/timeline/timeline_track.dart';
import 'package:voivo_movie_maker/presentation/widgets/voice_generation/voice_editor.dart';

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
    final assetClipPicker = ref.read(assetClipPickerProvider);
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

    return Column(
      children: [
        Expanded(
          child: KeyedSubtree(
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
                                        onAutoScroll:
                                            autoScroller.autoScrollForDrag,
                                        onSeekFrame: playbackController.seek,
                                        onSelectTrack: () {
                                          selectedTrackController.select(index);
                                        },
                                        onAcceptAsset: (data, frame) {
                                          selectedTrackController.select(index);
                                          _addDroppedAsset(
                                            context: context,
                                            data: data,
                                            targetTrackIndex: index,
                                            startFrame: frame,
                                            timelineEditor: timelineEditor,
                                          );
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
                      final selectedAsset = await assetClipPicker.pickFor(kind);
                      if ((kind == TimelineClipKind.image ||
                              kind == TimelineClipKind.audio) &&
                          selectedAsset == null) {
                        return;
                      }

                      await timelineEditor.addClip(
                        targetTrackIndex: selectedTrackIndex ?? 0,
                        startFrame: playbackState.currentFrame,
                        kind: kind,
                        assetSelection: selectedAsset,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        VoiceEditor(onCreated: (_) async => {}),
      ],
    );
  }

  Future<void> _addDroppedAsset({
    required BuildContext context,
    required AssetTimelineDragData data,
    required int targetTrackIndex,
    required int startFrame,
    required TimelineEditor timelineEditor,
  }) async {
    try {
      final kind = switch (data.asset.kind) {
        ProjectAssetKind.image => TimelineClipKind.image,
        ProjectAssetKind.audio => TimelineClipKind.audio,
        ProjectAssetKind.video => null,
      };
      if (kind == null) {
        return;
      }

      final size = data.asset.kind == ProjectAssetKind.image
          ? await _defaultImageClipSize(data)
          : null;
      if (!context.mounted) {
        return;
      }

      timelineEditor.execute(
        AddClipCommand(
          targetTrackIndex: targetTrackIndex,
          startFrame: startFrame,
          kind: kind,
          assetId: data.asset.id,
          size: size,
        ),
      );
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future<ui.Size> _defaultImageClipSize(AssetTimelineDragData data) async {
    final bytes = Uint8List.fromList([]);
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;
    const maxWidth = 640.0;
    const maxHeight = 360.0;
    final width = image.width.toDouble();
    final height = image.height.toDouble();
    final scale = (maxWidth / width).clamp(0.0, 1.0);
    final constrainedScale = (maxHeight / height).clamp(0.0, scale);
    return ui.Size(width * constrainedScale, height * constrainedScale);
  }
}
