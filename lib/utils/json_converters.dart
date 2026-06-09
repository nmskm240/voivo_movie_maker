import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/asset.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/audio.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/image.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/text.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/transform.dart';

class ClipComponentJsonConverter
    implements JsonConverter<ClipComponent, Map<String, Object?>> {
  const ClipComponentJsonConverter();

  @override
  ClipComponent fromJson(Map<String, Object?> json) {
    return switch (json['type']) {
      'asset' => AssetComponent.fromJson(json),
      'audio' => AudioComponent.fromJson(json),
      'image' => ImageComponent.fromJson(json),
      'text' => TextComponent.fromJson(json),
      'transform' => TransformComponent.fromJson(json),
      final type => throw FormatException('Unknown clip component type: $type'),
    };
  }

  @override
  Map<String, Object?> toJson(ClipComponent component) {
    final (type, json) = switch (component) {
      AssetComponent() => ('asset', component.toJson()),
      AudioComponent() => ('audio', component.toJson()),
      ImageComponent() => ('image', component.toJson()),
      TextComponent() => ('text', component.toJson()),
      TransformComponent() => ('transform', component.toJson()),
      _ => throw UnsupportedError(
        'Unsupported component type: ${component.runtimeType}',
      ),
    };
    return {'type': type, ...json};
  }
}

class ColorJsonConverter implements JsonConverter<Color, int> {
  const ColorJsonConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color object) => object.toARGB32();
}

class SizeJsonConverter implements JsonConverter<Size, Map<String, Object?>> {
  const SizeJsonConverter();

  @override
  Size fromJson(Map<String, Object?> json) {
    return Size(
      double.parse(json['width'].toString()),
      double.parse(json['height'].toString()),
    );
  }

  @override
  Map<String, Object?> toJson(Size object) {
    return {'width': object.width, 'height': object.height};
  }
}

class Vector2JsonConverter
    implements JsonConverter<Vector2, Map<String, Object?>> {
  const Vector2JsonConverter();

  @override
  Vector2 fromJson(Map<String, Object?> json) {
    return Vector2(
      double.parse(json['x'].toString()),
      double.parse(json['y'].toString()),
    );
  }

  @override
  Map<String, Object?> toJson(Vector2 object) {
    return {'x': object.x, 'y': object.y};
  }
}
