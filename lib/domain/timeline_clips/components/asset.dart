// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';

part 'asset.g.dart';

@JsonSerializable(explicitToJson: true)
class AssetComponent extends ClipComponent {
  AssetComponent({required this.assetId, super.id});

  factory AssetComponent.fromJson(Map<String, Object?> json) =>
      _$AssetComponentFromJson(json);

  AssetId assetId;

  @override
  int get maxInstancesPerClip => 1;

  Map<String, Object?> toJson() => _$AssetComponentToJson(this);
}
