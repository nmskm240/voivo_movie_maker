// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';

part 'audio.g.dart';

@JsonSerializable(explicitToJson: true)
class AudioComponent extends ClipComponent {
  AudioComponent({
    required this.assetId,
    this.volume = 1,
    this.muted = false,
    super.id,
  }) : assert(volume >= 0);

  factory AudioComponent.fromJson(Map<String, Object?> json) =>
      _$AudioComponentFromJson(json);

  AssetId assetId;
  double volume;
  bool muted;

  @override
  String get label => 'Audio';

  void update({AssetId? assetId, double? volume, bool? muted}) {
    if (volume != null && volume < 0) {
      throw ArgumentError.value(volume, 'volume');
    }
    this.assetId = assetId ?? this.assetId;
    this.volume = volume ?? this.volume;
    this.muted = muted ?? this.muted;
  }

  Map<String, Object?> toJson() => _$AudioComponentToJson(this);
}
