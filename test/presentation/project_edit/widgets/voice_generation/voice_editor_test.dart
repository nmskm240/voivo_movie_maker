// Dart imports:
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/dtos/speaker_style.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/voice_generator.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/voice_generation/voice_editor.dart';

void main() {
  testWidgets('blocks interaction while creating a voice clip', (tester) async {
    final synthesis = Completer<Uint8List>();
    final generator = _VoiceGenerator(synthesis.future);
    final project = Project.empty();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectIdProvider.overrideWithValue(project.id),
          projectAssetStoreProvider.overrideWithValue(_ProjectAssetStore()),
          projectRepositoryProvider.overrideWithValue(
            _ProjectRepository(project),
          ),
          voiceGeneratorProvider.overrideWith((ref) async => generator),
        ],
        child: MaterialApp(
          home: Scaffold(body: VoiceEditor(onCreated: (_) => Future.value())),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    await tester.enterText(find.byType(EditableText), 'こんにちは');
    await tester.tap(find.text('Generate'));
    await tester.pump();

    expect(find.text('Creating voice'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    synthesis.completeError(StateError('synthesis failed'));
    await tester.pump();
    await tester.pump();
    expect(find.text('Creating voice'), findsNothing);
  });
}

final class _VoiceGenerator implements IVoiceGenerator {
  _VoiceGenerator(this._result);

  final Future<Uint8List> _result;

  @override
  List<SpeakerStyle> get speakerStyles => const [
    SpeakerStyle(speakerName: 'Speaker', styleName: 'Normal', id: 0),
  ];

  @override
  Future<Uint8List> synthesize({
    required String text,
    required int speakerId,
  }) => _result;

  @override
  void dispose() {}
}

final class _ProjectAssetStore extends IProjectAssetStore {
  @override
  Future<void> delete(ProjectAsset asset) async {}

  @override
  Stream<List<int>> load(ProjectAsset asset) => Stream.value(const []);

  @override
  Future<void> replace(ProjectAsset asset, File file) async {}

  @override
  Future<ProjectAsset> save(File file) async {
    return ProjectAsset(
      name: file.uri.pathSegments.last,
      kind: ProjectAssetKind.audio,
    );
  }
}

final class _ProjectRepository implements IProjectRepository {
  const _ProjectRepository(this.project);

  final Project project;

  @override
  Future<void> delete(ProjectId id) async {}

  @override
  Future<List<Project>> findAny() async => [project];

  @override
  Future<Project> getById(ProjectId id) async => project;

  @override
  Future<void> save(Project project) async {}
}
