import 'package:voivo_movie_maker/domain/timeline.dart';

class Project {
  Project({
    this.width = 1920,
    this.height = 1080,
    this.fps = 30,
    this.sampleRate = 48,
    Timeline? timeline,
  }) : timeline = timeline ?? Timeline();

  final int width;
  final int height;
  final int fps;
  final int sampleRate;
  final Timeline timeline;
}
