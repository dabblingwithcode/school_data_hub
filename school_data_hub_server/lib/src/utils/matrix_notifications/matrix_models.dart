class MatrixMessage {
  final String msgtype;
  final String body;
  final String? format;
  final String? formattedBody;

  const MatrixMessage({
    required this.msgtype,
    required this.body,
    this.format,
    this.formattedBody,
  });

  factory MatrixMessage.fromJson(Map<String, dynamic> json) => MatrixMessage(
        msgtype: json['msgtype'] as String,
        body: json['body'] as String,
        format: json['format'] as String?,
        formattedBody: json['formatted_body'] as String?,
      );
}

class MatrixMessageResponse {
  final String eventId;

  MatrixMessageResponse({required this.eventId});
  factory MatrixMessageResponse.fromJson(Map<String, dynamic> json) {
    return MatrixMessageResponse(eventId: json['event_id'] as String);
  }
}
