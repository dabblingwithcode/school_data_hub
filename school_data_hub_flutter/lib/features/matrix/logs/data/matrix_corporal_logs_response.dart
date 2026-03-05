import 'matrix_corporal_log_entry.dart';

/// Response from GET /_matrix/corporal/logs.
class MatrixCorporalLogsResponse {
  const MatrixCorporalLogsResponse({
    required this.logs,
    required this.total,
  });

  final List<MatrixCorporalLogEntry> logs;
  final int total;

  factory MatrixCorporalLogsResponse.fromJson(Map<String, dynamic> json) {
    final logsList = json['logs'];
    final list = logsList is List
        ? (logsList)
            .map((e) => MatrixCorporalLogEntry.fromJson(
                Map<String, dynamic>.from(e as Map)))
            .toList()
        : <MatrixCorporalLogEntry>[];
    final total = json['total'] is int ? json['total'] as int : 0;
    return MatrixCorporalLogsResponse(logs: list, total: total);
  }
}
