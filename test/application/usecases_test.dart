// Dart imports:
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// Package imports:
import 'package:file_picker/file_picker.dart';
import 'package:file_picker/src/platform/file_picker_platform_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/speaker_style.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/voice_generator.dart';
import 'package:voivo_movie_maker/application/usecases.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

void main() {
  group('renameProjectAsset', () {
    test('renames an asset and saves the project', () async {
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'image.png',
        kind: ProjectAssetKind.image,
      );
      project.assets.add(asset);
      final repository = _ProjectRepository(project);
      final container = _container(
        project,
        _ProjectAssetStore(asset),
        repository,
      );
      addTearDown(container.dispose);

      await container.read(
        renameProjectAssetProvider(
          assetId: asset.id,
          name: 'renamed.png',
        ).future,
      );

      expect(project.assets.findById(asset.id)?.name, 'renamed.png');
      expect(repository.saveCount, 1);
    });

    test('does nothing when the asset is missing', () async {
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'image.png',
        kind: ProjectAssetKind.image,
      );
      final repository = _ProjectRepository(project);
      final container = _container(
        project,
        _ProjectAssetStore(asset),
        repository,
      );
      addTearDown(container.dispose);

      await container.read(
        renameProjectAssetProvider(
          assetId: asset.id,
          name: 'renamed.png',
        ).future,
      );

      expect(repository.saveCount, 0);
    });

    test('rejects duplicate asset names', () async {
      final project = Project.empty();
      final first = ProjectAsset(
        name: 'first.png',
        kind: ProjectAssetKind.image,
      );
      final second = ProjectAsset(
        name: 'second.png',
        kind: ProjectAssetKind.image,
      );
      project.assets.add(first);
      project.assets.add(second);
      final repository = _ProjectRepository(project);
      final container = _container(
        project,
        _ProjectAssetStore(first),
        repository,
      );
      addTearDown(container.dispose);

      await expectLater(
        container.read(
          renameProjectAssetProvider(
            assetId: first.id,
            name: second.name,
          ).future,
        ),
        throwsArgumentError,
      );

      expect(project.assets.findById(first.id)?.name, 'first.png');
      expect(repository.saveCount, 0);
    });

    test('rolls back the catalog when saving fails', () async {
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'image.png',
        kind: ProjectAssetKind.image,
      );
      project.assets.add(asset);
      final repository = _ProjectRepository(project, failSave: true);
      final container = _container(
        project,
        _ProjectAssetStore(asset),
        repository,
      );
      addTearDown(container.dispose);

      await expectLater(
        container.read(
          renameProjectAssetProvider(
            assetId: asset.id,
            name: 'renamed.png',
          ).future,
        ),
        throwsStateError,
      );

      expect(project.assets.findById(asset.id)?.name, 'image.png');
      expect(repository.saveCount, 1);
    });
  });

  group('importProjectAsset', () {
    late FilePickerPlatform originalFilePicker;

    setUp(() {
      originalFilePicker = FilePickerPlatform.instance;
    });

    tearDown(() {
      FilePickerPlatform.instance = originalFilePicker;
    });

    test(
      'picks a file, adds it to the catalog, and saves the project',
      () async {
        final temporaryDirectory = await Directory.systemTemp.createTemp(
          'import_project_asset_test',
        );
        addTearDown(() => temporaryDirectory.delete(recursive: true));
        final file = File('${temporaryDirectory.path}/voice.wav');
        await file.writeAsBytes([1, 2, 3]);
        FilePickerPlatform.instance = _FilePickerPlatform(file.path);
        final project = Project.empty();
        final asset = ProjectAsset(
          name: 'voice.wav',
          kind: ProjectAssetKind.audio,
        );
        final store = _ProjectAssetStore(asset);
        final repository = _ProjectRepository(project);
        final container = _container(project, store, repository);
        addTearDown(container.dispose);

        final imported = await container.read(
          importProjectAssetProvider.future,
        );

        expect(imported, same(asset));
        expect(project.assets.findById(asset.id), same(asset));
        expect(store.saved, isTrue);
        expect(store.savedFileName, 'voice.wav');
        expect(repository.saveCount, 1);
      },
    );

    test('returns null when file picking is canceled', () async {
      FilePickerPlatform.instance = _FilePickerPlatform(null);
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'voice.wav',
        kind: ProjectAssetKind.audio,
      );
      final store = _ProjectAssetStore(asset);
      final repository = _ProjectRepository(project);
      final container = _container(project, store, repository);
      addTearDown(container.dispose);

      final imported = await container.read(importProjectAssetProvider.future);

      expect(imported, isNull);
      expect(project.assets.assets, isEmpty);
      expect(repository.saveCount, 0);
    });

    test('rolls back the catalog and copied file when saving fails', () async {
      final temporaryDirectory = await Directory.systemTemp.createTemp(
        'import_project_asset_test',
      );
      addTearDown(() => temporaryDirectory.delete(recursive: true));
      final file = File('${temporaryDirectory.path}/voice.wav');
      await file.writeAsBytes([1, 2, 3]);
      FilePickerPlatform.instance = _FilePickerPlatform(file.path);
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'voice.wav',
        kind: ProjectAssetKind.audio,
      );
      final store = _ProjectAssetStore(asset);
      final repository = _ProjectRepository(project, failSave: true);
      final container = _container(project, store, repository);
      addTearDown(container.dispose);

      await expectLater(
        container.read(importProjectAssetProvider.future),
        throwsStateError,
      );

      expect(project.assets.assets, isEmpty);
      expect(store.deleted, isTrue);
    });

    test(
      'overwrites the existing asset when importing the same name',
      () async {
        final temporaryDirectory = await Directory.systemTemp.createTemp(
          'import_project_asset_test',
        );
        addTearDown(() => temporaryDirectory.delete(recursive: true));
        final file = File('${temporaryDirectory.path}/voice.wav');
        await file.writeAsBytes([1, 2, 3]);
        FilePickerPlatform.instance = _FilePickerPlatform(file.path);
        final project = Project.empty();
        final existing = ProjectAsset(
          name: 'voice.wav',
          kind: ProjectAssetKind.audio,
        );
        project.assets.add(existing);
        final store = _ProjectAssetStore(existing, bytes: [9, 9, 9]);
        final repository = _ProjectRepository(project);
        final container = _container(project, store, repository);
        addTearDown(container.dispose);

        final imported = await container.read(
          importProjectAssetProvider.future,
        );

        expect(imported, existing);
        expect(project.assets.assets, [existing]);
        expect(store.saved, isFalse);
        expect(store.replaced, isTrue);
        expect(store.bytes, [1, 2, 3]);
        expect(repository.saveCount, 1);
      },
    );
  });

  group('createVoiceAsset', () {
    test(
      'synthesizes dialogue and imports it using the voice file name',
      () async {
        final temporaryDirectory = await Directory.systemTemp.createTemp(
          'create_voice_asset_test',
        );
        addTearDown(() => temporaryDirectory.delete(recursive: true));
        final project = Project.empty();
        final asset = ProjectAsset(
          name: 'ずんだもん_こんにちは.wav',
          kind: ProjectAssetKind.audio,
        );
        final store = _ProjectAssetStore(asset);
        final repository = _ProjectRepository(project);
        final generator = _VoiceGenerator(bytes: Uint8List.fromList([1, 2, 3]));
        final container = _container(
          project,
          store,
          repository,
          voiceGenerator: generator,
        );
        addTearDown(container.dispose);

        final imported = await container.read(
          createVoiceAssetProvider(
            dialogue: 'こんにちは',
            speakerId: 1,
            temporaryDirectory: temporaryDirectory,
          ).future,
        );

        expect(imported, same(asset));
        expect(generator.synthesizedText, 'こんにちは');
        expect(generator.synthesizedSpeakerId, 1);
        expect(store.savedFileName, 'ずんだもん_こんにちは.wav');
        expect(project.assets.findById(asset.id), same(asset));
        expect(repository.saveCount, 1);
        expect(temporaryDirectory.listSync(), isEmpty);
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

  group('addAudioClipToTimeline', () {
    test('adds an audio clip referencing the audio asset', () async {
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'voice.wav',
        kind: ProjectAssetKind.audio,
      );
      project.assets.add(asset);
      final repository = _ProjectRepository(project);
      final container = _container(
        project,
        _ProjectAssetStore(asset),
        repository,
      );
      addTearDown(container.dispose);

      final clip = await container.read(
        addAudioClipToTimelineProvider(
          trackIndex: 0,
          asset: asset,
          startFrame: 42,
        ).future,
      );

      expect(project.timeline.tracks.first.clips.single, same(clip));
      expect(clip?.startFrame, 42);
      expect(clip?.durationFrames, 90);
      expect(clip?.component<AudioComponent>()?.assetId, asset.id);
      expect(clip?.components, hasLength(1));
      expect(repository.saveCount, 1);
    });

    test('rejects a non-audio asset', () async {
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'image.png',
        kind: ProjectAssetKind.image,
      );
      project.assets.add(asset);
      final repository = _ProjectRepository(project);
      final container = _container(
        project,
        _ProjectAssetStore(asset),
        repository,
      );
      addTearDown(container.dispose);

      final clip = await container.read(
        addAudioClipToTimelineProvider(
          trackIndex: 0,
          asset: asset,
          startFrame: 0,
        ).future,
      );

      expect(clip, isNull);
      expect(project.timeline.tracks.first.clips, isEmpty);
      expect(repository.saveCount, 0);
    });
  });

  group('addVideoClipToTimeline', () {
    test('adds a video clip referencing the video asset', () async {
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'movie.mp4',
        kind: ProjectAssetKind.video,
      );
      project.assets.add(asset);
      final repository = _ProjectRepository(project);
      final container = _container(
        project,
        _ProjectAssetStore(asset),
        repository,
      );
      addTearDown(container.dispose);

      final clip = await container.read(
        addVideoClipToTimelineProvider(
          trackIndex: 0,
          asset: asset,
          startFrame: 42,
        ).future,
      );

      expect(project.timeline.tracks.first.clips.single, same(clip));
      expect(clip?.startFrame, 42);
      expect(clip?.durationFrames, 90);
      expect(clip?.component<VideoComponent>()?.assetId, asset.id);
      expect(clip?.hasComponent<TransformComponent>(), isTrue);
      expect(repository.saveCount, 1);
    });

    test('rejects a non-video asset', () async {
      final project = Project.empty();
      final asset = ProjectAsset(
        name: 'voice.wav',
        kind: ProjectAssetKind.audio,
      );
      project.assets.add(asset);
      final repository = _ProjectRepository(project);
      final container = _container(
        project,
        _ProjectAssetStore(asset),
        repository,
      );
      addTearDown(container.dispose);

      final clip = await container.read(
        addVideoClipToTimelineProvider(
          trackIndex: 0,
          asset: asset,
          startFrame: 0,
        ).future,
      );

      expect(clip, isNull);
      expect(project.timeline.tracks.first.clips, isEmpty);
      expect(repository.saveCount, 0);
    });
  });
}

