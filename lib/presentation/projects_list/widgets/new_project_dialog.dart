import 'package:flutter/material.dart';

class NewProjectDialog extends StatefulWidget {
  const NewProjectDialog({super.key});

  static Future<String?> show(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) => const NewProjectDialog(),
    );
  }

  @override
  State<NewProjectDialog> createState() => _NewProjectDialogState();
}

class _NewProjectDialogState extends State<NewProjectDialog> {
  String _projectName = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New project'),
      content: TextField(
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Project name'),
        onChanged: (value) => _projectName = value,
        onSubmitted: _submit,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => _submit(_projectName),
          child: const Text('Create'),
        ),
      ],
    );
  }

  void _submit(String value) {
    Navigator.of(context).pop(value);
  }
}
