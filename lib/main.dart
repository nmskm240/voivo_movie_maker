import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:voivo_movie_maker/application/services/voice_generator.dart';
import 'package:voivo_movie_maker/presentation/screens/editor_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  final appDir = await getApplicationSupportDirectory();
  final workspaceDir = Directory(p.join(appDir.path, 'voivo_movie_maker'));

  if (!workspaceDir.existsSync()) {
    workspaceDir.createSync(recursive: true);
  }
  runApp(ProviderScope(overrides: [], child: const VoivoMovieMakerApp()));
}

class VoivoMovieMakerApp extends StatelessWidget {
  const VoivoMovieMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        voiceGeneratorProvider.overrideWith((ref) {
          return VoicevoxCoreSpeechService.create();
        }),
      ],
      child: MaterialApp(
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
        home: const EditorScreen(),
      ),
    );
  }
}
