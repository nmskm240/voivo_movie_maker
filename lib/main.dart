import 'package:flutter/material.dart';

import 'screens/editor_mock_screen.dart';

void main() {
  runApp(const VoivoMovieMakerApp());
}

class VoivoMovieMakerApp extends StatelessWidget {
  const VoivoMovieMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const EditorMockScreen(),
    );
  }
}
