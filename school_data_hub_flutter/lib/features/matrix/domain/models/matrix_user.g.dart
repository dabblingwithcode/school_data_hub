// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatrixUser _$MatrixUserFromJson(Map<String, dynamic> json) => MatrixUser(
      id: json['id'] as String?,
      active: json['active'] as bool?,
      authType: json['authType'] as String?,
      displayName: json['displayName'] as String,
      joinedRoomIds: (json['joinedRoomIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MatrixUserToJson(MatrixUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'authType': instance.authType,
      'displayName': instance.displayName,
      'joinedRoomIds': instance.joinedRoomIds,
    };

getRoomIds(List<MatrixRoom> rooms) {
  return rooms.map((room) => room.id).toList();
}
