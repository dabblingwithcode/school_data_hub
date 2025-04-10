// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Policy _$PolicyFromJson(Map<String, dynamic> json) => Policy(
      schemaVersion: (json['schemaVersion'] as num).toInt(),
      identificationStamp: json['identificationStamp'],
      flags: Flags.fromJson(json['flags'] as Map<String, dynamic>),
      hooks: json['hooks'],
      matrixUsers: (json['users'] as List<dynamic>?)
          ?.map((e) => MatrixUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      managedRoomIds: (json['managedRoomIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PolicyToJson(Policy instance) => <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'identificationStamp': instance.identificationStamp,
      'flags': instance.flags,
      'hooks': instance.hooks,
      'managedRoomIds': instance.managedRoomIds,
      'users': instance.matrixUsers,
    };
