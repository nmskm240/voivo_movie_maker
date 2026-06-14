// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/domain/project.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/presentation/project_edit/states/timeline_select_state.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/inspector/clip_inspector.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/timeline/view_model.dart';

void main() {
  testWidgets('reopens a collapsed inspector section', (tester) async {
    final project = Project.empty();
    final clip = TimelineClip(id: TimelineClipId.create(), startFrame: 0);
    project.timeline.tracks.first.addClip(clip);
    final container = ProviderContainer(
      overrides: [
        projectRepositoryProvider.overrideWithValue(
          _ProjectRepository(project),
        ),
        projectIdProvider.overrideWithValue(project.id),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(timelineViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(timelineViewModelProvider.future);
    container.read(timelineSelectionStateProvider.notifier).selectClip(clip.id);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: Scaffold(body: ClipInspectorPane())),
      ),
    );
    await tester.pumpAndSettle();

    final section = find.byType(ExpansionTile);
    expect(section, findsOneWidget);

    await tester.tap(section);
    await tester.pumpAndSettle();
    await tester.tap(section);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Position'), findsOneWidget);
  });

  testWidgets('removes a component after long-press confirmation', (
    tester,
  ) async {
    final text = TextComponent();
    final fixture = await _pumpInspector(
      tester,
      components: [TransformComponent(), text],
    );

    await tester.longPress(_sectionTitle('Text'));
    await tester.pumpAndSettle();

    expect(find.text('Remove Text?'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Remove'));
    await tester.pumpAndSettle();

    expect(fixture.clip.containsComponent(text.id), isFalse);
    expect(_sectionTitle('Text'), findsNothing);
  });

  testWidgets('removes the shape component after long-press confirmation', (
    tester,
  ) async {
    final shape = ShapeComponent();
    final fixture = await _pumpInspector(
      tester,
      components: [TransformComponent(), shape],
    );

    await tester.longPress(_sectionTitle('Shape'));
    await tester.pumpAndSettle();

    expect(find.text('Remove Shape?'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Remove'));
    await tester.pumpAndSettle();

    expect(fixture.clip.containsComponent(shape.id), isFalse);
    expect(find.text('Remove Shape?'), findsNothing);
  });

  testWidgets('does not allow removing the transform component', (
    tester,
  ) async {
    final transform = TransformComponent();
    final fixture = await _pumpInspector(tester, components: [transform]);

    await tester.longPress(_sectionTitle('Transform'));
    await tester.pumpAndSettle();

    expect(find.text('Remove Transform?'), findsNothing);
    expect(fixture.clip.containsComponent(transform.id), isTrue);
  });

  testWidgets('removes shape after adding shape and text then removing text', (
    tester,
  ) async {
    final fixture = await _pumpInspector(
      tester,
      components: [TransformComponent()],
    );

    await _addComponent(tester, 'Shape');
    await _addComponent(tester, 'Text');

    await tester.longPress(_sectionHeader('Text'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Remove'));
    await tester.pumpAndSettle();

    expect(fixture.clip.hasComponent<TextComponent>(), isFalse);
    expect(fixture.clip.hasComponent<ShapeComponent>(), isTrue);

    await tester.longPress(_sectionHeader('Shape'));
    await tester.pumpAndSettle();

    expect(find.text('Remove Shape?'), findsOneWidget);
  });
}

Finder _sectionTitle(String label) {
  return find.byWidgetPredicate(
    (widget) => widget is Text && widget.data == label,
  );
}

Finder _sectionHeader(String label) {
  return find
      .ancestor(
        of: _sectionTitle(label),
        matching: find.byType(GestureDetector),
      )
      .first;
}

Future<void> _addComponent(WidgetTester tester, String label) async {
  await tester.tap(find.text('Add component'));
  await tester.pumpAndSettle();
  await tester.tap(
    find.descendant(of: find.byType(BottomSheet), matching: find.text(label)),
  );
  await tester.pumpAndSettle();
}

Future<({TimelineClip clip, ProviderContainer container})> _pumpInspector(
  WidgetTester tester, {
  required Iterable<ClipComponent> components,
}) async {
  final project = Project.empty();
  final clip = TimelineClip(
    id: TimelineClipId.create(),
    startFrame: 0,
    components: components,
  );
  project.timeline.tracks.first.addClip(clip);
  final container = ProviderContainer(
    overrides: [
      projectRepositoryProvider.overrideWithValue(_ProjectRepository(project)),
      projectIdProvider.overrideWithValue(project.id),
    ],
  );
  addTearDown(container.dispose);

  final subscription = container.listen(timelineViewModelProvider, (_, _) {});
  addTearDown(subscription.close);
  await container.read(timelineViewModelProvider.future);
  container.read(timelineSelectionStateProvider.notifier).selectClip(clip.id);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: Scaffold(body: ClipInspectorPane())),
    ),
  );
  await tester.pumpAndSettle();

  return (clip: clip, container: container);
}

class _ProjectRepository implements IProjectRepository {
  const _ProjectRepository(this.project);

  final Project project;

  @override
  Future<List<Project>> findAny() async => [project];

  @override
  Future<Project> getById(ProjectId id) async => project;

  @override
  Future<void> save(Project project) async {}
}
