// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pupil_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PupilIdentity _$PupilIdentityFromJson(Map<String, dynamic> json) =>
    PupilIdentity(
      id: (json['id'] as num).toInt(),
      firstName: json['name'] as String,
      lastName: json['lastName'] as String,
      group: json['group'] as String,
      schoolGrade: json['schoolyear'] as String,
      gender: json['gender'] as String,
      language: json['language'] as String,
      family: json['family'] as String?,
      birthday: DateTime.parse(json['birthday'] as String),
      pupilSince: DateTime.parse(json['pupilSince'] as String),
      specialNeeds: json['specialNeeds'] as String?,
      migrationSupportEnds: json['migrationSupportEnds'] == null
          ? null
          : DateTime.parse(json['migrationSupportEnds'] as String),
    );

Map<String, dynamic> _$PupilIdentityToJson(PupilIdentity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.firstName,
      'lastName': instance.lastName,
      'group': instance.group,
      'schoolyear': instance.schoolGrade,
      'specialNeeds': instance.specialNeeds,
      'gender': instance.gender,
      'language': instance.language,
      'family': instance.family,
      'birthday': instance.birthday.toIso8601String(),
      'migrationSupportEnds': instance.migrationSupportEnds?.toIso8601String(),
      'pupilSince': instance.pupilSince.toIso8601String(),
    };
