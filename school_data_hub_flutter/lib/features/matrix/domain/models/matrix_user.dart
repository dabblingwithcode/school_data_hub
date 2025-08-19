import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_room_helpers.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:watch_it/watch_it.dart';

part 'matrix_user.g.dart';

final _matrixPolicyManager = di<MatrixPolicyManager>();

@JsonSerializable()
class JoinedRoom {
  final String roomId;
  final int powerLevel;

  JoinedRoom({
    required this.roomId,
    required this.powerLevel,
  });

  factory JoinedRoom.fromJson(Map<String, dynamic> json) =>
      _$JoinedRoomFromJson(json);
  Map<String, dynamic> toJson() => _$JoinedRoomToJson(this);
}

@JsonSerializable()
class MatrixUser extends ChangeNotifier {
  final String _id;
  bool? _active;
  String? _authType;
  String? _authCredential;
  String _displayName;
  List<JoinedRoom> _joinedRooms;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MatrixRoom> _matrixRooms = [];

  MatrixUser({
    required String id,
    bool? active,
    String? authType,
    String? authCredential,
    required String displayName,
    required List<JoinedRoom> joinedRooms,
  })  : _id = id,
        _active = active,
        _authType = authType,
        _authCredential = authCredential,
        _displayName = displayName,
        _joinedRooms = joinedRooms {
    if (_joinedRooms.isNotEmpty) {
      for (var room in _joinedRooms) {
        if (_matrixRooms.any((x) => x.id == room.roomId)) continue;
        _matrixRooms.add(MatrixRoom(id: room.roomId));
      }
    }
  }

  // Getters
  String? get id => _id;
  bool? get active => _active;
  String? get authType => _authType;
  String? get authCredential => _authCredential;
  String get displayName => _displayName;
  List<JoinedRoom> get joinedRooms => _joinedRooms;
  List<MatrixRoom> get matrixRooms => _matrixRooms;
  bool get isParent => _id.contains('_e') ? true : false;

  // Setters
  set displayName(String value) {
    if (_displayName != value) {
      _displayName = value;
      notifyListeners();
    }
  }

  void joinRooms(List<JoinedRoom> roomIds) {
    _matrixRooms.addAll(MatrixRoomHelper.roomsFromRoomJoinedRooms(roomIds));

    _joinedRooms.addAll(roomIds);
    _matrixPolicyManager.pendingChangesHandler(true);
    notifyListeners();
  }

  void joinRoom(MatrixRoom room) {
    _matrixRooms.add(room);
    _joinedRooms.add(JoinedRoom(
      roomId: room.id,
      powerLevel: 0,
    ));
    _matrixPolicyManager.pendingChangesHandler(true);
    notifyListeners();
  }

  void leaveRoom(MatrixRoom room) {
    final roomIndex =
        _matrixRooms.indexWhere((element) => element.id == room.id);
    if (roomIndex == -1) return;
    _matrixRooms.removeAt(roomIndex);

    _joinedRooms.remove(room.id);
    _matrixPolicyManager.pendingChangesHandler(true);
    notifyListeners();
  }

  factory MatrixUser.fromJson(Map<String, dynamic> json) =>
      _$MatrixUserFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixUserToJson(this);
}
