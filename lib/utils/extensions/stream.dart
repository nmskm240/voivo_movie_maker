import 'dart:typed_data';

extension StreamExtensions on Stream<List<int>> {
  Future<Uint8List> toUint8List() async {
    final bytes = <int>[];
    await for (final chunk in this) {
      bytes.addAll(chunk);
    }
    return Uint8List.fromList(bytes);
  }
}
