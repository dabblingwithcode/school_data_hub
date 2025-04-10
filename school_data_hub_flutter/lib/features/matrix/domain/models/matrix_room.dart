import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matrix_room.g.dart';

enum RoomMembers { pupils, parents, teachers, workers, ogs }

@JsonSerializable()
class MatrixRoom extends ChangeNotifier {
  final String id;
  String? _name;
  int? _powerLevelReactions;
  int? _eventsDefault;
  List<RoomAdmin>? _roomAdmins;

  MatrixRoom({
    required this.id,
    String? name,
    int? powerLevelReactions,
    int? eventsDefault,
    List<RoomAdmin>? roomAdmins,
  })  : _name = name,
        _powerLevelReactions = powerLevelReactions,
        _eventsDefault = eventsDefault,
        _roomAdmins = roomAdmins;

  // Getters
  String? get name => _name;
  int? get powerLevelReactions => _powerLevelReactions;
  int? get eventsDefault => _eventsDefault;
  List<RoomAdmin>? get roomAdmins => _roomAdmins;

  // Setters
  set name(String? value) {
    if (_name != value) {
      _name = value;
      notifyListeners();
    }
  }

  set powerLevelReactions(int? value) {
    if (_powerLevelReactions != value) {
      _powerLevelReactions = value;
      notifyListeners();
    }
  }

  set eventsDefault(int? value) {
    if (_eventsDefault != value) {
      _eventsDefault = value;
      notifyListeners();
    }
  }

  set roomAdmins(List<RoomAdmin>? value) {
    if (_roomAdmins != value) {
      _roomAdmins = value;
      notifyListeners();
    }
  }

  factory MatrixRoom.fromJson(Map<String, dynamic> json) =>
      _$MatrixRoomFromJson(json);

  Map<String, dynamic> toJson() => _$MatrixRoomToJson(this);
}

@JsonSerializable()
class RoomAdmin {
  final String id;
  final int powerLevel;

  RoomAdmin({required this.id, required this.powerLevel});

  factory RoomAdmin.fromJson(Map<String, dynamic> json) =>
      _$RoomAdminFromJson(json);

  Map<String, dynamic> toJson() => _$RoomAdminToJson(this);
}
