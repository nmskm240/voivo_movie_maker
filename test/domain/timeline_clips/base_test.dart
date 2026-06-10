import 'package:flutter_test/flutter_test.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

void main() {
  group('TimelineClip components', () {
    test('uses the component definition to limit instances', () {
      final clip = _clip(components: [TextComponent()]);

      expect(clip.canAddComponent(TextComponent()), isFalse);
      expect(() => clip.addComponent(TextComponent()), throwsArgumentError);
    });

    test(
      'allows multiple instances when the component definition allows it',
      () {
        final first = _MultipleComponent();
        final second = _MultipleComponent();
        final clip = _clip(components: [first]);

        expect(clip.canAddComponent(second), isTrue);

        clip.addComponent(second);

        expect(clip.componentsOf<_MultipleComponent>(), [first, second]);
      },
    );

    test('removes only the component with the specified ID', () {
      final first = _MultipleComponent();
      final second = _MultipleComponent();
      final clip = _clip(components: [first, second]);

      clip.removeComponent(first.id);

      expect(clip.componentsOf<_MultipleComponent>(), [second]);
    });

    test('assigns an ID when reading legacy component JSON', () {
      final component = TextComponent.fromJson(const {});

      expect(component.id.value, isNotEmpty);
      expect(component.toJson()['id'], component.id.value);
    });
  });
}

TimelineClip _clip({Iterable<ClipComponent> components = const []}) {
  return TimelineClip(
    id: TimelineClipId.create(),
    startFrame: 0,
    components: components,
  );
}

class _MultipleComponent extends ClipComponent {
  @override
  int? get maxInstancesPerClip => null;
}
