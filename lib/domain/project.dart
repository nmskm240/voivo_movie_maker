import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';

part 'project.g.dart';

@JsonSerializable(constructor: '_json', explicitToJson: true)
class Project {
  Project({
    this.width = 1920,
    this.height = 1080,
    this.fps = 30,
    this.sampleRate = 48,
    required this.assetStorage,
    required this.timeline,
  });

  Project._json({
    this.width = 1920,
    this.height = 1080,
    this.fps = 30,
    this.sampleRate = 48,
    required this.timeline,
  });

  factory Project.empty({required ProjectAssetStorage assetStorage}) {
    return Project(assetStorage: assetStorage, timeline: Timeline.empty());
  }

  factory Project.fromJson(
    Map<String, Object?> json, {
    required ProjectAssetStorage assetStorage,
  }) => _$ProjectFromJson(json)..assetStorage = assetStorage;

  static List<ProjectAsset> assetsFromJson(Map<String, Object?> json) {
    final assetsJson = json['assets'];
    if (assetsJson is! List) {
      throw const FormatException('Project assets must be a list');
    }
    return assetsJson.map((assetJson) {
      if (assetJson is! Map<String, Object?>) {
        throw const FormatException('Project asset must be an object');
      }
      return ProjectAsset.fromJson(assetJson);
    }).toList();
  }

  final double width;
  final double height;
  final int fps;
  final int sampleRate;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late ProjectAssetStorage assetStorage;
  final Timeline timeline;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<ProjectAsset> get assets => assetStorage.assets.toList();

  Map<String, Object?> toJson() {
    return {
      ..._$ProjectToJson(this),
      'assets': assets.map((asset) => asset.toJson()).toList(),
    };
  }
}
