// Dart imports:
import 'dart:async';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/usecases.dart';
import 'package:voivo_movie_maker/domain/project_assets.dart';

part 'voice_editor_view_model.g.dart';

@Riverpod(dependencies: [createVoiceAsset, project])
class VoiceEditorViewModel extends _$VoiceEditorViewModel {
  @override
  FutureOr<void> build() {}

  Future<ProjectAsset> generate({
    required String dialogue,
    required int speakerId,
  }) async {
    state = const AsyncLoading();
    try {
      final asset = await ref.read(
        createVoiceAssetProvider(
          dialogue: dialogue,
          speakerId: speakerId,
        ).future,
      );
      ref.invalidate(projectProvider);
      state = const AsyncData(null);
      return asset;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
