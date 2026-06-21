// Dart imports:
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/domain/timeline.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

void main() {
  test('adds a track and selects it', () async {
    final project = Project.empty();
    final repository = _ProjectRepository(project);
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(repository),
        projectIdProvider.overrideWithValue(project.id),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(timelineViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(timelineViewModelProvider.future);

    final added = await container
        .read(timelineViewModelProvider.notifier)
        .addTrack();

    expect(added, isTrue);
    expect(project.timeline.tracks, hasLength(Timeline.initialTrackCount + 1));
    expect(
      container.read(timelineSelectionStateProvider).trackIndex,
      Timeline.initialTrackCount,
    );
    expect(repository.saveCount, 1);
  });

  test('adds a clip after the timeline has loaded', () async {
    final project = Project.empty();
    final repository = _ProjectRepository(project);
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(repository),
        projectIdProvider.overrideWithValue(project.id),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(timelineViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(timelineViewModelProvider.future);

    await container.read(timelineViewModelProvider.notifier).addClip(0);

    expect(project.timeline.tracks.first.clips, hasLength(1));
    expect(repository.saveCount, 1);
  });

  test('removes a clip and clears its selection', () async {
    final project = Project.empty();
    final clip = TimelineClip(id: TimelineClipId.create(), startFrame: 0);
    project.timeline.tracks.first.addClip(clip);
    final repository = _ProjectRepository(project);
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(repository),
        projectIdProvider.overrideWithValue(project.id),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(timelineViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(timelineViewModelProvider.future);
    container.read(timelineSelectionStateProvider.notifier).selectClip(clip.id);

    final removed = await container
        .read(timelineViewModelProvider.notifier)
        .removeClip(clip.id);

    expect(removed, isTrue);
    expect(project.timeline.tracks.first.clips, isEmpty);
    expect(container.read(timelineSelectionStateProvider).clipId, isNull);
    expect(repository.saveCount, 1);
  });

  test('adds an imported image asset using the image dimensions', () async {
    final project = Project.empty();
    final asset = ProjectAsset(name: 'image.png', kind: ProjectAssetKind.image);
    project.assets.add(asset);
    final store = _ProjectAssetStore(asset, await _pngBytes(4, 3));
    final repository = _ProjectRepository(project);
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(repository),
        projectIdProvider.overrideWithValue(project.id),
        projectAssetStoreProvider.overrideWithValue(store),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(timelineViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(timelineViewModelProvider.future);

    final added = await container
        .read(timelineViewModelProvider.notifier)
        .addImageClip(0, asset, startFrame: 42);

    final clip = project.timeline.tracks.first.clips.single;
    final image = clip.component<ImageComponent>();
    expect(added, isTrue);
    expect(project.assets.findById(asset.id), asset);
    expect(image?.assetId, asset.id);
    expect(image?.size, const Size(4, 3));
    expect(clip.startFrame, 42);
    expect(clip.hasComponent<TransformComponent>(), isTrue);
    expect(
      container
          .read(timelineViewModelProvider)
          .value
          ?.timeline
          .tracks
          .first
          .clips,
      hasLength(1),
    );
    expect(container.read(timelineViewModelProvider).value?.revision, 1);
    expect(container.read(timelineSelectionStateProvider).trackIndex, 0);
    expect(container.read(timelineSelectionStateProvider).clipId, clip.id);
    expect(repository.saveCount, 1);
  });

  test('adds an imported audio asset', () async {
    final project = Project.empty();
    final asset = ProjectAsset(name: 'voice.wav', kind: ProjectAssetKind.audio);
    project.assets.add(asset);
    final repository = _ProjectRepository(project);
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(repository),
        projectIdProvider.overrideWithValue(project.id),
        projectAssetStoreProvider.overrideWithValue(
          _ProjectAssetStore(asset, Uint8List.fromList([1, 2, 3])),
        ),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(timelineViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(timelineViewModelProvider.future);

    final added = await container
        .read(timelineViewModelProvider.notifier)
        .addAudioClip(0, asset, startFrame: 42);

    final clip = project.timeline.tracks.first.clips.single;
    expect(added, isTrue);
    expect(clip.component<AudioComponent>()?.assetId, asset.id);
    expect(clip.startFrame, 42);
    expect(container.read(timelineSelectionStateProvider).trackIndex, 0);
    expect(container.read(timelineSelectionStateProvider).clipId, clip.id);
    expect(repository.saveCount, 1);
  });
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
  _ProjectAssetStore(this.asset, this.bytes);

  final ProjectAsset asset;
  final Uint8List bytes;

  @override
  Future<void> delete(ProjectAsset asset) async {}

  @override
  Stream<List<int>> load(ProjectAsset asset) => Stream.value(bytes);

  @override
  Future<ProjectAsset> save(File file) async => asset;

  @override
  Future<void> replace(ProjectAsset asset, File file) async {}
}

class _ProjectRepository implements IProjectRepository {
  _ProjectRepository(this.project);

  final Project project;
  int saveCount = 0;

  @override
  Future<List<Project>> findAny() async => [project];

  @override
  Future<Project> getById(ProjectId id) async => project;

  @override
  Future<void> save(Project project) async {
    saveCount++;
  }

  @override
  Future<void> delete(ProjectId id) async {}
}
