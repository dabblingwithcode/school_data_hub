// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

import 'flags.dart';
import 'matrix_user.dart';

//- After running build_runner, in policy.g.dart you must do these modifications:
//- 1. in _$$PolicyImplFromJson ->  matrixRooms: (json['managedRoomIds'] as List<dynamic>).map((e) => MatrixRoom(id: e)).toList(),
//- 2. in _$$PolicyImplToJson -> 'managedRoomIds': getRoomIds(instance.matrixRooms!),
//- 3. add this funtion getRoomIds(List<MatrixRoom> rooms) {return rooms.map((room) => room.id).toList();}
part 'policy.g.dart';

@JsonSerializable()
class Policy {
  final int schemaVersion;
  final dynamic identificationStamp;
  final Flags flags;
  final dynamic hooks;
  final List<String> managedRoomIds;
  @JsonKey(name: 'users')
  final List<MatrixUser>? matrixUsers;

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyToJson(this);

  copyWith(
          {int? schemaVersion,
          dynamic identificationStamp,
          Flags? flags,
          dynamic hooks,
          List<String>? managedRoomIds,
          List<MatrixUser>? matrixUsers}) =>
      Policy(
          schemaVersion: schemaVersion ?? this.schemaVersion,
          identificationStamp: identificationStamp ?? this.identificationStamp,
          flags: flags ?? this.flags,
          hooks: hooks ?? this.hooks,
          managedRoomIds: managedRoomIds ?? this.managedRoomIds,
          matrixUsers: matrixUsers ?? this.matrixUsers);
  Policy(
      {required this.schemaVersion,
      required this.identificationStamp,
      required this.flags,
      required this.hooks,
      required this.matrixUsers,
      required this.managedRoomIds});
}
