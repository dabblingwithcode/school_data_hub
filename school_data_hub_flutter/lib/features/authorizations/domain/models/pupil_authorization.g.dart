// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_authorization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PupilAuthorization _$PupilAuthorizationFromJson(Map<String, dynamic> json) =>
    PupilAuthorization(
      comment: json['comment'] as String?,
      createdBy: json['created_by'] as String?,
      fileId: json['file_id'] as String?,
      originAuthorization: json['origin_authorization'] as String,
      pupilId: (json['pupil_id'] as num).toInt(),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$PupilAuthorizationToJson(PupilAuthorization instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'created_by': instance.createdBy,
      'file_id': instance.fileId,
      'origin_authorization': instance.originAuthorization,
      'pupil_id': instance.pupilId,
      'status': instance.status,
    };
