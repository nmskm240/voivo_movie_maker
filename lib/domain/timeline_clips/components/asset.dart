import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';

part 'asset.g.dart';

@JsonSerializable(explicitToJson: true)
class AssetComponent implements ClipComponent {
  AssetComponent({required this.assetId});

  factory AssetComponent.fromJson(Map<String, Object?> json) =>
      _$AssetComponentFromJson(json);

  AssetId assetId;

  Map<String, Object?> toJson() => _$AssetComponentToJson(this);
}
