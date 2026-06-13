// Dart imports:
import 'dart:convert';
import 'dart:ffi' as ffi;

extension FfiPointerExtensions on ffi.Pointer<ffi.Char> {
  String toDartString() {
    final bytes = <int>[];
    final bytePointer = cast<ffi.Uint8>();
    for (var offset = 0; ; offset += 1) {
      final byte = (bytePointer + offset).value;
      if (byte == 0) {
        break;
      }
      bytes.add(byte);
    }
    return utf8.decode(bytes);
  }
}
