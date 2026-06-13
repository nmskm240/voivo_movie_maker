class ExportResult {
  const ExportResult({
    required this.success,
    required this.outputPath,
    required this.command,
    required this.logs,
    required this.returnCode,
  });

  final bool success;
  final String outputPath;
  final String command;
  final String logs;
  final int returnCode;
}
