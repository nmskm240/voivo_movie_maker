import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/infra/project_repository.dart';
import 'package:voivo_movie_maker/presentation/router.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  MediaKit.ensureInitialized();

  final appDir = await getApplicationSupportDirectory();
  final workspaceDir = Directory(p.join(appDir.path, 'voivo_movie_maker'));

  if (!workspaceDir.existsSync()) {
    workspaceDir.createSync(recursive: true);
  }
  FlutterNativeSplash.remove();
  runApp(
    ProviderScope(
      overrides: [
        projectRepositoryProvider.overrideWithValue(
          ProjectRepository(workspaceDir),
        ),
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
