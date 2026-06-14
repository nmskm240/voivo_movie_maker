// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

sealed class TimelineDragData {
  const TimelineDragData();
}

class TimelineClipDragData extends TimelineDragData {
  const TimelineClipDragData(this.clipId);

  final TimelineClipId clipId;
}

class TimelineAssetDragData extends TimelineDragData {
  const TimelineAssetDragData(this.asset);

  final ProjectAsset asset;
}
