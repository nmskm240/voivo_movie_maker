class FfmpegCommandBuilder {
  final List<String> _arguments = [];

  FfmpegCommandBuilder addFlag(String flag) {
    _arguments.add(flag);
    return this;
  }

  FfmpegCommandBuilder addOption(String option, Object value) {
    _arguments
      ..add(option)
      ..add("'${value.toString().replaceAll("'", r"'\''")}'");
    return this;
  }

  FfmpegCommandBuilder addInput(String path) {
    return addOption('-i', path);
  }

  FfmpegCommandBuilder addOutput(String path) {
    _arguments.add("'${path.replaceAll("'", r"'\''")}'");
    return this;
  }

  String build() => _arguments.join(' ');
}
