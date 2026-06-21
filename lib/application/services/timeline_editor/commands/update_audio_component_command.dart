// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class UpdateAudioComponentCommand implements TimelineEditorCommand {
  const UpdateAudioComponentCommand(
    this.clipId, {
    this.assetId,
    this.volume,
    this.muted,
  });

  final TimelineClipId clipId;
  final AssetId? assetId;
  final double? volume;
  final bool? muted;

  @override
  bool canExecute(Timeline timeline) {
    return timeline.getClipById(clipId).hasComponent<AudioComponent>() &&
        (volume == null || volume! >= 0);
  }

  @override
  void execute(Timeline timeline) {
    timeline
        .getClipById(clipId)
        .component<AudioComponent>()
        ?.update(assetId: assetId, volume: volume, muted: muted);
  }
}
