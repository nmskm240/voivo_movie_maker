// Package imports:
import 'package:cuid2/cuid2.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:voivo_movie_maker/domain/timeline_clips.dart';

// Project imports:
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
    Iterable<ClipComponent>? components,
  }) : assert(startFrame >= 0),
       assert(durationFrames > 0),
       _startFrame = startFrame,
       _durationFrames = durationFrames,
       components = (components ?? [TransformComponent()]).toList() {
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

  bool containsComponent(ClipComponentId componentId) =>
      components.any((component) => component.id == componentId);

  bool canRemoveComponent(ClipComponentId componentId) => components.any(
    (component) => component.id == componentId && component.isRemovable,
  );

  bool canAddComponent(ClipComponent component) {
    return !containsComponent(component.id) &&
        !components.any((saved) => saved.runtimeType == component.runtimeType);
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

  void removeComponent(ClipComponentId componentId) {
    if (!canRemoveComponent(componentId)) {
      throw ArgumentError.value(
        componentId,
        'componentId',
        'This component cannot be removed from the clip',
      );
    }
    components.removeWhere((component) => component.id == componentId);
  }

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
    final componentTypes = <Type>{};
    for (final component in components) {
      if (!componentIds.add(component.id)) {
        throw ArgumentError.value(
          components,
          'components',
          'Component IDs must be unique',
        );
      }

      if (!componentTypes.add(component.runtimeType)) {
        throw ArgumentError.value(
          components,
          'components',
          'Component types must be unique',
        );
      }
    }
  }

  Map<String, Object?> toJson() => _$TimelineClipToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TimelineClip && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
