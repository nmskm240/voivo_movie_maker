// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:voivo_movie_maker/application/providers.dart';
import 'package:voivo_movie_maker/application/services/export/export_operation.dart';
import 'package:voivo_movie_maker/application/usecases.dart';
import 'package:voivo_movie_maker/presentation/project_edit/widgets/export/export_progress_dialog.dart';

class ExportButton extends ConsumerStatefulWidget {
  const ExportButton({super.key});

  @override
  ConsumerState<ExportButton> createState() => _ExportButtonState();
}

class _ExportButtonState extends ConsumerState<ExportButton> {
  var _isExporting = false;

  @override
  Widget build(BuildContext context) {
    final project = ref.watch(
      projectProvider.select((project) => project.value),
    );

    return FilledButton.icon(
      onPressed: project == null || _isExporting ? null : _export,
      icon: _isExporting
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.file_upload_outlined),
      label: Text(_isExporting ? 'Exporting...' : 'Export'),
    );
  }

  Future<void> _export() async {
    final project = ref.read(projectProvider).value;
    if (project == null) {
      return;
    }

    setState(() => _isExporting = true);
    final operation = ExportOperation();
    var dialogIsOpen = false;
    try {
      final exportFuture = ref.read(exportProjectProvider(operation).future);
      final exportStarted = await Future.any([
        operation.started.then((_) => true),
        exportFuture.then((_) => false),
      ]);
      if (exportStarted && mounted) {
        dialogIsOpen = true;
        unawaited(
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) => ExportProgressDialog(operation: operation),
          ),
        );
      }

      final result = await exportFuture;
      if (result == null || !mounted) {
        return;
      }

      final message = operation.isCancelled
          ? 'Export cancelled'
          : result.success
          ? 'Exported to ${result.outputPath}'
          : 'Export failed (code ${result.returnCode})';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: result.success
              ? const Duration(seconds: 6)
              : const Duration(seconds: 10),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      final message = operation.isCancelled
          ? 'Export cancelled'
          : 'Export failed: $error';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (dialogIsOpen && mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      await operation.dispose();
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }
}
