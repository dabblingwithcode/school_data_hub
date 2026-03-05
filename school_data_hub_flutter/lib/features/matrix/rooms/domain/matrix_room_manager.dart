import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/data/matrix_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/data/compulsory_room_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/data/matrix_room_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class MatrixRoomManager {
  final _notificationService = di<NotificationService>();

  final MatrixApiService _matrixApiService;
  final String _matrixAdminId;

  MatrixRoomManager(this._matrixAdminId, this._matrixApiService);

  final _matrixRooms = ValueNotifier<List<MatrixRoom>>([]);
  ValueListenable<List<MatrixRoom>> get matrixRooms => _matrixRooms;

  final _compulsoryRooms = ValueNotifier<List<CompulsoryRoom>>([]);
  ValueListenable<List<CompulsoryRoom>> get compulsoryRooms => _compulsoryRooms;

  CompulsoryRoom? getCompulsoryRoomFor(String roomId) {
    for (final c in _compulsoryRooms.value) {
      if (c.roomId == roomId) return c;
    }
    return null;
  }

  void dispose() {
    _matrixRooms.dispose();
    _compulsoryRooms.dispose();
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
    MatrixRoomType? markAsCompulsoryWithType,
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

    if (markAsCompulsoryWithType != null) {
      final current = List<CompulsoryRoom>.from(_compulsoryRooms.value);
      final newEntry = CompulsoryRoom(
        roomId: namedRoom.id,
        roomType: markAsCompulsoryWithType,
      );
      final updated = [...current, newEntry];
      final result = await CompulsoryRoomApiService.instance.setCompulsoryRooms(
        updated,
      );
      if (result != null) {
        _compulsoryRooms.value = result;
      }
    }

    return;
  }

  /// Creates two rooms per group from [PupilIdentityManager.groups]: one for
  /// children (groupChildren) and one for parents (groupParents) with "(E)" suffix.
  /// Uses [SchoolCalendarManager.currentSemester].schoolYear in the room names.
  Future<void> createGroupRoomsForCurrentSemester() async {
    final semester = di<SchoolCalendarManager>().currentSemester.value;
    if (semester == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kein aktuelles Schulhalbjahr gesetzt. Bitte zuerst Schulkalender laden.',
      );
      return;
    }
    final schoolYear = semester.schoolYear;
    final groupSet = di<PupilIdentityManager>().groups.value;
    final groups = groupSet.toList()..sort();

    for (final group in groups) {
      final nameChildren = '$group $schoolYear';
      await createNewRoom(
        name: nameChildren,
        topic: nameChildren,
        aliasName: null,
        chatTypePreset: ChatTypePreset.private,
        markAsCompulsoryWithType: MatrixRoomType.groupChildren,
      );
      final nameParents = '$group $schoolYear (E)';
      await createNewRoom(
        name: nameParents,
        topic: nameParents,
        aliasName: null,
        chatTypePreset: ChatTypePreset.private,
        markAsCompulsoryWithType: MatrixRoomType.groupParents,
      );
    }
  }

  Future<void> addManagedRoom(MatrixRoom newRoom, {String? successMessage}) {
    final matrixRooms = [..._matrixRooms.value, newRoom];
    _matrixRooms.value = matrixRooms;
    di<MatrixPolicyManager>().applyPolicyChanges();
    // _onPolicyChanges(true);
    _notificationService.showSnackBar(
      NotificationType.success,
      successMessage ?? 'Raum ${newRoom.name} erstellt',
    );
    return Future.value();
  }

  Future<void> addExistingRoomById(String roomId) async {
    final trimmed = roomId.trim();
    if (trimmed.isEmpty) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Bitte geben Sie eine Matrix-Raum-ID ein',
      );
      return;
    }
    if (_matrixRooms.value.any((r) => r.id == trimmed)) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Raum ist bereits in der Policy',
      );
      return;
    }
    final room = await _matrixApiService.roomApi.fetchAdditionalRoomInfos(trimmed);
    await addManagedRoom(
      room,
      successMessage: 'Raum ${room.name ?? room.id} zur Policy hinzugefügt',
    );
  }

  Future<void> removeManagedRoom(MatrixRoom room, {bool? purgeRoom}) async {
    final matrixPolicyManager = di<MatrixPolicyManager>();
    final matrixRooms = _matrixRooms.value
        .where((r) => r.id != room.id)
        .toList();

    _matrixRooms.value = matrixRooms;

    matrixPolicyManager.users.removeRoomFromUsers(room);

    matrixPolicyManager.pendingChangesHandler(true);

    if (purgeRoom == true) {
      await _matrixApiService.roomApi.purgeRoom(roomId: room.id);
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Raum ${room.name} von der Verwaltung entfernt.',
    );
  }

  Future<void> changeRoomPowerLevels({
    required String roomId,

    int? eventsDefault,
    int? reactions,
  }) async {
    final MatrixRoom currentRoom = getRoomById(roomId);

    try {
      final MatrixRoom updatedRoom = await _matrixApiService.roomApi
          .changeRoomPowerLevels(
            roomId: roomId,

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

    final compulsory = await CompulsoryRoomApiService.instance
        .getCompulsoryRooms();
    _compulsoryRooms.value = compulsory ?? [];

    _notificationService.showSnackBar(
      NotificationType.success,
      'Räume geladen',
    );
  }
}
