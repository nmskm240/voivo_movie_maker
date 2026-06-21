// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';

part 'video.g.dart';

@JsonSerializable(explicitToJson: true)
class VideoComponent extends ClipComponent {
  VideoComponent({required this.assetId, super.id});

  factory VideoComponent.fromJson(Map<String, Object?> json) =>
      _$VideoComponentFromJson(json);

  AssetId assetId;

  @override
  String get label => 'Video';

  void update({AssetId? assetId}) {
    this.assetId = assetId ?? this.assetId;
  }

  Map<String, Object?> toJson() => _$VideoComponentToJson(this);
}
