import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clip_contents.dart';

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
    final clip = TimelineClip(
      id: 'clip-${DateTime.now().microsecondsSinceEpoch}',
      startFrame: startFrame,
      content: TextContent(
        text: "text",
        fontFamily: 'Noto Sans CJK JP',
        fontSize: 48,
        textColor: const Color(0xffffffff),
      ),
    );
    track.addClip(clip);
    _markChanged();
  }

  void moveClipToTrack(
    String clipId, {
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
    String clipId, {
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
}
