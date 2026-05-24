import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/base.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/image_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/text_clip.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/traits/transform.dart';

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

    final kind = _readClipKind(json['kind']);
    return switch (kind) {
      TimelineClipKind.text => TextClip(
        _readString(json, 'text'),
        id: TimelineClipId.fromString(_readString(json, 'id')),
        startFrame: _readInt(json, 'startFrame'),
        durationFrames: _readInt(json, 'durationFrames'),
        transform: _readTransform(json['transform']),
        fontFamily: _readString(json, 'fontFamily'),
        size: _readDouble(json, 'size'),
        color: Color(_readInt(json, 'color')),
      ),
      TimelineClipKind.image => ImageClip(
        id: TimelineClipId.fromString(_readString(json, 'id')),
        startFrame: _readInt(json, 'startFrame'),
        durationFrames: _readInt(json, 'durationFrames'),
        assetId: AssetId.fromString(_readString(json, 'assetId')),
        transform: _readTransform(json['transform']),
        size: Size(_readDouble(json, 'width'), _readDouble(json, 'height')),
      ),
      TimelineClipKind.audio => throw const FormatException(
        'Audio clips are not supported yet',
      ),
    };
  }

  Map<String, Object?> _clipToJson(TimelineClip clip) {
    final json = <String, Object?>{
      'id': clip.id.value,
      'kind': clip.kind.name,
      'startFrame': clip.startFrame,
      'durationFrames': clip.durationFrames,
    };

    if (clip is WithTransform) {
      json['transform'] = _transformToJson(clip.transform);
    }

    switch (clip) {
      case TextClip():
        json.addAll({
          'text': clip.text,
          'fontFamily': clip.fontFamily,
          'size': clip.size,
          'color': clip.color.toARGB32(),
        });
      case ImageClip():
        json.addAll({
          'assetId': clip.assetId.value,
          'width': clip.size.width,
          'height': clip.size.height,
        });
      default:
        throw UnsupportedError('Unsupported clip type: ${clip.runtimeType}');
    }

    return json;
  }

  Map<String, Object?> _transformToJson(ClipTransform transform) {
    return {
      'position': {'x': transform.position.x, 'y': transform.position.y},
      'scale': {'x': transform.scale.x, 'y': transform.scale.y},
      'rotation': transform.rotation,
    };
  }

  ClipTransform _readTransform(Object? json) {
    if (json == null) {
      return ClipTransform();
    }
    if (json is! Map<String, Object?>) {
      throw const FormatException('Clip transform must be an object');
    }

    return ClipTransform(
      position: _readVector2(json['position']),
      scale: _readVector2(json['scale']),
      rotation: _readDouble(json, 'rotation'),
    );
  }

  Vector2 _readVector2(Object? json) {
    if (json is! Map<String, Object?>) {
      throw const FormatException('Vector2 must be an object');
    }
    return Vector2(_readDouble(json, 'x'), _readDouble(json, 'y'));
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

  String _readString(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! String) {
      throw FormatException('$key must be a string');
    }
    return value;
  }

  int _readInt(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! int) {
      throw FormatException('$key must be an integer');
    }
    return value;
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
}