ProviderContainer _container(
  Project project,
  IProjectAssetStore store,
  IProjectRepository repository, {
  IVoiceGenerator? voiceGenerator,
}) {
  return ProviderContainer(
    overrides: [
      projectIdProvider.overrideWithValue(project.id),
      projectAssetStoreProvider.overrideWithValue(store),
      projectRepositoryProvider.overrideWithValue(repository),
      if (voiceGenerator != null)
        voiceGeneratorProvider.overrideWith((ref) async => voiceGenerator),
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

class _ProjectAssetStore extends IProjectAssetStore {
  _ProjectAssetStore(this.asset, {this.bytes = const []});

  final ProjectAsset asset;
  List<int> bytes;
  bool saved = false;
  bool deleted = false;
  bool replaced = false;
  String? savedFileName;

  @override
  Future<void> delete(ProjectAsset asset) async {
    deleted = true;
  }

  @override
  Stream<List<int>> load(ProjectAsset asset) => Stream.value(bytes);

  @override
  Future<void> replace(ProjectAsset asset, File file) async {
    replaced = true;
    bytes = await file.readAsBytes();
  }

  @override
  Future<ProjectAsset> save(File file) async {
    saved = true;
    savedFileName = file.uri.pathSegments.last;
    return asset;
  }
}

class _FilePickerPlatform extends FilePickerPlatform {
  _FilePickerPlatform(this.path);

  final String? path;

  @override
  Future<FilePickerResult?> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    int compressionQuality = 0,
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
    bool readSequential = false,
    bool cancelUploadOnWindowBlur = true,
  }) async {
    if (path == null) {
      return null;
    }
    final file = File(path!);
    return FilePickerResult([
      PlatformFile(
        name: file.uri.pathSegments.last,
        path: path,
        size: await file.length(),
      ),
    ]);
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

  @override
  Future<void> delete(ProjectId id) async {}
}

class _VoiceGenerator implements IVoiceGenerator {
  _VoiceGenerator({required this.bytes});

  final Uint8List bytes;
  String? synthesizedText;
  int? synthesizedSpeakerId;

  @override
  List<SpeakerStyle> get speakerStyles => const [
    SpeakerStyle(speakerName: 'ずんだもん', styleName: 'ノーマル', id: 1),
  ];

  @override
  Future<Uint8List> synthesize({
    required String text,
    required int speakerId,
  }) async {
    synthesizedText = text;
    synthesizedSpeakerId = speakerId;
    return bytes;
  }

  @override
  void dispose() {}
}
