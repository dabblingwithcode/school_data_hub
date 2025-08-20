import 'package:flutter/foundation.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/data/matrix_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/data/matrix_room_api_service.dart';
import 'package:watch_it/watch_it.dart';

class MatrixRoomManager extends ChangeNotifier {
  final _notificationService = di<NotificationService>();

  final MatrixApiService _matrixApiService;
  final String _matrixAdminId;
  final void Function(bool) _onPolicyChanges;

  MatrixRoomManager(
      this._matrixAdminId, this._matrixApiService, this._onPolicyChanges);

  final _matrixRooms = ValueNotifier<List<MatrixRoom>>([]);
  ValueListenable<List<MatrixRoom>> get matrixRooms => _matrixRooms;

  void setRooms(List<MatrixRoom> rooms) {
    _matrixRooms.value = rooms;
    notifyListeners();
  }

  MatrixRoom getRoomById(String roomId) {
    return _matrixRooms.value.firstWhere((element) => element.id == roomId);
  }

  Future<void> createNewRoom({
    required String name,
    required String topic,
    required String? aliasName,
    required ChatTypePreset chatTypePreset,
  }) async {
    final MatrixRoom? room = await _matrixApiService.roomApi.createMatrixRoom(
      name: name,
      topic: topic,
      aliasName: aliasName,
      chatTypePreset: chatTypePreset,
    );

    if (room == null) {
      return null;
    }
    MatrixRoom namedRoom =
        await _matrixApiService.roomApi.fetchAdditionalRoomInfos(room.id);
    await addManagedRoom(namedRoom);

    return;
  }

  Future<void> addManagedRoom(MatrixRoom newRoom) async {
    final matrixRooms = [..._matrixRooms.value, newRoom];
    _matrixRooms.value = matrixRooms;
    di<MatrixPolicyManager>().applyPolicyChanges();
    // _onPolicyChanges(true);
    notifyListeners();
    _notificationService.showSnackBar(
        NotificationType.success, 'Raum ${newRoom.name} erstellt');
  }

  Future<void> removeManagedRoom(MatrixRoom room) async {
    final matrixRooms =
        _matrixRooms.value.where((r) => r.id != room.id).toList();
    _matrixRooms.value = matrixRooms;
    di<MatrixPolicyManager>().users.removeRoomFromUsers(room);

    di<MatrixPolicyManager>().applyPolicyChanges();
    // _onPolicyChanges(true);
    notifyListeners();
    _notificationService.showSnackBar(
        NotificationType.success, 'Raum ${room.name} entfernt');
  }

  Future<void> changeRoomPowerLevels({
    required String roomId,
    RoomAdmin? roomAdmin,
    String? removeAdminWithId,
    int? eventsDefault,
    int? reactions,
  }) async {
    final currentRoom = getRoomById(roomId);
    final MatrixRoom room = await _matrixApiService.roomApi
        .changeRoomPowerLevels(
            currentRoom: currentRoom,
            roomId: roomId,
            newRoomAdmin: roomAdmin,
            adminIdToRemove: removeAdminWithId,
            eventsDefault: eventsDefault,
            reactions: reactions,
            matrixAdmin: _matrixAdminId);
    if (currentRoom.roomAdmins != null)
      currentRoom.roomAdmins = room.roomAdmins;
    if (currentRoom.eventsDefault != null)
      currentRoom.eventsDefault = room.eventsDefault;
    if (currentRoom.powerLevelReactions != null)
      currentRoom.powerLevelReactions = room.powerLevelReactions;

    _notificationService.showSnackBar(
        NotificationType.success, 'Power Levels gesetzt');
    notifyListeners();
  }

  Future<void> loadRoomsFromPolicy(List<String> managedRoomIds) async {
    List<MatrixRoom> rooms = [];

    // Fetch the additional infos for the managed rooms and create them
    final List<String> roomIds = managedRoomIds.toSet().toList();

    for (String roomId in roomIds) {
      MatrixRoom namedRoom =
          await _matrixApiService.roomApi.fetchAdditionalRoomInfos(roomId);
      rooms.add(namedRoom);
    }

    // Sort the rooms by name for better overview
    rooms.sort((a, b) => a.name!.compareTo(b.name!));
    setRooms(rooms);

    _notificationService.showSnackBar(
        NotificationType.success, 'Räume geladen');
  }
}
