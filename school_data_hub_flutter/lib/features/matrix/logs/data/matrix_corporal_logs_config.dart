/// Response from GET/PUT /_matrix/corporal/logs/config.
class MatrixCorporalLogsConfig {
  const MatrixCorporalLogsConfig({required this.levels});

  final Map<String, bool> levels;

  factory MatrixCorporalLogsConfig.fromJson(Map<String, dynamic> json) {
    final levelsJson = json['levels'];
    final Map<String, bool> levels = {};
    if (levelsJson is Map<String, dynamic>) {
      for (final e in levelsJson.entries) {
        levels[e.key] = e.value == true;
      }
    }
    return MatrixCorporalLogsConfig(levels: levels);
  }

  Map<String, dynamic> toJson() => {'levels': levels};
}
