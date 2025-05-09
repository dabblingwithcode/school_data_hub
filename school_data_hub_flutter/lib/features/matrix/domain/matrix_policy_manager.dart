import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/data/matrix_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper_functions.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/policy.dart';
import 'package:school_data_hub_flutter/features/matrix/services/matrix_credentials_pdf_generator.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();
final _envManager = di<EnvManager>();
final _sessionManager = di<ServerpodSessionManager>();
final _secureStorage = ServerpodSecureStorage();

final _log = Logger('MatrixPolicyManager');

class MatrixPolicyManager extends ChangeNotifier {
  MatrixPolicyManager(this._matrixUrl, this._corporalToken, this._matrixToken,
      this._compulsoryRooms)
      : _matrixApiService = MatrixApiService(
            matrixUrl: _matrixUrl,
            corporalToken: _corporalToken,
            matrixToken: _matrixToken);

  final _secureStorageKey = _envManager.storageKeyForMatrixCredentials;

  late final String _matrixUrl;
  String get matrixUrl => _matrixUrl;

  String? _matrixAdminId;
  String? get matrixAdmin => _matrixAdminId;

  String _matrixToken;
  String get matrixToken => 'Bearer $_matrixToken';

  String _corporalToken;
  String get corporalToken => 'Bearer $_corporalToken';

  List<String> _compulsoryRooms;
  List<String> get compulsoryRooms => _compulsoryRooms;

  Policy? _matrixPolicy;
  Policy? get matrixPolicy => _matrixPolicy;

  bool get isMatrixPolicyLoaded => _matrixPolicy != null;

  final _matrixUsers = ValueNotifier<List<MatrixUser>>([]);
  ValueListenable<List<MatrixUser>> get matrixUsers => _matrixUsers;

  final _matrixRooms = ValueNotifier<List<MatrixRoom>>([]);
  ValueListenable<List<MatrixRoom>> get matrixRooms => _matrixRooms;

  // TODO: improve lookups with maps

  final _policyPendingChanges = ValueNotifier<bool>(false);
  ValueListenable<bool> get pendingChanges => _policyPendingChanges;

  late final MatrixApiService _matrixApiService;

  Future<MatrixPolicyManager> init() async {
    if (_sessionManager.isAdmin == true) {
      _notificationService.showSnackBar(
          NotificationType.success, 'Matrix-Räumeverwaltung wird geladen...');

      await fetchMatrixPolicy();
    }
    return this;
  }

  void pendingChangesHandler(bool newValue) {
    if (newValue == _policyPendingChanges.value) return;
    _policyPendingChanges.value = newValue;
  }

  MatrixUser getUserById(String userId) {
    return _matrixUsers.value.firstWhere((element) => element.id == userId);
  }

  void setMatrixEnvironmentValues(
      {required String url,
      required String policyToken,
      required String matrixToken,
      required List<String> compulsoryRooms}) async {
    _matrixUrl = url;
    _corporalToken = policyToken;
    _matrixToken = matrixToken;
    _compulsoryRooms.addAll(compulsoryRooms);

    _secureStorage.setString(
        _secureStorageKey,
        jsonEncode(MatrixCredentials(
            url: url,
            matrixToken: matrixToken,
            policyToken: policyToken,
            compulsoryRooms: [..._compulsoryRooms]).toJson()));

    await fetchMatrixPolicy();
  }

  Future<void> deleteAndDeregisterMatrixPolicyManager() async {
    await _secureStorage.remove(_secureStorageKey);
    di.unregister<MatrixPolicyFilterManager>();
    di.unregister<MatrixPolicyManager>();

    _sessionManager.changeMatrixPolicyManagerRegistrationStatus(false);
    _notificationService.showSnackBar(
        NotificationType.success, 'Matrix-Räumeverwaltung deaktiviert');
  }

  //- MATRIX POLICY

  Future<void> fetchMatrixPolicy() async {
    final Policy? policy = await _matrixApiService.fetchMatrixPolicy();
    if (policy == null) {
      _log.severe('Error fetching Matrix policy!');
      return;
    }

    _matrixPolicy = policy;

    // we get the users from the policy and sort them by name
    final matrixUsers = policy.matrixUsers!;

    matrixUsers.sort((a, b) => a.displayName.compareTo(b.displayName));

    _matrixUsers.value = matrixUsers;
    notifyListeners();

    _notificationService.showSnackBar(
        NotificationType.success, 'Matrix-Konten geladen! Jetzt die Räume...');

    List<MatrixRoom> rooms = [];

    // now we fetch the additional infos for the managed rooms and create them

    final List<String> roomIds = policy.managedRoomIds.toSet().toList();

    for (String roomId in roomIds) {
      MatrixRoom namedRoom =
          await _matrixApiService.fetchAdditionalRoomInfos(roomId);
      rooms.add(namedRoom);
    }

    // we sort the rooms by name for better overview
    rooms.sort((a, b) => a.name!.compareTo(b.name!));
    _matrixRooms.value = rooms;

    _notificationService.showSnackBar(
        NotificationType.success, 'Räume geladen');

    _log.info('Fetched Matrix policy!');

    _policyPendingChanges.value = false;

    _sessionManager.changeMatrixPolicyManagerRegistrationStatus(true);

    return;
  }

  Future<void> applyPolicyChanges() async {
    final updatedPolicy = MatrixPolicyHelper.refreshMatrixPolicy();
    _matrixPolicy = updatedPolicy;
    await _matrixApiService.putMatrixPolicy();
    _policyPendingChanges.value = false;
  }

