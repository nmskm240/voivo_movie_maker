import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/audio_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/image_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/text_clip.dart';

class TimelineClipJsonConverter
    implements JsonConverter<TimelineClip, Map<String, Object?>> {
  const TimelineClipJsonConverter();

  @override
  TimelineClip fromJson(Map<String, Object?> json) {
    return switch (const TimelineClipKindJsonConverter().fromJson(
      json['kind'],
    )) {
      TimelineClipKind.text => TextClip.fromJson(json),
      TimelineClipKind.image => ImageClip.fromJson(json),
      TimelineClipKind.audio => AudioClip.fromJson(json),
    };
  }

  @override
  Map<String, Object?> toJson(TimelineClip clip) {
    return switch (clip) {
      TextClip() => clip.toJson(),
      ImageClip() => clip.toJson(),
      AudioClip() => clip.toJson(),
      _ => throw UnsupportedError('Unsupported clip type: ${clip.runtimeType}'),
    };
  }
}

class TimelineClipKindJsonConverter
    implements JsonConverter<TimelineClipKind, Object?> {
  const TimelineClipKindJsonConverter();

  @override
  TimelineClipKind fromJson(Object? json) {
    if (json is! String) {
      throw const FormatException('Clip kind must be a string');
    }
    for (final kind in TimelineClipKind.values) {
      if (kind.name == json) {
        return kind;
      }
    }
    throw FormatException('Unknown clip kind: $json');
  }

  @override
  Object? toJson(TimelineClipKind kind) => kind.name;
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
