import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/audio_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/image_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/text_clip.dart';

List<TimelineClip> timelineClipsFromJson(List<Object?> json) {
  return const TimelineClipListJsonConverter().fromJson(json);
}

List<Object?> timelineClipsToJson(List<TimelineClip> clips) {
  return const TimelineClipListJsonConverter().toJson(clips);
}

class TimelineClipListJsonConverter
    implements JsonConverter<List<TimelineClip>, List<Object?>> {
  const TimelineClipListJsonConverter();

  @override
  List<TimelineClip> fromJson(List<Object?> json) {
    return json.map(_clipFromJson).toList();
  }

  @override
  List<Object?> toJson(List<TimelineClip> object) {
    return object.map(_clipToJson).toList();
  }

  TimelineClip _clipFromJson(Object? json) {
    if (json is! Map<String, Object?>) {
      throw const FormatException('Timeline clip must be an object');
    }

    return switch (_readClipKind(json['kind'])) {
      TimelineClipKind.text => TextClip.fromJson(json),
      TimelineClipKind.image => ImageClip.fromJson(json),
      TimelineClipKind.audio => AudioClip.fromJson(json),
    };
  }

  Map<String, Object?> _clipToJson(TimelineClip clip) {
    return switch (clip) {
      TextClip() => clip.toJson(),
      ImageClip() => clip.toJson(),
      AudioClip() => clip.toJson(),
      _ => throw UnsupportedError('Unsupported clip type: ${clip.runtimeType}'),
    };
  }

  TimelineClipKind _readClipKind(Object? json) {
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
}

class AssetIdJsonConverter implements JsonConverter<AssetId, String> {
  const AssetIdJsonConverter();

  @override
  AssetId fromJson(String json) => AssetId.fromString(json);

  @override
  String toJson(AssetId object) => object.value;
}

class TimelineClipIdJsonConverter
    implements JsonConverter<TimelineClipId, String> {
  const TimelineClipIdJsonConverter();

  @override
  TimelineClipId fromJson(String json) => TimelineClipId.fromString(json);

  @override
  String toJson(TimelineClipId object) => object.value;
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
    return Size(_readDouble(json, 'width'), _readDouble(json, 'height'));
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
    return Vector2(_readDouble(json, 'x'), _readDouble(json, 'y'));
  }

  @override
  Map<String, Object?> toJson(Vector2 object) {
    return {'x': object.x, 'y': object.y};
  }
}

double _readDouble(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is int) {
    return value.toDouble();
  }
  if (value is! double) {
    throw FormatException('$key must be a number');
  }
  return value;
}
