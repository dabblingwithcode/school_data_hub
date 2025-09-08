import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/matrix/data/matrix_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/services/matrix_credentials_pdf_generator.dart';
import 'package:watch_it/watch_it.dart';

class MatrixUserManager extends ChangeNotifier {
  final _log = Logger('MatrixUserManager');
  final _notificationService = di<NotificationService>();

  final MatrixApiService _matrixApiService;
  final void Function(bool) _onPolicyChanges;
  final String _matrixUrl;
  final Function _applyPolicyChanges;

  MatrixUserManager(
    this._matrixApiService,
    this._onPolicyChanges,
    this._matrixUrl,
    this._applyPolicyChanges,
  );

  final _matrixUsers = ValueNotifier<List<MatrixUser>>([]);
  ValueListenable<List<MatrixUser>> get matrixUsers => _matrixUsers;

  void setUsers(List<MatrixUser> users) {
    _matrixUsers.value = users;
    notifyListeners();
  }

  MatrixUser getUserById(String userId) {
    return _matrixUsers.value.firstWhere((element) => element.id == userId);
  }

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
  Future<File?> createNewMatrixUser({
    required String matrixId,
    required String displayName,
    required bool isStaff,
  }) async {
    final password = MatrixPolicyHelper.generatePassword();

    final MatrixUser? newUser = await _matrixApiService.userApi
        .createNewMatrixUser(
          matrixId: matrixId,
          displayName: displayName,
          password: password,
        );

    if (newUser == null) {
      return null;
    }

    final matrixUsers = [..._matrixUsers.value, newUser];
    _matrixUsers.value = matrixUsers;

    await _applyPolicyChanges();

    final file = await MatrixCredentialsPrinter.printMatrixCredentials(
      matrixDomain: _matrixUrl,
      matrixUser: newUser,
      password: password,
      isStaff: isStaff,
    );

    _onPolicyChanges(true);
    notifyListeners();
    return file;
  }

  /// This function:
  ///
  /// 1. deletes the user from the matrix server.
  /// 2. If successful, the user is removed from the policy.
  /// 3. Then the policy is updated.
  Future<void> deleteUser({required String userId}) async {
    _notificationService.setHeavyLoadingValue(true);
    bool success = false;
    try {
      success = await _matrixApiService.userApi.deleteMatrixUser(userId);
    } catch (e) {
      _notificationService.showInformationDialog(
        'Fehler beim Löschen vom Konto: $e',
      );
    }

    _notificationService.setHeavyLoadingValue(false);

    if (!success) {
      _notificationService.showInformationDialog(
        'Fehler beim Löschen vom Konto!',
      );
      return;
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Benutzer gelöscht - die Moderation der Räume wird aktualisiert...',
    );

    List<MatrixUser> matrixUsers = List.from(_matrixUsers.value);
    matrixUsers.removeWhere((user) => user.id == userId);
    _matrixUsers.value = matrixUsers;

    await _applyPolicyChanges();

    _notificationService.showSnackBar(
      NotificationType.success,
      'Benutzer gelöscht',
    );
    notifyListeners();
  }

  Future<String?> resetPassword(MatrixUser user) async {
    final password = MatrixPolicyHelper.generatePassword();
    try {
      final bool success = await _matrixApiService.userApi.resetPassword(
        userId: user.id!,
        newPassword: password,
      );
      if (!success) {
        return null;
      }
      return password;
    } catch (e) {
      _log.severe('Error resetting password for user ${user.displayName}: $e');
      return null;
    }
  }

  Future<File?> resetPasswordAndPrintCredentialsFile({
    required MatrixUser user,
    bool? logoutDevices,
    required bool isStaff,
  }) async {
    final password = MatrixPolicyHelper.generatePassword();
    debugPrint('Generated password: $password');

    final bool success = await _matrixApiService.userApi.resetPassword(
      userId: user.id!,
      newPassword: password,
      logoutDevices: logoutDevices,
    );

    if (!success) {
      _notificationService.showInformationDialog(
        'Fehler beim Zurücksetzen des Passworts!',
      );
      return null;
    }

    final file = await MatrixCredentialsPrinter.printMatrixCredentials(
      matrixDomain: _matrixUrl,
      matrixUser: user,
      password: password,
      isStaff: isStaff,
    );

    _notificationService.showSnackBar(
      NotificationType.success,
      'Passwort zurückgesetzt',
    );

    return file;
  }

  void addMatrixUserToRooms(String matrixUserId, List<String> roomIds) {
    final user = _matrixUsers.value.firstWhere(
      (element) => element.id == matrixUserId,
    );

    for (String roomId in roomIds) {
      user.joinRoom(MatrixRoom(id: roomId));
      final updatedUsers =
          _matrixUsers.value
              .map((e) => e.id == matrixUserId ? user : e)
              .toList();
      _matrixUsers.value = updatedUsers;
    }

    _onPolicyChanges(true);
    notifyListeners();
  }

  void removeRoomFromUsers(MatrixRoom room) {
    for (var user in _matrixUsers.value) {
      user.leaveRoom(room);
    }

    // Update the users list
    _matrixUsers.value = List.from(_matrixUsers.value);

    // Notify listeners about the change
    notifyListeners();
  }
}
