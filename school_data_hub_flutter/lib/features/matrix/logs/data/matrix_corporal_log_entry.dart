/// A single log entry from the matrix-corporal logs API.
class MatrixCorporalLogEntry {
  const MatrixCorporalLogEntry({
    required this.id,
    required this.time,
    required this.level,
    required this.message,
    this.fields = const {},
  });

  final String id;
  final DateTime time;
  final String level;
  final String message;
  final Map<String, dynamic> fields;

  factory MatrixCorporalLogEntry.fromJson(Map<String, dynamic> json) {
    return MatrixCorporalLogEntry(
      id: json['id'] as String? ?? '',
      time: DateTime.parse(json['time'] as String? ?? ''),
      level: json['level'] as String? ?? 'info',
      message: json['message'] as String? ?? '',
      fields: json['fields'] is Map<String, dynamic>
          ? json['fields'] as Map<String, dynamic>
          : {},
    );
  }
}
