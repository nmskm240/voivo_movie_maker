// Project imports:
import 'package:voivo_movie_maker/domain/timeline.dart';

abstract interface class TimelineEditorCommand {
  bool canExecute(Timeline timeline);
  void execute(Timeline timeline);
}
