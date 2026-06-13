// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/timeline_info.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/playback_controller.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/move_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';

part 'view_model.freezed.dart';
part 'view_model.g.dart';

@freezed
sealed class TimelineViewState with _$TimelineViewState {
  const factory TimelineViewState({
    required TimelineInfo timeline,
    @Default(1.0) double pixelsPerFrame,
    @Default(0.0) double horizontalScrollOffset,
    @Default(0) int revision,
  }) = _TimelineViewState;
}

@Riverpod(
  dependencies: [
    TimelineNotifier,
    timelineEditor,
    PlaybackController,
    TimelineSelectionState,
  ],
)
class TimelineViewModel extends _$TimelineViewModel {
  static const minPixelsPerFrame = 0.25;
  static const maxPixelsPerFrame = 8.0;

  @override
  Future<TimelineViewState> build() async {
    final pixelsPerFrame = state.value?.pixelsPerFrame ?? 1.0;
    final horizontalScrollOffset = state.value?.horizontalScrollOffset ?? 0.0;
    final timeline = await ref.watch(timelineProvider.future);
    return TimelineViewState(
      timeline: TimelineInfo.fromEntity(timeline),
      pixelsPerFrame: pixelsPerFrame,
      horizontalScrollOffset: horizontalScrollOffset,
    );
  }

  bool execute(TimelineEditorCommand command) {
    final timeline = ref.read(timelineProvider).value;
    final current = state.value;
    if (timeline == null || current == null) {
      return false;
    }
    if (!command.canExecute(timeline)) {
      return false;
    }

    ref.read(timelineEditorProvider).execute(timeline, command);
    state = AsyncData(
      current.copyWith(
        timeline: TimelineInfo.fromEntity(timeline),
        revision: current.revision + 1,
      ),
    );
    return true;
  }

  void addClip(int trackIndex) {
    final clip = TimelineClip(
      id: TimelineClipId.create(),
      startFrame: ref.read(playbackControllerProvider).currentFrame,
      durationFrames: 90,
    );
    final added = execute(
      AddClipCommand(targetTrackIndex: trackIndex, clip: clip),
    );
    if (!added) {
      return;
    }

    ref.read(timelineSelectionStateProvider.notifier).selectTrack(trackIndex);
    ref.read(timelineSelectionStateProvider.notifier).selectClip(clip.id);
  }

  bool moveClip(
    TimelineClipId clipId, {
    required int targetTrackIndex,
    required int startFrame,
  }) {
    final command = MoveClipCommand(
      clipId,
      targetTrackIndex: targetTrackIndex,
      startFrame: startFrame,
    );
    if (!execute(command)) {
      return false;
    }

    ref
        .read(timelineSelectionStateProvider.notifier)
        .selectTrack(targetTrackIndex);
    ref.read(timelineSelectionStateProvider.notifier).selectClip(clipId);
    return true;
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

  void setHorizontalScrollOffset(double offset) {
    final current = state.value;
    if (current == null || current.horizontalScrollOffset == offset) {
      return;
    }

    state = AsyncData(
      current.copyWith(
        horizontalScrollOffset: offset.clamp(0.0, double.infinity),
      ),
    );
  }
}
