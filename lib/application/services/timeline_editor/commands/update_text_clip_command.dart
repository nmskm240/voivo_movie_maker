import 'package:flutter/material.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/timeline_editor_command.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/text.dart';

class UpdateTextClipCommand implements TimelineEditorCommand {
  const UpdateTextClipCommand(
    this.clipId, {
    this.text,
    this.fontSize,
    this.textColor,
  });

  final TimelineClipId clipId;
  final String? text;
  final double? fontSize;
  final Color? textColor;

  @override
  bool canExecute(Timeline timeline) {
    return timeline.getClipById(clipId).hasComponent<TextComponent>();
  }

  @override
  void execute(Timeline timeline) {
    timeline
        .getClipById(clipId)
        .component<TextComponent>()
        ?.update(text: text, size: fontSize, color: textColor);
  }
}
