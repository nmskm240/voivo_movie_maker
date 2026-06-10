import 'package:cuid2/cuid2.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/timeline_clips/components/base.dart';
import 'package:voivo_movie_maker/utils/json_converters.dart';

part 'base.g.dart';

@JsonSerializable()
class TimelineClipId {
  const TimelineClipId(this.value);

  factory TimelineClipId.create() => TimelineClipId(cuid());

  factory TimelineClipId.fromString(String value) {
    if (value.isEmpty || !isCuid(value)) {
      throw ArgumentError.value(value, 'value', 'Invalid timeline clip ID');
    }
    return TimelineClipId(value);
  }

  factory TimelineClipId.fromJson(Map<String, Object?> value) =>
      _$TimelineClipIdFromJson(value);

  final String value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TimelineClipId && other.value == value;

  @override
  String toString() => value;

  Map<String, Object?> toJson() => _$TimelineClipIdToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TimelineClip {
  TimelineClip({
    required this.id,
    required int startFrame,
    int durationFrames = 10,
    Iterable<ClipComponent> components = const [],
  }) : assert(startFrame >= 0),
       assert(durationFrames > 0),
       _startFrame = startFrame,
       _durationFrames = durationFrames,
       components = components.toList() {
    _validateComponents();
  }

  factory TimelineClip.fromJson(Map<String, Object?> json) =>
      _$TimelineClipFromJson(json);

  final TimelineClipId id;
  int _startFrame;
  int _durationFrames;
  @ClipComponentJsonConverter()
  final List<ClipComponent> components;

  int get startFrame => _startFrame;
  int get durationFrames => _durationFrames;
  int get endFrame => _startFrame + _durationFrames;

  T? component<T extends ClipComponent>() {
    for (final component in components) {
      if (component is T) {
        return component;
      }
    }
    return null;
  }

  bool hasComponent<T extends ClipComponent>() => component<T>() != null;

  Iterable<T> componentsOf<T extends ClipComponent>() =>
      components.whereType<T>();

  bool containsComponent(ClipComponentId componentId) =>
      components.any((component) => component.id == componentId);

  bool canAddComponent(ClipComponent component) {
    if (containsComponent(component.id)) {
      return false;
    }

    final maxInstances = component.maxInstancesPerClip;
    if (maxInstances == null) {
      return true;
    }
    if (maxInstances <= 0) {
      throw StateError(
        '${component.runtimeType}.maxInstancesPerClip must be positive or null',
      );
    }

    final savedInstances = components
        .where((saved) => saved.runtimeType == component.runtimeType)
        .length;
    return savedInstances < maxInstances;
  }

  void addComponent(ClipComponent component) {
    if (!canAddComponent(component)) {
      throw ArgumentError.value(
        component,
        'component',
        'This component cannot be added to the clip',
      );
    }
    components.add(component);
  }

  void removeComponent(ClipComponentId componentId) =>
      components.removeWhere((component) => component.id == componentId);

  bool isActiveAt(int frame) => startFrame <= frame && frame < endFrame;

  bool isConflict(TimelineClip clip) =>
      clip != this && startFrame < clip.endFrame && clip.startFrame < endFrame;

  void moveTo(int newStartFrame) {
    if (newStartFrame < 0) {
      throw ArgumentError.value(newStartFrame, 'newStartFrame');
    }
    _startFrame = newStartFrame;
  }

  void trimStartTo(int newStartFrame) {
    final oldEndFrame = endFrame;
    if (newStartFrame < 0 || newStartFrame >= oldEndFrame) {
      throw ArgumentError.value(newStartFrame, 'newStartFrame');
    }
    _startFrame = newStartFrame;
    _durationFrames = oldEndFrame - newStartFrame;
  }

  void trimEndTo(int newEndFrame) {
    if (newEndFrame <= _startFrame) {
      throw ArgumentError.value(newEndFrame, 'newEndFrame');
    }
    _durationFrames = newEndFrame - _startFrame;
  }

  void _validateComponents() {
    final componentIds = <ClipComponentId>{};
    final instancesByType = <Type, int>{};
    for (final component in components) {
      if (!componentIds.add(component.id)) {
        throw ArgumentError.value(
          components,
          'components',
          'Component IDs must be unique',
        );
      }

      final maxInstances = component.maxInstancesPerClip;
      if (maxInstances != null && maxInstances <= 0) {
        throw StateError(
          '${component.runtimeType}.maxInstancesPerClip must be positive or null',
        );
      }

      final instances = (instancesByType[component.runtimeType] ?? 0) + 1;
      if (maxInstances != null && instances > maxInstances) {
        throw ArgumentError.value(
          components,
          'components',
          '${component.runtimeType} allows at most $maxInstances instances',
        );
      }
      instancesByType[component.runtimeType] = instances;
    }
  }

  Map<String, Object?> toJson() => _$TimelineClipToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TimelineClip && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
