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
    required String trackId,
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
    final trackIndex = tracks.indexWhere((track) => track.id == trackId);
    final updatedTracks = List<TimelineTrack>.of(tracks);

    if (trackIndex == -1) {
      updatedTracks.add(TimelineTrack(id: trackId, clips: [clip]));
    } else {
      final track = tracks[trackIndex];
      updatedTracks[trackIndex] = TimelineTrack(
        id: track.id,
        clips: [...track.clips, clip],
      );
    }

    ref
        .read(loadedProjectProvider.notifier)
        .updateTimeline(Timeline(tracks: updatedTracks));
  }
}
