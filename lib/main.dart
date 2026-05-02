import 'package:flutter/material.dart';

import 'screens/editor_mock_screen.dart';

void main() {
  runApp(const VoivoMovieMakerApp());
}

class VoivoMovieMakerApp extends StatelessWidget {
  const VoivoMovieMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xff8fd6c8);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voivo Movie Maker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: baseColor,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xff111416),
        fontFamily: 'Noto Sans JP',
      ),
      home: const EditorMockScreen(),
    );
  }
}
