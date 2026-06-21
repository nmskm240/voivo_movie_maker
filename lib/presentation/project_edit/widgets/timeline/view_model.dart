// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/timeline_info.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/playback_controller.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_track_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/move_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/remove_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/resize_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/application/usecases.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';

part 'view_model.freezed.dart';
part 'view_model.g.dart';

@freezed
sealed class TimelineViewState with _$TimelineViewState {
  const factory TimelineViewState({
    required TimelineInfo timeline,
    @Default(1.0) double pixelsPerFrame,
    @Default(0) int revision,
  }) = _TimelineViewState;
}

@Riverpod(
  dependencies: [
    TimelineNotifier,
    timelineEditor,
    PlaybackController,
    TimelineSelectionState,
    project,
    addAudioClipToTimeline,
    addImageClipToTimeline,
    addVideoClipToTimeline,
  ],
)
class TimelineViewModel extends _$TimelineViewModel {
  static const minPixelsPerFrame = 0.25;
  static const maxPixelsPerFrame = 8.0;

  @override
  Future<TimelineViewState> build() async {
    final pixelsPerFrame = state.value?.pixelsPerFrame ?? 1.0;
    final timeline = await ref.watch(timelineProvider.future);
    return TimelineViewState(
      timeline: TimelineInfo.fromEntity(timeline),
      pixelsPerFrame: pixelsPerFrame,
    );
  }

  Future<bool> execute(TimelineEditorCommand command) async {
    final project = await ref.read(projectProvider.future);
    final timeline = ref.read(timelineProvider).value;
    final current = state.value;
    if (timeline == null || current == null) {
      return false;
    }
    if (!command.canExecute(timeline)) {
      return false;
    }

    final save = ref.read(timelineEditorProvider).execute(project, command);
    state = AsyncData(
      current.copyWith(
        timeline: TimelineInfo.fromEntity(timeline),
        revision: current.revision + 1,
      ),
    );
    await save;
    return true;
  }

  Future<void> addClip(int trackIndex) async {
    final clip = TimelineClip(
      id: TimelineClipId.create(),
      startFrame: ref.read(playbackControllerProvider).currentFrame,
      durationFrames: 90,
    );
    final added = await execute(
      AddClipCommand(targetTrackIndex: trackIndex, clip: clip),
    );
    if (!added) {
      return;
    }

    _selectClip(trackIndex, clip.id);
  }

  Future<bool> addTrack() async {
    if (!await execute(const AddTrackCommand())) {
      return false;
    }

    final timeline = ref.read(timelineProvider).value;
    if (timeline != null) {
      ref
          .read(timelineSelectionStateProvider.notifier)
          .selectTrack(timeline.tracks.length - 1);
    }
    return true;
  }

  Future<bool> addImageClip(
    int trackIndex,
    ProjectAsset asset, {
    int? startFrame,
  }) async {
    final clip = await ref.read(
      addImageClipToTimelineProvider(
        trackIndex: trackIndex,
        asset: asset,
        startFrame:
            startFrame ?? ref.read(playbackControllerProvider).currentFrame,
      ).future,
    );
    if (clip == null) {
      return false;
    }

    _refreshTimelineState();
    _selectClip(trackIndex, clip.id);
    return true;
  }

  Future<bool> addAudioClip(
    int trackIndex,
    ProjectAsset asset, {
    int? startFrame,
  }) async {
    final clip = await ref.read(
      addAudioClipToTimelineProvider(
        trackIndex: trackIndex,
        asset: asset,
        startFrame:
            startFrame ?? ref.read(playbackControllerProvider).currentFrame,
      ).future,
    );
    if (clip == null) {
      return false;
    }

    _refreshTimelineState();
    _selectClip(trackIndex, clip.id);
    return true;
  }

  Future<bool> addVideoClip(
    int trackIndex,
    ProjectAsset asset, {
    int? startFrame,
  }) async {
    final clip = await ref.read(
      addVideoClipToTimelineProvider(
        trackIndex: trackIndex,
        asset: asset,
        startFrame:
            startFrame ?? ref.read(playbackControllerProvider).currentFrame,
      ).future,
    );
    if (clip == null) {
      return false;
    }

    _refreshTimelineState();
    _selectClip(trackIndex, clip.id);
    return true;
  }

  Future<bool> moveClip(
    TimelineClipId clipId, {
    required int targetTrackIndex,
    required int startFrame,
  }) async {
    final command = MoveClipCommand(
      clipId,
      targetTrackIndex: targetTrackIndex,
      startFrame: startFrame,
    );
    if (!await execute(command)) {
      return false;
    }

    ref
        .read(timelineSelectionStateProvider.notifier)
        .selectTrack(targetTrackIndex);
    ref.read(timelineSelectionStateProvider.notifier).selectClip(clipId);
    return true;
  }

  Future<bool> removeClip(TimelineClipId clipId) async {
    if (!await execute(RemoveClipCommand(clipId))) {
      return false;
    }

    final selection = ref.read(timelineSelectionStateProvider);
    if (selection.clipId == clipId) {
      ref.read(timelineSelectionStateProvider.notifier).clearClip();
    }
    return true;
  }

  Future<bool> resizeClip(
    TimelineClipId clipId, {
    required int startFrame,
    required int durationFrames,
  }) async {
    final resized = await execute(
      ResizeClipCommand(
        clipId,
        startFrame: startFrame,
        durationFrames: durationFrames,
      ),
    );
    if (resized) {
      ref.read(timelineSelectionStateProvider.notifier).selectClip(clipId);
    }
    return resized;
  }

  void setPixelsPerFrame(double pixelsPerFrame) {
    final current = state.value;
    if (current == null) {
      return;
    }

    state = AsyncData(
      current.copyWith(
        pixelsPerFrame: pixelsPerFrame.clamp(
          minPixelsPerFrame,
          maxPixelsPerFrame,
        ),
      ),
    );
  }

  void _refreshTimelineState() {
    final timeline = ref.read(timelineProvider).value;
    final current = state.value;
    if (timeline == null || current == null) {
      return;
    }
    state = AsyncData(
      current.copyWith(
        timeline: TimelineInfo.fromEntity(timeline),
        revision: current.revision + 1,
      ),
    );
  }

  void _selectClip(int trackIndex, TimelineClipId clipId) {
    final selection = ref.read(timelineSelectionStateProvider.notifier);
    selection.selectTrack(trackIndex);
    selection.selectClip(clipId);
  }
}
