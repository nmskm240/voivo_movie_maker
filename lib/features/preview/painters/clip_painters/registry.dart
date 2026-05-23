import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/features/preview/painters/clip_painters/clip_painter.dart';
import 'package:voivo_movie_maker/features/preview/painters/clip_painters/text_clip_painter.dart';

const clipPainterRegistry = <Type, ClipPainter>{TextClip: TextClipPainter()};
