import 'dart:ui';

import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/clip_factory.dart';

class AddClipCommand implements TimelineEditorCommand {
  const AddClipCommand({
    required this.targetTrackIndex,
    required this.startFrame,
    required this.kind,
    this.assetId,
    this.size,
  });

  final int targetTrackIndex;
  final int startFrame;
  final TimelineClipKind kind;
  final AssetId? assetId;
  final Size? size;

  @override
  bool canExecute(Timeline timeline) {
    return targetTrackIndex >= 0 && targetTrackIndex < timeline.tracks.length;
  }

  @override
  void execute(Timeline timeline) {
    final track = timeline.tracks.elementAt(targetTrackIndex);
    final clip = ClipFactory.create(
      kind,
      startFrame,
      assetId: assetId,
      size: size,
    );
    track.addClip(clip);
  }
}
