// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/voice_generator.dart';
import 'package:voivo_movie_maker/infra/project_repository.dart';
import 'package:voivo_movie_maker/infra/voicevox_core/voicevox_core.dart';
import 'package:voivo_movie_maker/presentation/router.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  MediaKit.ensureInitialized();

  final appDir = await getApplicationSupportDirectory();
  final projectsDirectory = Directory(p.join(appDir.path, 'voivo_movie_maker'));

  if (!projectsDirectory.existsSync()) {
    projectsDirectory.createSync(recursive: true);
  }
  FlutterNativeSplash.remove();
  runApp(
    ProviderScope(
      overrides: [
        projectRepositoryProvider.overrideWithValue(
          ProjectRepository(projectsDirectory),
        ),
        projectsDirectoryProvider.overrideWithValue(projectsDirectory),
        voiceGeneratorProvider.overrideWith((ref) async {
          final generator = await VoicevoxCore.create();
          ref.onDispose(generator.dispose);
          return generator;
        }),
      ],
      child: const VoivoMovieMakerApp(),
    ),
  );
}

class VoivoMovieMakerApp extends StatelessWidget {
  const VoivoMovieMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Voivo Movie Maker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black87,
        fontFamily: 'Noto Sans CJK JP',
      ),
      routerConfig: appRouter,
    );
  }
}
