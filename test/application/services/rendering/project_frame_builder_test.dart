// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/rendering/project_frame_builder.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';

void main() {
  test('builds a project frame with active clips in track order', () {
    final first = _clip(startFrame: 0);
    final inactive = _clip(startFrame: 20);
    final second = _clip(startFrame: 5);
    final project = Project(
      width: 1280,
      height: 720,
      assets: ProjectAssetCatalog(),
      timeline: Timeline(
        tracks: [
          TimelineTrack(clips: [first, inactive]),
          TimelineTrack(clips: [second]),
        ],
      ),
    );

    final frame = const ProjectFrameBuilder().build(project, 5);

    expect(frame.projectSize.width, 1280);
    expect(frame.projectSize.height, 720);
    expect(frame.frameNumber, 5);
    expect(frame.clips, [first, second]);
  });
}

TimelineClip _clip({required int startFrame}) {
  return TimelineClip(
    id: TimelineClipId.create(),
    startFrame: startFrame,
    durationFrames: 10,
  );
}
