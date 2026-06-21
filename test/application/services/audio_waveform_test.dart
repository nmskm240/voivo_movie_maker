// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:voivo_movie_maker/application/services/audio_waveform.dart';

void main() {
  test('creates normalized peaks from 16-bit PCM wav bytes', () {
    final bytes = _wav16([0, 8192, -16384, 32767]);

    final peaks = AudioWaveform.fromBytes(bytes, bars: 4);

    expect(peaks, hasLength(4));
    expect(peaks[0], 0);
    expect(peaks[1], closeTo(0.25, 0.01));
    expect(peaks[2], closeTo(0.5, 0.01));
    expect(peaks[3], closeTo(1, 0.01));
  });

  test('returns an empty waveform for unsupported bytes', () {
    final peaks = AudioWaveform.fromBytes(Uint8List.fromList([1, 2, 3]));

    expect(peaks, isEmpty);
  });
}

Uint8List _wav16(List<int> samples) {
  const sampleRate = 44100;
  const channels = 1;
  const bitsPerSample = 16;
  final dataSize = samples.length * 2;
  final bytes = Uint8List(44 + dataSize);
  final data = ByteData.sublistView(bytes);
  _writeTag(bytes, 0, 'RIFF');
  data.setUint32(4, 36 + dataSize, Endian.little);
  _writeTag(bytes, 8, 'WAVE');
  _writeTag(bytes, 12, 'fmt ');
  data.setUint32(16, 16, Endian.little);
  data.setUint16(20, 1, Endian.little);
  data.setUint16(22, channels, Endian.little);
  data.setUint32(24, sampleRate, Endian.little);
  data.setUint32(28, sampleRate * channels * bitsPerSample ~/ 8, Endian.little);
  data.setUint16(32, channels * bitsPerSample ~/ 8, Endian.little);
  data.setUint16(34, bitsPerSample, Endian.little);
  _writeTag(bytes, 36, 'data');
  data.setUint32(40, dataSize, Endian.little);
  for (var index = 0; index < samples.length; index++) {
    data.setInt16(44 + index * 2, samples[index], Endian.little);
  }
  return bytes;
}

void _writeTag(Uint8List bytes, int offset, String value) {
  for (var index = 0; index < value.length; index++) {
    bytes[offset + index] = value.codeUnitAt(index);
  }
}
