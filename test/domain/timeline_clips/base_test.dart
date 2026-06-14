// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/domain/timeline_clips.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';

void main() {
  group('TimelineClip components', () {
    test('rejects another component of the same type', () {
      final clip = _clip(components: [TextComponent()]);

      expect(clip.canAddComponent(TextComponent()), isFalse);
      expect(() => clip.addComponent(TextComponent()), throwsArgumentError);
    });

    test('rejects duplicate component types when creating a clip', () {
      expect(
        () => _clip(components: [TextComponent(), TextComponent()]),
        throwsArgumentError,
      );
    });

    test('removes only the component with the specified ID', () {
      final first = TextComponent();
      final second = ShapeComponent();
      final clip = _clip(components: [first, second]);

      clip.removeComponent(first.id);

      expect(clip.components, [second]);
    });

    test('does not remove a non-removable component', () {
      final transform = TransformComponent();
      final clip = _clip(components: [transform]);

      expect(clip.canRemoveComponent(transform.id), isFalse);
      expect(() => clip.removeComponent(transform.id), throwsArgumentError);
      expect(clip.components, [transform]);
    });

    test('assigns an ID when reading legacy component JSON', () {
      final component = TextComponent.fromJson(const {});

      expect(component.id.value, isNotEmpty);
      expect(component.toJson()['id'], component.id.value);
    });

    test('serializes and restores shape components', () {
      final converter = const ClipComponentJsonConverter();
      final shape = ShapeComponent(shapeType: ShapeType.ellipse);

      final json = converter.toJson(shape);
      final restored = converter.fromJson(json);

      expect(json['type'], 'shape');
      expect(restored, isA<ShapeComponent>());
      expect((restored as ShapeComponent).shapeType, ShapeType.ellipse);
      expect(restored.size, shape.size);
      expect(restored.color.toARGB32(), shape.color.toARGB32());
    });

    test('serializes and restores image components', () {
      final converter = const ClipComponentJsonConverter();
      final image = ImageComponent(
        assetId: AssetId.create(),
        size: const Size(320, 180),
      );

      final json = converter.toJson(image);
      final restored = converter.fromJson(json);

      expect(json['type'], 'image');
      expect(restored, isA<ImageComponent>());
      expect((restored as ImageComponent).assetId, image.assetId);
      expect(restored.size, image.size);
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
