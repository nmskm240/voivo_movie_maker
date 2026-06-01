import 'package:flutter/widgets.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

abstract interface class InspectorSection {
  bool isSupports(TimelineClip clip);
  Widget build(BuildContext context, TimelineEditor editor, TimelineClip? clip);
}
