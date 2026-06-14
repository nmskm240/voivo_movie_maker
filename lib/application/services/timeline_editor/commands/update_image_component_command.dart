// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class UpdateImageComponentCommand implements TimelineEditorCommand {
  const UpdateImageComponentCommand(this.clipId, {this.assetId, this.size});

  final TimelineClipId clipId;
  final AssetId? assetId;
  final Size? size;

  @override
  bool canExecute(Timeline timeline) {
    return timeline.getClipById(clipId).hasComponent<ImageComponent>() &&
        (size == null || (size!.width > 0 && size!.height > 0));
  }

  @override
  void execute(Timeline timeline) {
    timeline
        .getClipById(clipId)
        .component<ImageComponent>()
        ?.update(assetId: assetId, size: size);
  }
}
