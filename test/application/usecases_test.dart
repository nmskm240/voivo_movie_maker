// Dart imports:
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/usecases.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

void main() {
  group('importProjectAsset', () {
    test('copies, adds to catalog, and saves the project', () async {
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'image.png',
        kind: ProjectAssetKind.image,
      );
      final store = _ProjectAssetStore(asset);
      final repository = _ProjectRepository(project);
      final container = _container(project, store, repository);
      addTearDown(container.dispose);

      final imported = await container.read(
        importProjectAssetProvider(File('image.png')).future,
      );

      expect(imported, same(asset));
      expect(project.assets.findById(asset.id), same(asset));
      expect(store.saved, isTrue);
      expect(store.deleted, isFalse);
      expect(repository.saveCount, 1);
    });

    test('rolls back the copied file when catalog addition fails', () async {
      final project = Project.empty();
      final existing = ProjectAsset(
        name: 'image.png',
        kind: ProjectAssetKind.image,
      );
      project.assets.add(existing);
      final asset = ProjectAsset(
        name: 'image.png',
        kind: ProjectAssetKind.image,
      );
      final store = _ProjectAssetStore(asset);
      final repository = _ProjectRepository(project);
      final container = _container(project, store, repository);
      addTearDown(container.dispose);

      await expectLater(
        container.read(importProjectAssetProvider(File('image.png')).future),
        throwsArgumentError,
      );

      expect(project.assets.assets, [existing]);
      expect(store.deleted, isTrue);
      expect(repository.saveCount, 0);
    });

    test(
      'rolls back catalog and copied file when project save fails',
      () async {
        final project = Project.empty();
        final asset = ProjectAsset(
          name: 'image.png',
          kind: ProjectAssetKind.image,
        );
        final store = _ProjectAssetStore(asset);
        final repository = _ProjectRepository(project, failSave: true);
        final container = _container(project, store, repository);
        addTearDown(container.dispose);

        await expectLater(
          container.read(importProjectAssetProvider(File('image.png')).future),
          throwsStateError,
        );

        expect(project.assets.assets, isEmpty);
        expect(store.deleted, isTrue);
      },
    );
  });

  group('addImageClipToTimeline', () {
    test(
      'adds an image clip with image size and required components',
      () async {
        final project = Project.empty();
        final asset = ProjectAsset(
          name: 'image.png',
          kind: ProjectAssetKind.image,
        );
        project.assets.add(asset);
        final store = _ProjectAssetStore(asset, bytes: await _pngBytes(4, 3));
        final repository = _ProjectRepository(project);
        final container = _container(project, store, repository);
        addTearDown(container.dispose);

        final clip = await container.read(
          addImageClipToTimelineProvider(
            trackIndex: 0,
            asset: asset,
            startFrame: 42,
          ).future,
        );

        expect(project.timeline.tracks.first.clips.single, same(clip));
        expect(clip?.startFrame, 42);
        expect(clip?.durationFrames, 90);
        expect(clip?.component<ImageComponent>()?.assetId, asset.id);
        expect(clip?.component<ImageComponent>()?.size, const Size(4, 3));
        expect(clip?.hasComponent<TransformComponent>(), isTrue);
        expect(repository.saveCount, 1);
      },
    );

    test(
      'does not change timeline for invalid or conflicting assets',
      () async {
        final project = Project.empty();
        final asset = ProjectAsset(
          name: 'image.png',
          kind: ProjectAssetKind.image,
        );
        project.assets.add(asset);
        project.timeline.tracks.first.addClip(
          TimelineClip(id: TimelineClipId.create(), startFrame: 0),
        );
        final store = _ProjectAssetStore(asset, bytes: await _pngBytes(4, 3));
        final repository = _ProjectRepository(project);
        final container = _container(project, store, repository);
        addTearDown(container.dispose);

        final missingAsset = await container.read(
          addImageClipToTimelineProvider(
            trackIndex: 0,
            asset: ProjectAsset(
              name: 'missing.png',
              kind: ProjectAssetKind.image,
            ),
            startFrame: 20,
          ).future,
        );
        final conflicting = await container.read(
          addImageClipToTimelineProvider(
            trackIndex: 0,
            asset: asset,
            startFrame: 0,
          ).future,
        );

        expect(missingAsset, isNull);
        expect(conflicting, isNull);
        expect(project.timeline.tracks.first.clips, hasLength(1));
      },
    );
  });
}

ProviderContainer _container(
  Project project,
  IProjectAssetStore store,
  IProjectRepository repository,
) {
  return ProviderContainer(
    overrides: [
      projectIdProvider.overrideWithValue(project.id),
      projectAssetStoreProvider.overrideWithValue(store),
      projectRepositoryProvider.overrideWithValue(repository),
    ],
  );
}

Future<Uint8List> _pngBytes(int width, int height) async {
  final recorder = PictureRecorder();
  Canvas(recorder).drawRect(
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    Paint()..color = const Color(0xff2196f3),
  );
  final picture = recorder.endRecording();
  final image = await picture.toImage(width, height);
  picture.dispose();
  final data = await image.toByteData(format: ImageByteFormat.png);
  image.dispose();
  return data!.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

class _ProjectAssetStore implements IProjectAssetStore {
  _ProjectAssetStore(this.asset, {this.bytes = const []});

  final ProjectAsset asset;
  final List<int> bytes;
  bool saved = false;
  bool deleted = false;

  @override
  Future<void> delete(ProjectAsset asset) async {
    deleted = true;
  }

  @override
  Stream<List<int>> load(ProjectAsset asset) => Stream.value(bytes);

  @override
  Future<ProjectAsset> save(File file) async {
    saved = true;
    return asset;
  }
}

class _ProjectRepository implements IProjectRepository {
  _ProjectRepository(this.project, {this.failSave = false});

  final Project project;
  final bool failSave;
  int saveCount = 0;

  @override
  Future<List<Project>> findAny() async => [project];

  @override
  Future<Project> getById(ProjectId id) async => project;

  @override
  Future<void> save(Project project) async {
    saveCount++;
    if (failSave) {
      throw StateError('save failed');
    }
  }
}
