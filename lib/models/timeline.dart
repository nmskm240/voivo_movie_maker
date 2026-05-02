import 'package:flutter/material.dart';

class Project {
  const Project({
    required this.id,
    required this.name,
    required this.settings,
    required this.timeline,
    required this.createdAt,
    required this.updatedAt,
    this.filePath,
  });

  final String id;
  final String name;
  final String? filePath;
  final ProjectSettings settings;
  final Timeline timeline;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class ProjectSettings {
  const ProjectSettings({
    required this.width,
    required this.height,
    required this.fps,
    required this.sampleRate,
    required this.backgroundColor,
  });

  final int width;
  final int height;
  final int fps;
  final int sampleRate;
  final Color backgroundColor;
}

class Timeline {
  const Timeline({
    required this.durationFrames,
    required this.tracks,
  });

  final int durationFrames;
  final List<TimelineTrack> tracks;
}

class TimelineTrack {
  const TimelineTrack({
    required this.id,
    required this.name,
    required this.type,
    required this.clips,
    this.muted = false,
    this.locked = false,
  });

  final String id;
  final String name;
  final TrackType type;
  final bool muted;
  final bool locked;
  final List<TextClip> clips;

  IconData get icon {
    return switch (type) {
      TrackType.text => Icons.title,
    };
  }
}

enum TrackType {
  text,
}

class TextClip {
  const TextClip({
    required this.id,
    required this.name,
    required this.startFrame,
    required this.durationFrames,
    required this.transform,
    required this.text,
    required this.fontFamily,
    required this.fontSize,
    required this.textColor,
    this.effects = const [],
  });

  final String id;
  final String name;
  final int startFrame;
  final int durationFrames;
  final ClipTransform transform;
  final String text;
  final String fontFamily;
  final double fontSize;
  final Color textColor;
  final List<ClipEffect> effects;

  double startRatio(int timelineDurationFrames) {
    if (timelineDurationFrames <= 0) {
      return 0;
    }

    return startFrame / timelineDurationFrames;
  }

  double widthRatio(int timelineDurationFrames) {
    if (timelineDurationFrames <= 0) {
      return 0;
    }

    return durationFrames / timelineDurationFrames;
  }

  bool isActiveAt(int frame) {
    return startFrame <= frame && frame < startFrame + durationFrames;
  }

  double opacityAt(int frame) {
    var resolvedOpacity = transform.opacity;
    final localFrame = frame - startFrame;

    for (final effect in effects) {
      if (effect is FadeEffect) {
        resolvedOpacity *= effect.opacityAt(localFrame);
      }
    }

    return resolvedOpacity.clamp(0, 1).toDouble();
  }
}

class ClipTransform {
  const ClipTransform({
    required this.x,
    required this.y,
    required this.scale,
    required this.rotation,
    required this.opacity,
  });

  final double x;
  final double y;
  final double scale;
  final double rotation;
  final double opacity;
}

sealed class ClipEffect {
  const ClipEffect({
    required this.id,
    required this.type,
  });

  final String id;
  final EffectType type;
}

class FadeEffect extends ClipEffect {
  const FadeEffect({
    required super.id,
    required this.startOffsetFrames,
    required this.durationFrames,
    required this.direction,
  }) : super(type: EffectType.fade);

  final int startOffsetFrames;
  final int durationFrames;
  final FadeDirection direction;

  double opacityAt(int clipLocalFrame) {
    if (durationFrames <= 0) {
      return 1;
    }

    final elapsed = clipLocalFrame - startOffsetFrames;
    if (elapsed < 0) {
      return direction == FadeDirection.fadeIn ? 0 : 1;
    }

    if (elapsed >= durationFrames) {
      return direction == FadeDirection.fadeIn ? 1 : 0;
    }

    final progress = elapsed / durationFrames;
    return switch (direction) {
      FadeDirection.fadeIn => progress,
      FadeDirection.fadeOut => 1 - progress,
    };
  }
}

enum EffectType {
  fade,
}

enum FadeDirection {
  fadeIn,
  fadeOut,
}
