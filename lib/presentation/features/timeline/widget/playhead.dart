import 'package:flutter/material.dart';

class Playhead extends StatelessWidget {
  const Playhead({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
      child: SizedBox(width: 2),
    );
  }
}
