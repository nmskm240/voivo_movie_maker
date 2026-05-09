import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../models/timeline.dart';

class AssSubtitleBuilder {
  const AssSubtitleBuilder();

  String build(Project project) {
    final buffer = StringBuffer()
      ..writeln('[Script Info]')
      ..writeln('ScriptType: v4.00+')
      ..writeln('PlayResX: ${project.settings.width}')
      ..writeln('PlayResY: ${project.settings.height}')
      ..writeln('ScaledBorderAndShadow: yes')
      ..writeln()
      ..writeln('[V4+ Styles]')
      ..writeln(
        'Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, '
        'OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, '
        'ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, '
        'Alignment, MarginL, MarginR, MarginV, Encoding',
      )
      ..writeln(
        'Style: Default,Noto Sans JP,42,&H00FFFFFF,&H000000FF,&HAA000000,'
        '&H99000000,-1,0,0,0,100,100,0,0,1,3,1,5,0,0,0,1',
      )
      ..writeln()
      ..writeln('[Events]')
      ..writeln(
        'Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, '
        'Effect, Text',
      );

    for (final track in project.timeline.tracks) {
      for (final clip in track.clips) {
        if (clip.content is! TextContent) {
          continue;
        }

        buffer.writeln(_buildDialogue(project, clip));
      }
    }

    return buffer.toString();
  }

  String _buildDialogue(Project project, TimelineClip clip) {
    final content = clip.content as TextContent;
    final start = _formatAssTime(clip.startFrame / project.settings.fps);
    final end = _formatAssTime(
      (clip.startFrame + clip.durationFrames) / project.settings.fps,
    );
    final x = (project.settings.width * clip.transform.x).round();
    final y = (project.settings.height * clip.transform.y).round();
    final fontSize = (content.fontSize * clip.transform.scale).round();
    final alpha = _assAlpha(clip.transform.opacity);
    final color = _assColor(content.textColor);
    final fade = _fadeTag(clip, project.settings.fps);
    final rotation = clip.transform.rotation == 0
        ? ''
        : '\\frz${clip.transform.rotation.toStringAsFixed(1)}';
    final escapedText = _escapeAssText(content.text);

    return 'Dialogue: 0,$start,$end,Default,,0,0,0,,'
        '{\\an5'
        '\\pos($x,$y)'
        '\\fn${_escapeAssTagValue(content.fontFamily)}'
        '\\fs$fontSize'
        '\\c$color'
        '\\alpha$alpha'
        '$fade'
        '$rotation'
        '}$escapedText';
  }

  String _fadeTag(TimelineClip clip, int fps) {
    var fadeInMs = 0;
    var fadeOutMs = 0;

    for (final effect in clip.effects) {
      if (effect is! FadeEffect) {
        continue;
      }

      final durationMs = (effect.durationFrames / fps * 1000).round();
      switch (effect.direction) {
        case FadeDirection.fadeIn:
          if (effect.startOffsetFrames == 0) {
            fadeInMs = math.max(fadeInMs, durationMs);
          }
        case FadeDirection.fadeOut:
          if (effect.startOffsetFrames + effect.durationFrames >=
              clip.durationFrames) {
            fadeOutMs = math.max(fadeOutMs, durationMs);
          }
      }
    }

    if (fadeInMs == 0 && fadeOutMs == 0) {
      return '';
    }

    return '\\fad($fadeInMs,$fadeOutMs)';
  }

  String _formatAssTime(double seconds) {
    final totalCentiseconds = (seconds * 100).round();
    final centiseconds = totalCentiseconds % 100;
    final totalSeconds = totalCentiseconds ~/ 100;
    final displaySeconds = totalSeconds % 60;
    final totalMinutes = totalSeconds ~/ 60;
    final minutes = totalMinutes % 60;
    final hours = totalMinutes ~/ 60;

    return '$hours:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${displaySeconds.toString().padLeft(2, '0')}.'
        '${centiseconds.toString().padLeft(2, '0')}';
  }

  String _assColor(Color color) {
    final red = (color.r * 255).round();
    final green = (color.g * 255).round();
    final blue = (color.b * 255).round();

    return '&H00'
        '${blue.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${green.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${red.toRadixString(16).padLeft(2, '0').toUpperCase()}&';
  }

  String _assAlpha(double opacity) {
    final alpha = ((1 - opacity.clamp(0, 1)) * 255).round();
    return '&H${alpha.toRadixString(16).padLeft(2, '0').toUpperCase()}&';
  }

  String _escapeAssText(String text) {
    return text
        .replaceAll(r'\', r'\\')
        .replaceAll('{', r'\{')
        .replaceAll('}', r'\}')
        .replaceAll('\n', r'\N');
  }

  String _escapeAssTagValue(String value) {
    return value.replaceAll(r'\', '').replaceAll('{', '').replaceAll('}', '');
  }
}
