// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/update_audio_component_command.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/domain/timeline_track.dart';

void main() {
  test('updates audio component settings', () {
    final firstAsset = AssetId.create();
    final secondAsset = AssetId.create();
    final clip = TimelineClip(
      id: TimelineClipId.create(),
      startFrame: 0,
      components: [AudioComponent(assetId: firstAsset)],
    );
    final timeline = Timeline(
      tracks: [
        TimelineTrack(clips: [clip]),
      ],
    );
    final command = UpdateAudioComponentCommand(
      clip.id,
      assetId: secondAsset,
      volume: 0.5,
      muted: true,
    );

    expect(command.canExecute(timeline), isTrue);

    command.execute(timeline);

    final audio = clip.component<AudioComponent>();
    expect(audio?.assetId, secondAsset);
    expect(audio?.volume, 0.5);
    expect(audio?.muted, isTrue);
  });

  test('rejects a negative volume', () {
    final clip = TimelineClip(
      id: TimelineClipId.create(),
      startFrame: 0,
      components: [AudioComponent(assetId: AssetId.create())],
    );
    final timeline = Timeline(
      tracks: [
        TimelineTrack(clips: [clip]),
      ],
    );

    expect(
      UpdateAudioComponentCommand(clip.id, volume: -1).canExecute(timeline),
      isFalse,
    );
  });
}