  MatrixRoom getRoomById(String roomId) {
    return _matrixRooms.value.firstWhere((element) => element.id == roomId);
  }

  //- ROOM REPOSITORY

  Future<void> createNewRoom(
      {required String name,
      required String topic,
      required String? aliasName,
      required ChatTypePreset chatTypePreset}) async {
    final MatrixRoom? room = await _matrixApiService.createMatrixRoom(
        name: name,
        topic: topic,
        aliasName: aliasName,
        chatTypePreset: chatTypePreset);
    if (room == null) {
      return;
    }
    addManagedRoom(room);
    _notificationService.showSnackBar(
        NotificationType.success, 'Raum ${room.name} erstellt');
  }

  void addManagedRoom(MatrixRoom newRoom) {
    final matrixRooms = [..._matrixRooms.value];
    matrixRooms.add(newRoom);
    _matrixRooms.value = matrixRooms;
    // _matrixRooms.add(newRoom);

    final admin = _matrixUsers.value
        .firstWhere((element) => element.id == _matrixAdminId);

    admin.joinRoom(newRoom);

    _policyPendingChanges.value = true;
  }

  Future<void> changeRoomPowerLevels(
      {required String roomId,
      RoomAdmin? roomAdmin,
      String? removeAdminWithId,
      int? eventsDefault,
      int? reactions}) async {
    final MatrixRoom room = await _matrixApiService.changeRoomPowerLevels(
        roomId: roomId,
        newRoomAdmin: roomAdmin,
        removeAdminWithId: removeAdminWithId,
        eventsDefault: eventsDefault,
        reactions: reactions);

    _matrixRooms.value = {..._matrixRooms.value, room}.toList();
    _notificationService.showSnackBar(
        NotificationType.success, 'Power Levels gesetzt');
  }

  //- USER REPOSITORY

  /// This function:
  ///
  /// **1.** generates a password for the new user
  ///
  /// **2.** creates a new user on the matrix server
  ///
  /// **3.** If successful, the user is added to the policy.
  ///
  /// **4.** Then the policy is updated.
  ///
  /// **5.** `printMatrixCredentials` is called - a pdf file with the credentials is generated and returned.
  Future<File?> createNewMatrixUser(
      {required String matrixId,
      required String displayName,
      required bool isStaff}) async {
    final password = MatrixPolicyHelper.generatePassword();

    final MatrixUser? newUser = await _matrixApiService.createNewMatrixUser(
      matrixId: matrixId,
      displayName: displayName,
      password: password,
    );
    if (newUser == null) {
      return null;
    }
    // TODO: revert these changes for debugging
    // final MatrixUser newUser = MatrixUser(
    //     id: matrixId,
    //     displayName: displayName,
    //     authType: 'passThrough',
    //     joinedRoomIds: [],
    //     active: true);

    final matrixUsers = [..._matrixUsers.value, newUser];

    _matrixUsers.value = matrixUsers;

    await applyPolicyChanges();

    final file = await MatrixCredentialsPrinter.printMatrixCredentials(
        matrixDomain: _matrixUrl,
        matrixUser: newUser,
        password: password,
        isStaff: isStaff);

    _policyPendingChanges.value = true;
    return file;
  }

  /// This function:
  ///
  /// 1. deletes the user from the matrix server.
  /// 2. If successful, the user is removed from the policy.
  /// 3. Then the policy is updated.
  Future<void> deleteUser({required String userId}) async {
    _notificationService.setHeavyLoadingValue(true);

    final bool success = await _matrixApiService.deleteMatrixUser(userId);

    _notificationService.setHeavyLoadingValue(false);

    if (!success) {
      _notificationService
          .showInformationDialog('Fehler beim Löschen vom Konto!');
      return;
    }
    _notificationService.showSnackBar(NotificationType.success,
        'Benutzer gelöscht - die Moderation der Räume wird aktualisiert...');
    List<MatrixUser> matrixUsers = List.from(_matrixUsers.value);
    matrixUsers.removeWhere((user) => user.id == userId);
    _matrixUsers.value = matrixUsers;

    // TODO funktioniert nicht
    await applyPolicyChanges();

    _notificationService.showSnackBar(
        NotificationType.success, 'Benutzer gelöscht');
  }

  Future<File?> resetPassword(
      {required MatrixUser user,
      bool? logoutDevices,
      required bool isStaff}) async {
    final password = MatrixPolicyHelper.generatePassword();
    debugPrint('Generated password: $password');
    final bool success = await _matrixApiService.resetPassword(
        userId: user.id!, newPassword: password, logoutDevices: logoutDevices);
    if (!success) {
      _notificationService
          .showInformationDialog('Fehler beim Zurücksetzen des Passworts!');
      return null;
    }
    final file = await MatrixCredentialsPrinter.printMatrixCredentials(
        matrixDomain: _matrixUrl,
        matrixUser: user,
        password: password,
        isStaff: isStaff);
    _notificationService.showSnackBar(
        NotificationType.success, 'Passwort zurückgesetzt');
    return file;
  }

  void addMatrixUserToRooms(String matrixUserId, List<String> roomIds) {
    final user =
        _matrixUsers.value.firstWhere((element) => element.id == matrixUserId);
    for (String roomId in roomIds) {
      user.joinRoom(MatrixRoom(id: roomId));
      final updatedUsers = _matrixUsers.value
          .map((e) => e.id == matrixUserId ? user : e)
          .toList();
      _matrixUsers.value = updatedUsers;
    }
    _policyPendingChanges.value = true;
  }
}
