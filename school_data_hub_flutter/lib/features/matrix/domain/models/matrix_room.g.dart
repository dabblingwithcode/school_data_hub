// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatrixRoom _$MatrixRoomFromJson(Map<String, dynamic> json) => MatrixRoom(
      id: json['id'] as String,
      name: json['name'] as String?,
      powerLevelReactions: (json['powerLevelReactions'] as num?)?.toInt(),
      eventsDefault: (json['eventsDefault'] as num?)?.toInt(),
      roomAdmins: (json['roomAdmins'] as List<dynamic>?)
          ?.map((e) => RoomAdmin.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatrixRoomToJson(MatrixRoom instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'powerLevelReactions': instance.powerLevelReactions,
      'eventsDefault': instance.eventsDefault,
      'roomAdmins': instance.roomAdmins,
    };

RoomAdmin _$RoomAdminFromJson(Map<String, dynamic> json) => RoomAdmin(
      id: json['id'] as String,
      powerLevel: (json['powerLevel'] as num).toInt(),
    );

Map<String, dynamic> _$RoomAdminToJson(RoomAdmin instance) => <String, dynamic>{
      'id': instance.id,
      'powerLevel': instance.powerLevel,
    };
