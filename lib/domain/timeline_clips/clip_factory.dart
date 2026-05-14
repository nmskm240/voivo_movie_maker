import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/text_clip.dart';

class ClipFactory {
  static TimelineClip create(TimelineClipKind kind, int startFrame) {
    final id = TimelineClipId.create();
    return switch (kind) {
      TimelineClipKind.text => TextClip("", id: id, startFrame: startFrame),
      _ => throw Error(),
    };
  }
}
