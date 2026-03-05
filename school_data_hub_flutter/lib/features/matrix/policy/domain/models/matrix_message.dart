import 'package:json_annotation/json_annotation.dart';

part 'matrix_message.g.dart';

/// Base class for all Matrix message types
@JsonSerializable()
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

  factory MatrixMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixMessageFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixMessageToJson(this);
}

/// Text message type
@JsonSerializable()
class MatrixTextMessage extends MatrixMessage {
  const MatrixTextMessage({
    required super.body,
    super.format,
    super.formattedBody,
  }) : super(msgtype: 'm.text');

  factory MatrixTextMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixTextMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = _$MatrixTextMessageToJson(this);
    json['msgtype'] = msgtype; // Explicitly add msgtype
    return json;
  }
}

/// Emote message type
@JsonSerializable()
class MatrixEmoteMessage extends MatrixMessage {
  const MatrixEmoteMessage({
    required super.body,
    super.format,
    super.formattedBody,
  }) : super(msgtype: 'm.emote');

  factory MatrixEmoteMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixEmoteMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = _$MatrixEmoteMessageToJson(this);
    json['msgtype'] = msgtype; // Explicitly add msgtype
    return json;
  }
}

/// Notice message type
@JsonSerializable()
class MatrixNoticeMessage extends MatrixMessage {
  const MatrixNoticeMessage({
    required super.body,
    super.format,
    super.formattedBody,
  }) : super(msgtype: 'm.notice');

  factory MatrixNoticeMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixNoticeMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = _$MatrixNoticeMessageToJson(this);
    json['msgtype'] = msgtype; // Explicitly add msgtype
    return json;
  }
}

/// Image message type
@JsonSerializable()
class MatrixImageMessage extends MatrixMessage {
  final String url;
  final String? thumbnailUrl;
  final Map<String, dynamic>? info;

  const MatrixImageMessage({
    required super.body,
    required this.url,
    this.thumbnailUrl,
    this.info,
    super.format,
    super.formattedBody,
  }) : super(msgtype: 'm.image');

  factory MatrixImageMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixImageMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MatrixImageMessageToJson(this);
}

/// File message type
@JsonSerializable()
class MatrixFileMessage extends MatrixMessage {
  final String url;
  final String filename;
  final Map<String, dynamic>? info;

  const MatrixFileMessage({
    required super.body,
    required this.url,
    required this.filename,
    this.info,
    super.format,
    super.formattedBody,
  }) : super(msgtype: 'm.file');

  factory MatrixFileMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixFileMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MatrixFileMessageToJson(this);
}

/// Audio message type
@JsonSerializable()
class MatrixAudioMessage extends MatrixMessage {
  final String url;
  final Map<String, dynamic>? info;

  const MatrixAudioMessage({
    required super.body,
    required this.url,
    this.info,
    super.format,
    super.formattedBody,
  }) : super(msgtype: 'm.audio');

  factory MatrixAudioMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixAudioMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MatrixAudioMessageToJson(this);
}

/// Video message type
@JsonSerializable()
class MatrixVideoMessage extends MatrixMessage {
  final String url;
  final String? thumbnailUrl;
  final Map<String, dynamic>? info;

  const MatrixVideoMessage({
    required super.body,
    required this.url,
    this.thumbnailUrl,
    this.info,
    super.format,
    super.formattedBody,
  }) : super(msgtype: 'm.video');

  factory MatrixVideoMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixVideoMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MatrixVideoMessageToJson(this);
}

/// Location message type
@JsonSerializable()
class MatrixLocationMessage extends MatrixMessage {
  final String geoUri;
  final String? thumbnailUrl;
  final Map<String, dynamic>? info;

  const MatrixLocationMessage({
    required super.body,
    required this.geoUri,
    this.thumbnailUrl,
    this.info,
    super.format,
    super.formattedBody,
  }) : super(msgtype: 'm.location');

  factory MatrixLocationMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixLocationMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MatrixLocationMessageToJson(this);
}

/// Reply message type with relationship to another message
@JsonSerializable()
class MatrixReplyMessage extends MatrixMessage {
  final String? relatesToEventId;
  final String? relatesToRelType;

  const MatrixReplyMessage({
    required super.body,
    this.relatesToEventId,
    this.relatesToRelType,
    super.format,
    super.formattedBody,
  }) : super(msgtype: 'm.text');

  factory MatrixReplyMessage.fromJson(Map<String, dynamic> json) =>
      _$MatrixReplyMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MatrixReplyMessageToJson(this);
}

/// Message send response from Matrix server
@JsonSerializable()
class MatrixMessageResponse {
  final String eventId;

  const MatrixMessageResponse({required this.eventId});

  factory MatrixMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MatrixMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixMessageResponseToJson(this);
}

/// Message event received from Matrix server
@JsonSerializable()
class MatrixMessageEvent {
  final String eventId;
  final String type;
  final String sender;
  final int originServerTs;
  final String roomId;
  final Map<String, dynamic> content;
  final Map<String, dynamic>? unsigned;

  const MatrixMessageEvent({
    required this.eventId,
    required this.type,
    required this.sender,
    required this.originServerTs,
    required this.roomId,
    required this.content,
    this.unsigned,
  });

  factory MatrixMessageEvent.fromJson(Map<String, dynamic> json) =>
      _$MatrixMessageEventFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixMessageEventToJson(this);
}
