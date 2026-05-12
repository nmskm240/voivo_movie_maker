import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

abstract class TimelineClip {
  TimelineClip({
    required this.id,
    required int startFrame,
    int durationFrames = 10,
  }) : assert(startFrame >= 0),
       assert(durationFrames > 0),
       _startFrame = startFrame,
       _durationFrames = durationFrames;

  final String id;
  int _startFrame;
  int _durationFrames;

  int get startFrame => _startFrame;
  int get durationFrames => _durationFrames;
  int get endFrame => _startFrame + _durationFrames;

  bool isActiveAt(int frame) {
    return startFrame <= frame && frame < endFrame;
  }

  bool isConflict(TimelineClip clip) {
    if (clip == this) {
      return false;
    }

    return startFrame < clip.endFrame && clip.startFrame < endFrame;
  }

  void moveTo(int newStartFrame) {
    if (newStartFrame < 0) {
      throw ArgumentError.value(newStartFrame, 'newStartFrame');
    }
    _startFrame = newStartFrame;
  }

  void trimStartTo(int newStartFrame) {
    final oldEndFrame = endFrame;
    if (newStartFrame < 0 || newStartFrame >= oldEndFrame) {
      throw ArgumentError.value(newStartFrame, 'newStartFrame');
    }
    _startFrame = newStartFrame;
    _durationFrames = oldEndFrame - newStartFrame;
  }

  void trimEndTo(int newEndFrame) {
    if (newEndFrame <= _startFrame) {
      throw ArgumentError.value(newEndFrame, 'newEndFrame');
    }
    _durationFrames = newEndFrame - _startFrame;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimelineClip && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class ClipTransform {
  ClipTransform({Vector2? position, Vector2? scale, this.rotation = 0})
    : position = position ?? Vector2.zero(),
      scale = scale ?? Vector2.all(1);

  final Vector2 position;
  final Vector2 scale;
  final double rotation;
}

abstract class TimelineClipWithTransform extends TimelineClip {
  TimelineClipWithTransform({
    required super.id,
    required super.startFrame,
    super.durationFrames,
    ClipTransform? transform,
  }) : transform = transform ?? ClipTransform();
  final ClipTransform transform;
}

class TextClip extends TimelineClipWithTransform {
  TextClip(
    this.text, {
    required super.id,
    required super.startFrame,
    super.durationFrames,
    super.transform,
    this.fontFamily = "Noto Sans CJK JP",
    this.size = 24,
    Color? color,
  }) : color = color ?? Colors.black;

  String text;
  String fontFamily;
  double size;
  Color color;

  void update({String? text, String? fontFamily, double? size, Color? color}) {
    this.text = text ?? this.text;
    this.fontFamily = fontFamily ?? this.fontFamily;
    this.size = size ?? this.size;
    this.color = color ?? this.color;
  }
}

abstract class TimelineMediaClip extends TimelineClip {
  TimelineMediaClip({
    required this.assetId,
    required super.id,
    required super.startFrame,
    super.durationFrames,
    this.sourceStartFrame = 0,
    this.sourceDurationFrames,
  }) : assert(sourceStartFrame >= 0),
       assert(sourceDurationFrames == null || sourceDurationFrames > 0);

  final String assetId;
  final int sourceStartFrame;
  final int? sourceDurationFrames;
}

abstract class TimelineVisualMediaClip extends TimelineClipWithTransform {
  TimelineVisualMediaClip({
    required this.assetId,
    required super.id,
    required super.startFrame,
    super.durationFrames,
    super.transform,
    this.sourceStartFrame = 0,
    this.sourceDurationFrames,
  }) : assert(sourceStartFrame >= 0),
       assert(sourceDurationFrames == null || sourceDurationFrames > 0);

  final String assetId;
  final int sourceStartFrame;
  final int? sourceDurationFrames;
}

class ImageClip extends TimelineVisualMediaClip {
  ImageClip({
    required super.assetId,
    required super.id,
    required super.startFrame,
    super.durationFrames,
    super.transform,
  });
}

class VideoClip extends TimelineVisualMediaClip {
  VideoClip({
    required super.assetId,
    required super.id,
    required super.startFrame,
    super.durationFrames,
    super.transform,
    super.sourceStartFrame,
    super.sourceDurationFrames,
  });
}

class AudioClip extends TimelineMediaClip {
  AudioClip({
    required super.assetId,
    required super.id,
    required super.startFrame,
    super.durationFrames,
    super.sourceStartFrame,
    super.sourceDurationFrames,
    this.volume = 1,
  }) : assert(volume >= 0);

  final double volume;
}
