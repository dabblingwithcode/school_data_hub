// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authorization _$AuthorizationFromJson(Map<String, dynamic> json) =>
    Authorization(
      authorizationDescription: json['authorization_description'] as String,
      authorizationId: json['authorization_id'] as String,
      authorizationName: json['authorization_name'] as String,
      createdBy: json['created_by'] as String?,
      authorizedPupils: (json['authorized_pupils'] as List<dynamic>)
          .map((e) => PupilAuthorization.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthorizationToJson(Authorization instance) =>
    <String, dynamic>{
      'authorization_description': instance.authorizationDescription,
      'authorization_id': instance.authorizationId,
      'authorization_name': instance.authorizationName,
      'created_by': instance.createdBy,
      'authorized_pupils': instance.authorizedPupils,
    };
