import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_room_helpers.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:watch_it/watch_it.dart';

part 'matrix_user.g.dart';

//- After running build_runner, in matrix_user.g.dart you must do these modifications:
//- 1. in _$MatrixUserImpl ->  matrixRooms: (json['joinedRoomIds'] as List<dynamic>).map((e) => MatrixRoom(id: e)).toList(),
//- 2. in _$$MatrixUserImplToJson -> 'joinedRoomIds': getRoomIds(instance.matrixRooms!),
//- 3. add this funtion getRoomIds(List<MatrixRoom> rooms) {return rooms.map((room) => room.id).toList();}
//- 4. in _$MatrixUserImpl ->  comment out // 'authCredential': instance.authCredential,

final _matrixPolicyManager = di<MatrixPolicyManager>();

@JsonSerializable()
class MatrixUser extends ChangeNotifier {
  final String? _id;
  final bool? _active;
  final String? _authType;
  String _displayName;
  List<String> _joinedRoomIds;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MatrixRoom> _matrixRooms = [];

  MatrixUser({
    String? id,
    bool? active,
    String? authType,
    required String displayName,
    required List<String> joinedRoomIds,
  })  : _id = id,
        _active = active,
        _authType = authType,
        _displayName = displayName,
        _joinedRoomIds = joinedRoomIds {
    if (_joinedRoomIds.isNotEmpty) {
      _joinedRoomIds = _joinedRoomIds.toSet().toList();
      for (var roomId in _joinedRoomIds) {
        _matrixRooms.add(MatrixRoom(id: roomId));
      }
    }
  }

  // Getters
  String? get id => _id;
  bool? get active => _active;
  String? get authType => _authType;
  String get displayName => _displayName;
  List<String> get joinedRoomIds => _joinedRoomIds;
  List<MatrixRoom> get matrixRooms => _matrixRooms;
  bool get isParent => _id!.contains('_e') ? true : false;

  // Setters
  set displayName(String value) {
    if (_displayName != value) {
      _displayName = value;
      notifyListeners();
    }
  }

  void joinRooms(List<String> roomIds) {
    _matrixRooms.addAll(MatrixRoomHelper.roomsFromRoomIds(roomIds));

    _joinedRoomIds.addAll(roomIds);
    _matrixPolicyManager.pendingChangesHandler(true);
    notifyListeners();
  }

  void joinRoom(MatrixRoom room) {
    _matrixRooms.add(room);
    _joinedRoomIds.add(room.id);
    _matrixPolicyManager.pendingChangesHandler(true);
    notifyListeners();
  }

  void leaveRoom(MatrixRoom room) {
    final roomIndex =
        _matrixRooms.indexWhere((element) => element.id == room.id);
    if (roomIndex == -1) return;
    _matrixRooms.removeAt(roomIndex);

    _joinedRoomIds.remove(room.id);
    _matrixPolicyManager.pendingChangesHandler(true);
    notifyListeners();
  }

  set joinedRoomIds(List<String> value) {
    _joinedRoomIds = value.toSet().toList();
    _matrixRooms = _joinedRoomIds.map((id) => MatrixRoom(id: id)).toList();
    notifyListeners();
  }

  factory MatrixUser.fromJson(Map<String, dynamic> json) =>
      _$MatrixUserFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixUserToJson(this);
}
