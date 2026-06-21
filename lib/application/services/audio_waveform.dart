// Dart imports:
import 'dart:math' as math;
import 'dart:typed_data';

abstract final class AudioWaveform {
  static List<double> fromBytes(Uint8List bytes, {int bars = 64}) {
    if (bars <= 0) {
      return const [];
    }
    final wav = _WavData.tryParse(bytes);
    if (wav == null || wav.frameCount == 0) {
      return const [];
    }

    final peaks = List<double>.filled(bars, 0);
    final framesPerBar = math.max(1, (wav.frameCount / bars).ceil());
    for (var frame = 0; frame < wav.frameCount; frame++) {
      final bar = math.min(bars - 1, frame ~/ framesPerBar);
      var amplitude = 0.0;
      for (var channel = 0; channel < wav.channels; channel++) {
        amplitude += wav.sampleAmplitude(frame, channel);
      }
      amplitude /= wav.channels;
      if (amplitude > peaks[bar]) {
        peaks[bar] = amplitude;
      }
    }

    final maxPeak = peaks.fold<double>(0, math.max);
    if (maxPeak <= 0) {
      return peaks;
    }
    return [for (final peak in peaks) peak / maxPeak];
  }
}

final class _WavData {
  const _WavData({
    required this.data,
    required this.dataOffset,
    required this.dataSize,
    required this.audioFormat,
    required this.channels,
    required this.bitsPerSample,
  });

  final ByteData data;
  final int dataOffset;
  final int dataSize;
  final int audioFormat;
  final int channels;
  final int bitsPerSample;

  int get bytesPerSample => bitsPerSample ~/ 8;
  int get frameSize => bytesPerSample * channels;
  int get frameCount => frameSize == 0 ? 0 : dataSize ~/ frameSize;

  static _WavData? tryParse(Uint8List bytes) {
    if (bytes.length < 44) {
      return null;
    }
    final data = ByteData.sublistView(bytes);
    if (_tag(data, 0) != 'RIFF' || _tag(data, 8) != 'WAVE') {
      return null;
    }

    int? audioFormat;
    int? channels;
    int? bitsPerSample;
    int? dataOffset;
    int? dataSize;
    var offset = 12;
    while (offset + 8 <= bytes.length) {
      final tag = _tag(data, offset);
      final size = data.getUint32(offset + 4, Endian.little);
      final chunkOffset = offset + 8;
      if (chunkOffset + size > bytes.length) {
        break;
      }
      if (tag == 'fmt ' && size >= 16) {
        audioFormat = data.getUint16(chunkOffset, Endian.little);
        channels = data.getUint16(chunkOffset + 2, Endian.little);
        bitsPerSample = data.getUint16(chunkOffset + 14, Endian.little);
      } else if (tag == 'data') {
        dataOffset = chunkOffset;
        dataSize = size;
      }
      offset = chunkOffset + size + (size.isOdd ? 1 : 0);
    }

    if (audioFormat == null ||
        channels == null ||
        bitsPerSample == null ||
        dataOffset == null ||
        dataSize == null ||
        channels <= 0 ||
        bitsPerSample % 8 != 0) {
      return null;
    }
    return _WavData(
      data: data,
      dataOffset: dataOffset,
      dataSize: dataSize,
      audioFormat: audioFormat,
      channels: channels,
      bitsPerSample: bitsPerSample,
    );
  }

  double sampleAmplitude(int frame, int channel) {
    final offset = dataOffset + frame * frameSize + channel * bytesPerSample;
    return switch ((audioFormat, bitsPerSample)) {
      (1, 8) => ((data.getUint8(offset) - 128) / 128).abs(),
      (1, 16) => (data.getInt16(offset, Endian.little) / 32768).abs(),
      (1, 24) => (_getInt24(offset) / 8388608).abs(),
      (1, 32) => (data.getInt32(offset, Endian.little) / 2147483648).abs(),
      (3, 32) => data.getFloat32(offset, Endian.little).abs().clamp(0, 1),
      _ => 0,
    };
  }

  int _getInt24(int offset) {
    final value =
        data.getUint8(offset) |
        (data.getUint8(offset + 1) << 8) |
        (data.getUint8(offset + 2) << 16);
    return (value & 0x800000) == 0 ? value : value | ~0xffffff;
  }

  static String _tag(ByteData data, int offset) {
    return String.fromCharCodes([
      data.getUint8(offset),
      data.getUint8(offset + 1),
      data.getUint8(offset + 2),
      data.getUint8(offset + 3),
    ]);
  }
}
