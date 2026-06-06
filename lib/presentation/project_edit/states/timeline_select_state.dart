import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

part "timeline_select_state.freezed.dart";
part "timeline_select_state.g.dart";

@freezed
sealed class TimelineSelection with _$TimelineSelection {
  const factory TimelineSelection({int? trackIndex, TimelineClipId? clipId}) =
      _TimelineSelection;
}

@riverpod
class TimelineSelectionState extends _$TimelineSelectionState {
  @override
  TimelineSelection build() {
    return TimelineSelection();
  }

  void selectTrack(int index) {
    state = state.copyWith(trackIndex: index);
  }

  void selectClip(TimelineClipId clipId) {
    state = state.copyWith(clipId: clipId);
  }

  void clearClip() {
    state = state.copyWith(clipId: null);
  }

  void clear() {
    state = const TimelineSelection();
  }
}
