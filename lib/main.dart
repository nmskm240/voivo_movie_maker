import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voivo_movie_maker/application/providers/loaded_project_provider.dart';
import 'package:voivo_movie_maker/infra/project_repository.dart';
import 'package:voivo_movie_maker/presentation/screens/editor_screen.dart';

void main() {
  runApp(const VoivoMovieMakerApp());
}

class VoivoMovieMakerApp extends StatelessWidget {
  const VoivoMovieMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        projectRepositoryProvider.overrideWith((ref) {
          final directory = ref.watch(projectPathProvider);
          return DirectoryProjectRepository(directory);
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
