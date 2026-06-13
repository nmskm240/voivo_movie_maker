import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

class UpdateShapeComponentCommand implements TimelineEditorCommand {
  const UpdateShapeComponentCommand(
    this.clipId, {
    this.shapeType,
    this.size,
    this.color,
  });

  final TimelineClipId clipId;
  final ShapeType? shapeType;
  final Size? size;
  final Color? color;

  @override
  bool canExecute(Timeline timeline) {
    return timeline.getClipById(clipId).hasComponent<ShapeComponent>();
  }

  @override
  void execute(Timeline timeline) {
    timeline
        .getClipById(clipId)
        .component<ShapeComponent>()
        ?.update(shapeType: shapeType, size: size, color: color);
  }
}
