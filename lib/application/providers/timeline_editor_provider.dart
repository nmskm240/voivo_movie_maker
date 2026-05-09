import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voivo_movie_maker/application/dtos/timeline_info.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clip_contents.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';

part 'timeline_editor_provider.g.dart';

const defaultTimelineClipDurationFrames = 120;

@riverpod
class TimelineEditor extends _$TimelineEditor {
  @override
  TimelineInfo build() {
    final timeline = ref.watch(loadedProjectProvider).timeline;
    return TimelineInfo.fromEntity(timeline);
  }

  void addTextClip({
    required int trackIndex,
    required int startFrame,
    int durationFrames = defaultTimelineClipDurationFrames,
    String text = 'New Clip',
  }) {
    if (startFrame < 0) {
      throw ArgumentError.value(startFrame, 'startFrame');
    }
    if (durationFrames <= 0) {
      throw ArgumentError.value(durationFrames, 'durationFrames');
    }

    final project = ref.read(loadedProjectProvider);
    final timeline = project.timeline;
    final clip = TimelineClip(
      id: 'clip-${DateTime.now().microsecondsSinceEpoch}',
      startFrame: startFrame,
      durationFrames: durationFrames,
      content: TextContent(
        text: text,
        fontFamily: 'Noto Sans CJK JP',
        fontSize: 48,
        textColor: const Color(0xffffffff),
      ),
    );

    final tracks = timeline.tracks.toList();
    if (trackIndex < 0 || trackIndex >= tracks.length) {
      return;
    }

    final updatedTracks = List<TimelineTrack>.of(tracks);
    final track = tracks[trackIndex];
    updatedTracks[trackIndex] = TimelineTrack(clips: [...track.clips, clip]);

    ref
        .read(loadedProjectProvider.notifier)
        .updateTimeline(Timeline(tracks: updatedTracks));
  }

  void moveClip({
    required int trackIndex,
    required String clipId,
    required int startFrame,
  }) {
    final project = ref.read(loadedProjectProvider);
    final timeline = project.timeline;
    final resolvedStartFrame = startFrame < 0 ? 0 : startFrame;
    final tracks = timeline.tracks.toList();
    if (trackIndex < 0 || trackIndex >= tracks.length) {
      return;
    }

    final track = tracks[trackIndex];
    final clips = track.clips.toList();
    final clipIndex = clips.indexWhere((clip) => clip.id == clipId);
    if (clipIndex == -1) {
      return;
    }

    final clip = clips[clipIndex];
    clips[clipIndex] = TimelineClip(
      id: clip.id,
      startFrame: resolvedStartFrame,
      durationFrames: clip.durationFrames,
      content: clip.content,
    );

    final updatedTracks = List<TimelineTrack>.of(tracks);
    updatedTracks[trackIndex] = TimelineTrack(clips: clips);

    ref
        .read(loadedProjectProvider.notifier)
        .updateTimeline(Timeline(tracks: updatedTracks));
  }

  void resizeClip({
    required int trackIndex,
    required String clipId,
    required int startFrame,
    required int durationFrames,
  }) {
    final resolvedStartFrame = startFrame < 0 ? 0 : startFrame;
    final resolvedDurationFrames = durationFrames < 1 ? 1 : durationFrames;
    final project = ref.read(loadedProjectProvider);
    final timeline = project.timeline;
    final tracks = timeline.tracks.toList();
    if (trackIndex < 0 || trackIndex >= tracks.length) {
      return;
    }

    final track = tracks[trackIndex];
    final clips = track.clips.toList();
    final clipIndex = clips.indexWhere((clip) => clip.id == clipId);
    if (clipIndex == -1) {
      return;
    }

    final clip = clips[clipIndex];
    clips[clipIndex] = TimelineClip(
      id: clip.id,
      startFrame: resolvedStartFrame,
      durationFrames: resolvedDurationFrames,
      content: clip.content,
    );

    final updatedTracks = List<TimelineTrack>.of(tracks);
    updatedTracks[trackIndex] = TimelineTrack(clips: clips);

    ref
        .read(loadedProjectProvider.notifier)
        .updateTimeline(Timeline(tracks: updatedTracks));
  }
}
