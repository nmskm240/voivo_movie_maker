import 'package:voivo_movie_maker/domain/timeline_clip_contents.dart';

class TimelineClip {
  TimelineClip({
    required this.id,
    required int startFrame,
    required this.content,
    int durationFrames = 10,
  }) : assert(startFrame >= 0),
       assert(durationFrames > 0),
       _startFrame = startFrame,
       _durationFrames = durationFrames;

  final String id;
  final ClipContent content;
  int _startFrame;
  int _durationFrames;

  int get startFrame => _startFrame;
  int get durationFrames => _durationFrames;
  int get endFrame => _startFrame + _durationFrames;

  bool isActiveAt(int frame) {
    return startFrame <= frame && frame < endFrame;
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
