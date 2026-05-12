import 'package:flutter/material.dart';

class EmptyInspector extends StatelessWidget {
  const EmptyInspector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        'No clip selected',
        style: TextStyle(color: Color(0xff9ca3af), fontSize: 13),
      ),
    );
  }
}
