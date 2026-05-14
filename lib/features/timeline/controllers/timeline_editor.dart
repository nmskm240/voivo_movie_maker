import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/text_clip.dart';

part 'timeline_editor.g.dart';

@riverpod
TimelineEditor timelineEditor(Ref ref) {
  final timeline = ref.watch(loadedProjectProvider).project.timeline;
  final markChanged = ref.read(loadedProjectProvider.notifier).markChanged;
  return TimelineEditor(timeline, markChanged);
}

class TimelineEditor {
  final Timeline _timeline;
  final void Function() _markChanged;

  const TimelineEditor(this._timeline, this._markChanged);

  void addNewClipToTrack({
    required int targetTrackIndex,
    required int startFrame,
  }) {
    final track = _timeline.tracks.elementAt(targetTrackIndex);
    // TODO: factoryにする
    final clip = TextClip(
      "text",
      id: TimelineClipId.create(),
      startFrame: startFrame,
      fontFamily: 'Noto Sans CJK JP',
      size: 48,
      color: const Color(0xffffffff),
    );
    track.addClip(clip);
    _markChanged();
  }

  void moveClipToTrack(
    TimelineClipId clipId, {
    required int targetTrackIndex,
    required int startFrame,
  }) {
    final clip = _timeline.getClipById(clipId);
    final currentTrack = _timeline.getTrackByClipId(clipId);
    final currentTrackIndex = _timeline.tracks.toList().indexOf(currentTrack);
    final targetTrack = _timeline.tracks.elementAt(targetTrackIndex);
    if (!targetTrack.canPlaceClip(clip, startFrame: startFrame)) {
      return;
    }

    if (currentTrackIndex != targetTrackIndex) {
      _timeline.moveClipToTrack(clipId, targetTrackIndex);
    }
    clip.moveTo(startFrame);
    _markChanged();
  }

  void resizeToClip(
    TimelineClipId clipId, {
    required int startFrame,
    required int durationFrames,
  }) {
    final clip = _timeline.getClipById(clipId);
    final track = _timeline.getTrackByClipId(clipId);
    if (!track.canPlaceClip(
      clip,
      startFrame: startFrame,
      durationFrames: durationFrames,
    )) {
      return;
    }

    clip.trimStartTo(startFrame);
    clip.trimEndTo(startFrame + durationFrames);
    _markChanged();
  }

  void updateTextClip(
    TimelineClipId clipId, {
    String? text,
    double? fontSize,
    Color? textColor,
  }) {
    final clip = _timeline.getClipById(clipId);
    if (clip is! TextClip) {
      return;
    }

    clip.update(text: text, size: fontSize, color: textColor);
    _markChanged();
  }
}
