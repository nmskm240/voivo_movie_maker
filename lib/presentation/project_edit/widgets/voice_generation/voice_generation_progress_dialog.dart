// Flutter imports:
import 'package:flutter/material.dart';

class VoiceGenerationProgressDialog extends StatelessWidget {
  const VoiceGenerationProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text('Creating voice'),
        content: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(),
              SizedBox(height: 12),
              Text(
                'Generating audio and adding it to the timeline...',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
