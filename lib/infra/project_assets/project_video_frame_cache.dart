// Dart imports:
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

// Project imports:
import 'package:voivo_movie_maker/application/services/rendering/project_video_frame_decoder.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';

typedef VideoAssetBytesLoader = Future<Uint8List> Function(ProjectAsset asset);

final class ProjectVideoFrameCache {
  ProjectVideoFrameCache({
    required VideoAssetBytesLoader loadVideo,
    this.decoder = const ProjectVideoFrameDecoder(),
  }) : _loadVideo = loadVideo;

  final VideoAssetBytesLoader _loadVideo;
  final ProjectVideoFrameDecoder decoder;
  final _values = <_VideoFrameKey, Image>{};
  final _pending = <_VideoFrameKey, Future<Image>>{};
  final _revisions = StreamController<int>.broadcast(sync: true);
  var _revision = 0;
  var _disposed = false;

  Map<AssetId, Image> get valuesByAsset {
    final values = <AssetId, Image>{};
    for (final entry in _values.entries) {
      values[entry.key.assetId] = entry.value;
    }
    return Map.unmodifiable(values);
  }

  Stream<int> get revisions => _revisions.stream;

  Image? find(ProjectAsset asset, int frameNumber) {
    return _values[_VideoFrameKey(asset.id, frameNumber)];
  }

  Image? findNearest(
    ProjectAsset asset,
    int frameNumber, {
    required int maxDistance,
  }) {
    for (var distance = 0; distance <= maxDistance; distance++) {
      final previous =
          _values[_VideoFrameKey(asset.id, frameNumber - distance)];
      if (previous != null) {
        return previous;
      }
      if (distance == 0) {
        continue;
      }
      final next = _values[_VideoFrameKey(asset.id, frameNumber + distance)];
      if (next != null) {
        return next;
      }
    }
    return null;
  }

  Future<Image> load(
    ProjectAsset asset, {
    required int frameNumber,
    required Duration position,
  }) {
    if (_disposed) {
      throw StateError('Project video frame cache is disposed');
    }
    if (asset.kind != ProjectAssetKind.video) {
      throw ArgumentError.value(asset, 'asset', 'Asset is not a video asset');
    }
    final key = _VideoFrameKey(asset.id, frameNumber);
    final cached = _values[key];
    if (cached != null) {
      return Future.value(cached);
    }
    return _pending.putIfAbsent(
      key,
      () => _load(key, asset, position: position),
    );
  }

  void evict(AssetId assetId) {
    final keys = _values.keys.where((key) => key.assetId == assetId).toList();
    if (keys.isEmpty) {
      return;
    }
    for (final key in keys) {
      _values.remove(key)?.dispose();
    }
    _revisions.add(++_revision);
  }

  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    for (final image in _values.values) {
      image.dispose();
    }
    _values.clear();
    _revisions.close();
  }

  Future<Image> _load(
    _VideoFrameKey key,
    ProjectAsset asset, {
    required Duration position,
  }) async {
    try {
      final bytes = await _loadVideo(asset);
      final image = await decoder.decodeFrame(
        bytes,
        position: position,
        extension: _extension(asset.name),
      );
      if (_disposed) {
        image.dispose();
        throw StateError(
          'Project video frame cache was disposed while loading',
        );
      }
      final previous = _values[key];
      previous?.dispose();
      _values[key] = image;
      _revisions.add(++_revision);
      return image;
    } finally {
      _pending.remove(key);
    }
  }

  String _extension(String name) {
    final dot = name.lastIndexOf('.');
    return dot < 0 ? '.mp4' : name.substring(dot);
  }
}

final class _VideoFrameKey {
  const _VideoFrameKey(this.assetId, this.frameNumber);

  final AssetId assetId;
  final int frameNumber;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _VideoFrameKey &&
            other.assetId == assetId &&
            other.frameNumber == frameNumber;
  }

  @override
  int get hashCode => Object.hash(assetId, frameNumber);
}
