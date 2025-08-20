// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinedRoom _$JoinedRoomFromJson(Map<String, dynamic> json) => JoinedRoom(
      roomId: json['roomId'] as String,
      powerLevel: (json['powerLevel'] as num).toInt(),
    );

Map<String, dynamic> _$JoinedRoomToJson(JoinedRoom instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'powerLevel': instance.powerLevel,
    };

MatrixUser _$MatrixUserFromJson(Map<String, dynamic> json) => MatrixUser(
      id: json['id'] as String,
      active: json['active'] as bool?,
      authType: json['authType'] as String?,
      authCredential: json['authCredential'] as String?,
      displayName: json['displayName'] as String,
      joinedRooms: (json['joinedRooms'] as List<dynamic>)
          .map((e) => JoinedRoom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatrixUserToJson(MatrixUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'authType': instance.authType,
      'authCredential': instance.authCredential,
      'displayName': instance.displayName,
      'joinedRooms': instance.joinedRooms,
    };
