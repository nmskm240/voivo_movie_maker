// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_waveform_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioWaveform)
final audioWaveformProvider = AudioWaveformFamily._();

final class AudioWaveformProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<double>>,
          List<double>,
          FutureOr<List<double>>
        >
    with $FutureModifier<List<double>>, $FutureProvider<List<double>> {
  AudioWaveformProvider._({
    required AudioWaveformFamily super.from,
    required AssetId super.argument,
  }) : super(
         retry: null,
         name: r'audioWaveformProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static final $allTransitiveDependencies0 = projectProvider;
  static final $allTransitiveDependencies1 =
      ProjectProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 = projectAudioCacheProvider;
  static final $allTransitiveDependencies3 =
      ProjectAudioCacheProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$audioWaveformHash();

  @override
  String toString() {
    return r'audioWaveformProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<double>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<double>> create(Ref ref) {
    final argument = this.argument as AssetId;
    return audioWaveform(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AudioWaveformProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$audioWaveformHash() => r'4cf5deb2004d1949952cfdb9a1cedb8c10b98812';

final class AudioWaveformFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<double>>, AssetId> {
  AudioWaveformFamily._()
    : super(
        retry: null,
        name: r'audioWaveformProvider',
        dependencies: <ProviderOrFamily>[
          projectProvider,
          projectAudioCacheProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AudioWaveformProvider.$allTransitiveDependencies0,
          AudioWaveformProvider.$allTransitiveDependencies1,
          AudioWaveformProvider.$allTransitiveDependencies2,
          AudioWaveformProvider.$allTransitiveDependencies3,
        },
        isAutoDispose: true,
      );

  AudioWaveformProvider call(AssetId assetId) =>
      AudioWaveformProvider._(argument: assetId, from: this);

  @override
  String toString() => r'audioWaveformProvider';
}
