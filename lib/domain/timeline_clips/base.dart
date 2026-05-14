import 'package:cuid2/cuid2.dart';

class TimelineClipId {
  const TimelineClipId._(this.value);
  factory TimelineClipId.create() {
    return TimelineClipId._(cuid());
  }

  final String value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TimelineClipId && other.value == value;
  }

  @override
  String toString() => value;
}

enum TimelineClipKind { text, image, audio }

abstract class TimelineClip {
  TimelineClip({
    required this.id,
    required int startFrame,
    int durationFrames = 10,
  }) : assert(startFrame >= 0),
       assert(durationFrames > 0),
       _startFrame = startFrame,
       _durationFrames = durationFrames;

  final TimelineClipId id;
  int _startFrame;
  int _durationFrames;

  TimelineClipKind get kind;

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
