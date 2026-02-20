import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/data/matrix_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/data/matrix_room_api_service.dart';

class MatrixRoomManager {
  final _notificationService = di<NotificationService>();

  final MatrixApiService _matrixApiService;
  final String _matrixAdminId;
  final void Function(bool) _onPolicyChanges;

  MatrixRoomManager(
    this._matrixAdminId,
    this._matrixApiService,
    this._onPolicyChanges,
  );

  final _matrixRooms = ValueNotifier<List<MatrixRoom>>([]);
  ValueListenable<List<MatrixRoom>> get matrixRooms => _matrixRooms;

  void dispose() {
    _matrixRooms.dispose();
  }

  void setRooms(List<MatrixRoom> rooms) {
    _matrixRooms.value = rooms;
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
      return;
    }
    MatrixRoom namedRoom = await _matrixApiService.roomApi
        .fetchAdditionalRoomInfos(room.id);
    await addManagedRoom(namedRoom);

    return;
  }

  Future<void> addManagedRoom(MatrixRoom newRoom) async {
    final matrixRooms = [..._matrixRooms.value, newRoom];
    _matrixRooms.value = matrixRooms;
    di<MatrixPolicyManager>().applyPolicyChanges();
    // _onPolicyChanges(true);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Raum ${newRoom.name} erstellt',
    );
  }

  Future<void> removeManagedRoom(MatrixRoom room) async {
    final matrixPolicyManager = di<MatrixPolicyManager>();
    final matrixRooms = _matrixRooms.value
        .where((r) => r.id != room.id)
        .toList();

    _matrixRooms.value = matrixRooms;

    matrixPolicyManager.users.removeRoomFromUsers(room);

    matrixPolicyManager.pendingChangesHandler(true);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Raum ${room.name} von der Verwaltung entfernt.',
    );
  }

  Future<void> changeRoomPowerLevels({
    required String roomId,
    RoomAdmin? roomAdmin,
    String? removeAdminWithId,
    int? eventsDefault,
    int? reactions,
  }) async {
    if (roomAdmin != null || removeAdminWithId != null) {
      di<NotificationService>().showInformationDialog(
        'Power levels werden von der Policy geändert.',
      );
      return;
    }

    final MatrixRoom currentRoom = getRoomById(roomId);

    try {
      final MatrixRoom updatedRoom = await _matrixApiService.roomApi
          .changeRoomPowerLevels(
            roomId: roomId,
            newRoomAdmin: roomAdmin,
            adminIdToRemove: removeAdminWithId,
            eventsDefault: eventsDefault,
            reactions: reactions,
            currentRoom: currentRoom,
            matrixAdmin: _matrixAdminId,
          );

      currentRoom.eventsDefault = updatedRoom.eventsDefault;
      currentRoom.powerLevelReactions = updatedRoom.powerLevelReactions;

      _notificationService.showSnackBar(
        NotificationType.success,
        'Raum-Berechtigungen aktualisiert',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Aktualisieren der Raum-Berechtigungen',
      );
    }

    return;
  }

  Future<void> setRoomAvatar({
    required String roomId,
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    final MatrixRoom currentRoom = getRoomById(roomId);

    try {
      final MatrixRoom updatedRoom = await _matrixApiService.roomApi
          .setRoomAvatar(
            roomId: roomId,
            fileBytes: fileBytes,
            fileName: fileName,
          );

      currentRoom.avatarUrl = updatedRoom.avatarUrl;

      _notificationService.showSnackBar(
        NotificationType.success,
        'Raum-Avatar aktualisiert',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Aktualisieren des Raum-Avatars',
      );
    }
  }

  Future<String?> fetchRoomTopic({required String roomId}) async {
    try {
      return await _matrixApiService.roomApi.fetchRoomTopic(roomId);
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden des Raumthemas',
      );
      return null;
    }
  }

  Future<String?> fetchRoomCanonicalAlias({required String roomId}) async {
    try {
      return await _matrixApiService.roomApi.fetchRoomCanonicalAlias(roomId);
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden des Raum-Alias',
      );
      return null;
    }
  }

  Future<void> setRoomName({
    required String roomId,
    required String name,
  }) async {
    final MatrixRoom currentRoom = getRoomById(roomId);
    try {
      final MatrixRoom updatedRoom = await _matrixApiService.roomApi
          .setRoomName(roomId: roomId, name: name);
      currentRoom.name = updatedRoom.name;
      _notificationService.showSnackBar(
        NotificationType.success,
        'Raumname aktualisiert',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Aktualisieren des Raumnamens',
      );
    }
  }

  Future<void> setRoomTopic({
    required String roomId,
    required String topic,
  }) async {
    try {
      await _matrixApiService.roomApi.setRoomTopic(
        roomId: roomId,
        topic: topic,
      );
      _notificationService.showSnackBar(
        NotificationType.success,
        'Raumthema aktualisiert',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Aktualisieren des Raumthemas',
      );
    }
  }

  Future<void> setRoomCanonicalAlias({
    required String roomId,
    required String? alias,
  }) async {
    try {
      await _matrixApiService.roomApi.setRoomCanonicalAlias(
        roomId: roomId,
        alias: alias,
      );
      _notificationService.showSnackBar(
        NotificationType.success,
        'Raum-Alias aktualisiert',
      );
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Aktualisieren des Raum-Alias',
      );
    }
  }

  Future<void> loadRoomsFromPolicy(List<String> managedRoomIds) async {
    List<MatrixRoom> rooms = [];

    // Fetch the additional infos for the managed rooms and create them
    final List<String> roomIds = managedRoomIds.toSet().toList();

    for (String roomId in roomIds) {
      MatrixRoom namedRoom = await _matrixApiService.roomApi
          .fetchAdditionalRoomInfos(roomId);
      rooms.add(namedRoom);
    }

    // Sort the rooms by name for better overview
    rooms.sort((a, b) => a.name!.compareTo(b.name!));
    setRooms(rooms);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Räume geladen',
    );
  }
}
