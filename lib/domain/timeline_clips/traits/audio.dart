import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

class ClipAudio {
  const ClipAudio({this.volume = 1, this.muted = false}) : assert(volume >= 0);

  final double volume;
  final bool muted;
}

mixin AudibleClip on TimelineClip {
  ClipAudio get audio;
}
