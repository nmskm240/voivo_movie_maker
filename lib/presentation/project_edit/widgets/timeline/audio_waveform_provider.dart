// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/audio_waveform.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';

part 'audio_waveform_provider.g.dart';

@Riverpod(dependencies: [project, projectAudioCache])
Future<List<double>> audioWaveform(Ref ref, AssetId assetId) async {
  final audioCache = ref.watch(projectAudioCacheProvider);
  final project = await ref.watch(projectProvider.future);
  final asset = project.assets.findById(assetId);
  if (asset == null) {
    return const [];
  }
  final bytes = await audioCache.load(asset);
  return AudioWaveform.fromBytes(bytes);
}
