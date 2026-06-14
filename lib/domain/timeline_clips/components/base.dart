// Package imports:
import 'package:cuid2/cuid2.dart';
import 'package:json_annotation/json_annotation.dart';

class ClipComponentId {
  const ClipComponentId(this.value);

  factory ClipComponentId.create() => ClipComponentId(cuid());

  factory ClipComponentId.fromString(String value) {
    if (value.isEmpty || !isCuid(value)) {
      throw ArgumentError.value(value, 'value', 'Invalid clip component ID');
    }
    return ClipComponentId(value);
  }

  final String value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClipComponentId && other.value == value;

  @override
  String toString() => value;
}

class ClipComponentIdJsonConverter
    implements JsonConverter<ClipComponentId, String?> {
  const ClipComponentIdJsonConverter();

  @override
  ClipComponentId fromJson(String? json) => json == null
      ? ClipComponentId.create()
      : ClipComponentId.fromString(json);

  @override
  String toJson(ClipComponentId object) => object.value;
}

abstract class ClipComponent {
  ClipComponent({ClipComponentId? id}) : id = id ?? ClipComponentId.create();

  @ClipComponentIdJsonConverter()
  final ClipComponentId id;

  String get label;
}
