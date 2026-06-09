import 'package:flutter_test/flutter_test.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/move_clip_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';

void main() {
  group('MoveClipCommand', () {
    test('moves and reorders a clip on the same track', () {
      final movingClip = _clip(startFrame: 0);
      final laterClip = _clip(startFrame: 20);
      final track = TimelineTrack(clips: [movingClip, laterClip]);
      final timeline = Timeline(tracks: [track]);
      final command = MoveClipCommand(
        movingClip.id,
        targetTrackIndex: 0,
        startFrame: 40,
      );

      expect(command.canExecute(timeline), isTrue);

      command.execute(timeline);

      expect(movingClip.startFrame, 40);
      expect(track.clips, [laterClip, movingClip]);
    });

    test('moves a clip to another track using its new start frame', () {
      final movingClip = _clip(startFrame: 0);
      final blockingClip = _clip(startFrame: 0);
      final sourceTrack = TimelineTrack(clips: [movingClip]);
      final targetTrack = TimelineTrack(clips: [blockingClip]);
      final timeline = Timeline(tracks: [sourceTrack, targetTrack]);
      final command = MoveClipCommand(
        movingClip.id,
        targetTrackIndex: 1,
        startFrame: 20,
      );

      expect(command.canExecute(timeline), isTrue);

      command.execute(timeline);

      expect(sourceTrack.containsById(movingClip.id), isFalse);
      expect(targetTrack.containsById(movingClip.id), isTrue);
      expect(movingClip.startFrame, 20);
    });

    test('rejects a move that overlaps another clip', () {
      final movingClip = _clip(startFrame: 0);
      final blockingClip = _clip(startFrame: 20);
      final timeline = Timeline(
        tracks: [
          TimelineTrack(clips: [movingClip]),
          TimelineTrack(clips: [blockingClip]),
        ],
      );
      final command = MoveClipCommand(
        movingClip.id,
        targetTrackIndex: 1,
        startFrame: 20,
      );

      expect(command.canExecute(timeline), isFalse);
    });
  });
}

TimelineClip _clip({required int startFrame}) {
  return TimelineClip(
    id: TimelineClipId.create(),
    startFrame: startFrame,
    durationFrames: 10,
  );
}
