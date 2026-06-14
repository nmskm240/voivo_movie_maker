// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/resize_clip_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';

void main() {
  test('resizes a clip', () {
    final clip = _clip(startFrame: 10, durationFrames: 10);
    final timeline = Timeline(
      tracks: [
        TimelineTrack(clips: [clip]),
      ],
    );
    final command = ResizeClipCommand(
      clip.id,
      startFrame: 12,
      durationFrames: 15,
    );

    expect(command.canExecute(timeline), isTrue);

    command.execute(timeline);

    expect(clip.startFrame, 12);
    expect(clip.durationFrames, 15);
  });

  test('rejects a non-positive duration', () {
    final clip = _clip(startFrame: 10, durationFrames: 10);
    final timeline = Timeline(
      tracks: [
        TimelineTrack(clips: [clip]),
      ],
    );
    final command = ResizeClipCommand(
      clip.id,
      startFrame: 10,
      durationFrames: 0,
    );

    expect(command.canExecute(timeline), isFalse);
  });

  test('rejects a resize that overlaps another clip', () {
    final clip = _clip(startFrame: 0, durationFrames: 10);
    final blockingClip = _clip(startFrame: 20, durationFrames: 10);
    final timeline = Timeline(
      tracks: [
        TimelineTrack(clips: [clip, blockingClip]),
      ],
    );
    final command = ResizeClipCommand(
      clip.id,
      startFrame: 0,
      durationFrames: 21,
    );

    expect(command.canExecute(timeline), isFalse);
  });

  test('rejects moving the clip range while resizing', () {
    final clip = _clip(startFrame: 0, durationFrames: 10);
    final timeline = Timeline(
      tracks: [
        TimelineTrack(clips: [clip]),
      ],
    );
    final command = ResizeClipCommand(
      clip.id,
      startFrame: 20,
      durationFrames: 10,
    );

    expect(command.canExecute(timeline), isFalse);
  });
}

TimelineClip _clip({required int startFrame, required int durationFrames}) {
  return TimelineClip(
    id: TimelineClipId.create(),
    startFrame: startFrame,
    durationFrames: durationFrames,
  );
}
