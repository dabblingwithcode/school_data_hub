class MatrixEventReport {
  final String eventId;
  final int id;
  final String? reason;
  final int? score;
  final int receivedTs;
  final String? canonicalAlias;
  final String roomId;
  final String? name;
  final String sender;
  final String userId;

  const MatrixEventReport({
    required this.eventId,
    required this.id,
    required this.reason,
    required this.score,
    required this.receivedTs,
    required this.canonicalAlias,
    required this.roomId,
    required this.name,
    required this.sender,
    required this.userId,
  });

  factory MatrixEventReport.fromJson(Map<String, dynamic> json) {
    return MatrixEventReport(
      eventId: json['event_id'] as String,
      id: (json['id'] as num).toInt(),
      reason: json['reason'] as String?,
      score: (json['score'] as num?)?.toInt(),
      receivedTs: (json['received_ts'] as num).toInt(),
      canonicalAlias: json['canonical_alias'] as String?,
      roomId: json['room_id'] as String,
      name: json['name'] as String?,
      sender: json['sender'] as String,
      userId: json['user_id'] as String,
    );
  }
}

class MatrixEventReportsResponse {
  final List<MatrixEventReport> eventReports;
  final int? nextToken;
  final int total;

  const MatrixEventReportsResponse({
    required this.eventReports,
    required this.nextToken,
    required this.total,
  });

  factory MatrixEventReportsResponse.fromJson(Map<String, dynamic> json) {
    final reports =
        (json['event_reports'] as List<dynamic>? ?? const <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(MatrixEventReport.fromJson)
            .toList();

    return MatrixEventReportsResponse(
      eventReports: reports,
      nextToken: (json['next_token'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt() ?? reports.length,
    );
  }
}

class MatrixEventReportDetail extends MatrixEventReport {
  final Map<String, dynamic>? eventJson;

  const MatrixEventReportDetail({
    required super.eventId,
    required super.id,
    required super.reason,
    required super.score,
    required super.receivedTs,
    required super.canonicalAlias,
    required super.roomId,
    required super.name,
    required super.sender,
    required super.userId,
    required this.eventJson,
  });

  factory MatrixEventReportDetail.fromJson(Map<String, dynamic> json) {
    return MatrixEventReportDetail(
      eventId: json['event_id'] as String,
      id: (json['id'] as num).toInt(),
      reason: json['reason'] as String?,
      score: (json['score'] as num?)?.toInt(),
      receivedTs: (json['received_ts'] as num).toInt(),
      canonicalAlias: json['canonical_alias'] as String?,
      roomId: json['room_id'] as String,
      name: json['name'] as String?,
      sender: json['sender'] as String,
      userId: json['user_id'] as String,
      eventJson: json['event_json'] as Map<String, dynamic>?,
    );
  }
}
