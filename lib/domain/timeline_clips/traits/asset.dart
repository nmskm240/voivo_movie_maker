import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';

mixin WithAsset on TimelineClip {
  AssetId get assetId;
}
