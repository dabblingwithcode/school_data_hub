// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatrixMessage _$MatrixMessageFromJson(Map<String, dynamic> json) =>
    MatrixMessage(
      msgtype: json['msgtype'] as String,
      body: json['body'] as String,
      format: json['format'] as String?,
      formattedBody: json['formattedBody'] as String?,
    );

Map<String, dynamic> _$MatrixMessageToJson(MatrixMessage instance) =>
    <String, dynamic>{
      'msgtype': instance.msgtype,
      'body': instance.body,
      'format': instance.format,
      'formattedBody': instance.formattedBody,
    };

MatrixTextMessage _$MatrixTextMessageFromJson(Map<String, dynamic> json) =>
    MatrixTextMessage(
      body: json['body'] as String,
      format: json['format'] as String?,
      formattedBody: json['formattedBody'] as String?,
    );

Map<String, dynamic> _$MatrixTextMessageToJson(MatrixTextMessage instance) =>
    <String, dynamic>{
      'body': instance.body,
      'format': instance.format,
      'formattedBody': instance.formattedBody,
    };

MatrixEmoteMessage _$MatrixEmoteMessageFromJson(Map<String, dynamic> json) =>
    MatrixEmoteMessage(
      body: json['body'] as String,
      format: json['format'] as String?,
      formattedBody: json['formattedBody'] as String?,
    );

Map<String, dynamic> _$MatrixEmoteMessageToJson(MatrixEmoteMessage instance) =>
    <String, dynamic>{
      'body': instance.body,
      'format': instance.format,
      'formattedBody': instance.formattedBody,
    };

MatrixNoticeMessage _$MatrixNoticeMessageFromJson(Map<String, dynamic> json) =>
    MatrixNoticeMessage(
      body: json['body'] as String,
      format: json['format'] as String?,
      formattedBody: json['formattedBody'] as String?,
    );

Map<String, dynamic> _$MatrixNoticeMessageToJson(
  MatrixNoticeMessage instance,
) => <String, dynamic>{
  'body': instance.body,
  'format': instance.format,
  'formattedBody': instance.formattedBody,
};

MatrixImageMessage _$MatrixImageMessageFromJson(Map<String, dynamic> json) =>
    MatrixImageMessage(
      body: json['body'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      info: json['info'] as Map<String, dynamic>?,
      format: json['format'] as String?,
      formattedBody: json['formattedBody'] as String?,
    );

Map<String, dynamic> _$MatrixImageMessageToJson(MatrixImageMessage instance) =>
    <String, dynamic>{
      'body': instance.body,
      'format': instance.format,
      'formattedBody': instance.formattedBody,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'info': instance.info,
    };

MatrixFileMessage _$MatrixFileMessageFromJson(Map<String, dynamic> json) =>
    MatrixFileMessage(
      body: json['body'] as String,
      url: json['url'] as String,
      filename: json['filename'] as String,
      info: json['info'] as Map<String, dynamic>?,
      format: json['format'] as String?,
      formattedBody: json['formattedBody'] as String?,
    );

Map<String, dynamic> _$MatrixFileMessageToJson(MatrixFileMessage instance) =>
    <String, dynamic>{
      'body': instance.body,
      'format': instance.format,
      'formattedBody': instance.formattedBody,
      'url': instance.url,
      'filename': instance.filename,
      'info': instance.info,
    };

MatrixAudioMessage _$MatrixAudioMessageFromJson(Map<String, dynamic> json) =>
    MatrixAudioMessage(
      body: json['body'] as String,
      url: json['url'] as String,
      info: json['info'] as Map<String, dynamic>?,
      format: json['format'] as String?,
      formattedBody: json['formattedBody'] as String?,
    );

Map<String, dynamic> _$MatrixAudioMessageToJson(MatrixAudioMessage instance) =>
    <String, dynamic>{
      'body': instance.body,
      'format': instance.format,
      'formattedBody': instance.formattedBody,
      'url': instance.url,
      'info': instance.info,
    };

MatrixVideoMessage _$MatrixVideoMessageFromJson(Map<String, dynamic> json) =>
    MatrixVideoMessage(
      body: json['body'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      info: json['info'] as Map<String, dynamic>?,
      format: json['format'] as String?,
      formattedBody: json['formattedBody'] as String?,
    );

Map<String, dynamic> _$MatrixVideoMessageToJson(MatrixVideoMessage instance) =>
    <String, dynamic>{
      'body': instance.body,
      'format': instance.format,
      'formattedBody': instance.formattedBody,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'info': instance.info,
    };

MatrixLocationMessage _$MatrixLocationMessageFromJson(
  Map<String, dynamic> json,
) => MatrixLocationMessage(
  body: json['body'] as String,
  geoUri: json['geoUri'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  info: json['info'] as Map<String, dynamic>?,
  format: json['format'] as String?,
  formattedBody: json['formattedBody'] as String?,
);

Map<String, dynamic> _$MatrixLocationMessageToJson(
  MatrixLocationMessage instance,
) => <String, dynamic>{
  'body': instance.body,
  'format': instance.format,
  'formattedBody': instance.formattedBody,
  'geoUri': instance.geoUri,
  'thumbnailUrl': instance.thumbnailUrl,
  'info': instance.info,
};

MatrixReplyMessage _$MatrixReplyMessageFromJson(Map<String, dynamic> json) =>
    MatrixReplyMessage(
      body: json['body'] as String,
      relatesToEventId: json['relatesToEventId'] as String?,
      relatesToRelType: json['relatesToRelType'] as String?,
      format: json['format'] as String?,
      formattedBody: json['formattedBody'] as String?,
    );

Map<String, dynamic> _$MatrixReplyMessageToJson(MatrixReplyMessage instance) =>
    <String, dynamic>{
      'body': instance.body,
      'format': instance.format,
      'formattedBody': instance.formattedBody,
      'relatesToEventId': instance.relatesToEventId,
      'relatesToRelType': instance.relatesToRelType,
    };

MatrixMessageResponse _$MatrixMessageResponseFromJson(
  Map<String, dynamic> json,
) => MatrixMessageResponse(eventId: json['eventId'] as String);

Map<String, dynamic> _$MatrixMessageResponseToJson(
  MatrixMessageResponse instance,
) => <String, dynamic>{'eventId': instance.eventId};

MatrixMessageEvent _$MatrixMessageEventFromJson(Map<String, dynamic> json) =>
    MatrixMessageEvent(
      eventId: json['eventId'] as String,
      type: json['type'] as String,
      sender: json['sender'] as String,
      originServerTs: (json['originServerTs'] as num).toInt(),
      roomId: json['roomId'] as String,
      content: json['content'] as Map<String, dynamic>,
      unsigned: json['unsigned'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MatrixMessageEventToJson(MatrixMessageEvent instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'type': instance.type,
      'sender': instance.sender,
      'originServerTs': instance.originServerTs,
      'roomId': instance.roomId,
      'content': instance.content,
      'unsigned': instance.unsigned,
    };
