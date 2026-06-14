// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/timeline_editor/commands/add_clip_command.dart';
import 'package:voivo_movie_maker/application/services/timeline_editor/timeline_editor.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/infra/project_repository.dart';

void main() {
  test('saves the project after executing a command', () async {
    final project = Project.empty();
    final repository = _ProjectRepository(project);
    final editor = TimelineEditor(repository);
    final clip = TimelineClip(id: TimelineClipId.create(), startFrame: 0);

    await editor.execute(
      project,
      AddClipCommand(targetTrackIndex: 0, clip: clip),
    );

    expect(project.timeline.tracks.first.clips, [clip]);
    expect(repository.saveCount, 1);
  });

  test('serializes project saves', () async {
    final project = Project.empty();
    final repository = _ProjectRepository(project, waitForSave: true);
    final editor = TimelineEditor(repository);

    final first = editor.execute(
      project,
      AddClipCommand(
        targetTrackIndex: 0,
        clip: TimelineClip(id: TimelineClipId.create(), startFrame: 0),
      ),
    );
    final second = editor.execute(
      project,
      AddClipCommand(
        targetTrackIndex: 0,
        clip: TimelineClip(id: TimelineClipId.create(), startFrame: 20),
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(repository.activeSaves, 1);
    repository.releaseSave();
    await Future<void>.delayed(Duration.zero);
    expect(repository.activeSaves, 1);
    repository.releaseSave();
    await Future.wait([first, second]);

    expect(repository.maxActiveSaves, 1);
    expect(repository.saveCount, 2);
  });

  test('persists timeline changes to the project repository', () async {
    final projectsDirectory = await Directory.systemTemp.createTemp(
      'timeline_editor_test',
    );
    addTearDown(() => projectsDirectory.delete(recursive: true));
    final project = Project.empty();
    final repository = ProjectRepository(projectsDirectory);
    final editor = TimelineEditor(repository);
    final clip = TimelineClip(id: TimelineClipId.create(), startFrame: 12);

    await editor.execute(
      project,
      AddClipCommand(targetTrackIndex: 0, clip: clip),
    );
    final restored = await repository.getById(project.id);

    expect(restored.timeline.tracks.first.clips.single.id, clip.id);
    expect(restored.timeline.tracks.first.clips.single.startFrame, 12);
  });
}

class _ProjectRepository implements IProjectRepository {
  _ProjectRepository(this.project, {this.waitForSave = false});

  final Project project;
  final bool waitForSave;
  final _saveCompleters = <Completer<void>>[];
  int saveCount = 0;
  int activeSaves = 0;
  int maxActiveSaves = 0;

  void releaseSave() {
    _saveCompleters.removeAt(0).complete();
  }

  @override
  Future<List<Project>> findAny() async => [project];

  @override
  Future<Project> getById(ProjectId id) async => project;

  @override
  Future<void> save(Project project) async {
    saveCount++;
    activeSaves++;
    maxActiveSaves = maxActiveSaves < activeSaves
        ? activeSaves
        : maxActiveSaves;
    if (waitForSave) {
      final completer = Completer<void>();
      _saveCompleters.add(completer);
      await completer.future;
    }
    activeSaves--;
  }
}
