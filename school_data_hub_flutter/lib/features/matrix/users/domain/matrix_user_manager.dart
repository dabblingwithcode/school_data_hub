import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/data/matrix_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/pdf_service/matrix_bulk_new_credentials_service.dart';
import 'package:school_data_hub_flutter/features/matrix/users/pdf_service/matrix_credentials_pdf_generator.dart';

class MatrixUserManager {
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

  void dispose() {
    _matrixUsers.dispose();
  }

  void setUsers(List<MatrixUser> users) {
    _matrixUsers.value = users;
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
  /// **3.** If successful, the user is added to the in-memory list.
  ///
  /// **4.** `printMatrixCredentials` is called - a pdf file with the credentials is generated and returned.
  ///
  /// Policy is applied by [postNewMatrixUser] once after adding the user to rooms.
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

    _notificationService.showSnackBar(
      NotificationType.success,
      'Benutzer erstellt oder reaktiviert',
    );

    final file = await MatrixCredentialsPrinter.printMatrixCredentials(
      matrixDomain: _matrixUrl,
      matrixUser: newUser,
      password: password,
      isStaff: isStaff,
    );

    _onPolicyChanges(true);
    return file;
  }

  Future<File?> postNewMatrixUser({
    required PupilProxy? pupil,
    required String generatedMatrixId,
    required String displayName,
    required List<String> roomIds,
  }) async {
    final String domainPart =
        di<MatrixPolicyManager>().userServerAddress ??
        di<MatrixPolicyManager>().matrixUrl.replaceAll('https://', '');
    String matrixId = '@$generatedMatrixId:$domainPart';

    List<String> roomIdsList = roomIds.toList();
    final isStaff = !matrixId.contains('_');
    final isParent = matrixId.contains('_e');

    // we are getting the credentials pdf file back if the user was created successfully
    // the password is generated in the createNewMatrixUser method
    final file = await createNewMatrixUser(
      matrixId: matrixId,
      displayName: displayName,
      isStaff: isStaff,
    );

    // if it is a pupil related matrix account
    if (file != null && pupil != null) {
      if (!isParent && !isStaff) {
        // it's a pupil related matrix account
        await PupilMutator().updateStringProperty(
          pupilId: pupil.pupilId,
          property: PupilStringProperty.contact,
          propertyValue: (value: matrixId),
        );
      } else {
        // it's a parent related matrix account
        await PupilMutator().updateParentsContact(pupil, (value: matrixId));
      }
    }

    addMatrixUserToRooms(matrixId, roomIdsList);

    await di<MatrixPolicyManager>().applyPolicyChanges();

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
    _log.info('Generated password: $password');

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
      final updatedUsers = _matrixUsers.value
          .map((e) => e.id == matrixUserId ? user : e)
          .toList();
      _matrixUsers.value = updatedUsers;
    }

    _onPolicyChanges(true);
  }

  void removeRoomFromUsers(MatrixRoom room) {
    for (var user in _matrixUsers.value) {
      user.leaveRoom(room);
    }

    // Update the users list
    _matrixUsers.value = List.from(_matrixUsers.value);

    // Notify listeners about the change
  }

  Future<String?> fetchUserAvatarUrl(String userId) {
    return _matrixApiService.userApi.fetchUserAvatarUrl(userId);
  }

  /// Returns managed room IDs the user should be in based on compulsory room
  /// types and, for group rooms, whether the room name matches.
  /// When [familyCode] is set, group rooms match if the room name contains any
  /// of that family's groups; otherwise [group] is used.
  /// For pupil: globalChildrem, contacts, and groupChildren.
  /// For parent: those plus globalParents and groupParents.
  List<String> roomIdsForPupilOrParent({
    String? familyCode,
    required MatrixRoomManager roomManager,
    required String group,
    required bool isParent,
  }) {
    final roomIds = <String>[];
    final List<String> familyGroups = familyCode != null
        ? PupilIdentityHelper.getFamilyGroups(familyCode)
        : [];
    final rooms = roomManager.matrixRooms.value;

    for (final room in rooms) {
      final compulsory = roomManager.getCompulsoryRoomFor(room.id);
      if (compulsory == null) continue;
      final roomName = room.name ?? '';
      switch (compulsory.roomType) {
        case MatrixRoomType.contacts:
        case MatrixRoomType.globalChildrem:
          roomIds.add(room.id);
          break;
        case MatrixRoomType.groupChildren:
          if (familyGroups.isNotEmpty
              ? familyGroups.any((g) => roomName.contains(g))
              : roomName.contains(group)) {
            roomIds.add(room.id);
          }
          break;
        case MatrixRoomType.globalParents:
          if (isParent) roomIds.add(room.id);
          break;
        case MatrixRoomType.groupParents:
          if (isParent &&
              (familyGroups.isNotEmpty
                  ? familyGroups.any((g) => roomName.contains(g))
                  : roomName.contains(group))) {
            roomIds.add(room.id);
          }
          break;
        default:
          break;
      }
    }
    return roomIds;
  }

  /// Creates Matrix accounts for pupils with no contact info and returns a
  /// bulk PDF of the new credentials. Caller should open the file (e.g. with
  /// [PdfViewerPage]) when non-null.
  Future<File?> createMatrixCredentialsForPupilsWithoutContactInfo() async {
    _notificationService.setHeavyLoadingValue(true);
    try {
      final List<PupilProxy> pupils = di<PupilProxyManager>().allPupils;
      final List<Map<String, dynamic>> userCredentials = [];

      for (PupilProxy pupil in pupils) {
        if (pupil.contact == null) {
          final displayName =
              '${pupil.firstName} ${pupil.lastName.substring(0, 1).toUpperCase()}. (${pupil.group})';
          final generatedMatrixId = MatrixPolicyHelper.generateMatrixId(
            isParent: false,
          );
          final password = MatrixPolicyHelper.generatePassword();

          final String domainPart =
              di<MatrixPolicyManager>().userServerAddress ??
              di<MatrixPolicyManager>().matrixUrl.replaceAll('https://', '');
          String matrixId = '@$generatedMatrixId:$domainPart';

          final MatrixUser? newUser = await _matrixApiService.userApi
              .createNewMatrixUser(
                matrixId: matrixId,
                displayName: displayName,
                password: password,
              );

          // now we need to add the user to the compulsoryrooms

          if (newUser == null) {
            continue;
          }

          _matrixUsers.value = [..._matrixUsers.value, newUser];

          // Add user to compulsory rooms: globalChildrem, contacts, groupChildren (name contains pupil.group)
          final roomManager = di<MatrixPolicyManager>().rooms;
          final roomIdsToAdd = roomIdsForPupilOrParent(
            roomManager: roomManager,
            group: pupil.group,
            isParent: false,
          );
          final userId = newUser.id!;

          addMatrixUserToRooms(userId, roomIdsToAdd);

          userCredentials.add({'user': newUser, 'password': password});
          await PupilMutator().updateStringProperty(
            pupilId: pupil.pupilId,
            property: PupilStringProperty.contact,
            propertyValue: (value: matrixId),
          );

          // Ensure pupil has TutorInfo with parentsContact: clone from sibling or create parent Matrix user
          if (pupil.tutorInfo?.parentsContact == null) {
            final siblings = di<PupilProxyManager>().getSiblings(pupil);
            PupilProxy? siblingWithParentsContact;
            for (final s in siblings) {
              if (s.tutorInfo?.parentsContact != null) {
                siblingWithParentsContact = s;
                break;
              }
            }
            if (siblingWithParentsContact != null) {
              final clonedTutorInfo = siblingWithParentsContact.tutorInfo!
                  .copyWith();
              await PupilMutator().updateTutorInfo(
                pupilId: pupil.pupilId,
                tutorInfo: clonedTutorInfo,
              );
            } else {
              // No sibling with parentsContact: create new parent Matrix user
              final parentDisplayName = 'Fa. ${pupil.lastName} (E)';
              final parentGeneratedId = MatrixPolicyHelper.generateMatrixId(
                isParent: true,
              );
              final parentPassword = MatrixPolicyHelper.generatePassword();
              final parentMatrixId = '@$parentGeneratedId:$domainPart';

              final MatrixUser? newParentUser = await _matrixApiService.userApi
                  .createNewMatrixUser(
                    matrixId: parentMatrixId,
                    displayName: parentDisplayName,
                    password: parentPassword,
                  );

              if (newParentUser != null) {
                _matrixUsers.value = [..._matrixUsers.value, newParentUser];
                final parentRoomIds = roomIdsForPupilOrParent(
                  familyCode: pupil.family,
                  roomManager: roomManager,
                  group: pupil.group,
                  isParent: true,
                );
                final parentUserId = newParentUser.id!;

                addMatrixUserToRooms(parentUserId, parentRoomIds);
                userCredentials.add({
                  'user': newParentUser,
                  'password': parentPassword,
                });
                await PupilMutator().updateParentsContact(pupil, (
                  value: parentMatrixId,
                ));
              }
            }
          }
          await Future<void>.delayed(const Duration(milliseconds: 100));
        }
      }

      if (userCredentials.isEmpty) {
        return null;
      }

      await di<MatrixPolicyManager>().applyPolicyChanges();

      return MatrixBulkCredentialsService.generateBulkCredentialsPdf(
        matrixDomain: _matrixUrl,
        userCredentials: userCredentials,
        isStaff: false,
      );
    } catch (e) {
      _log.severe(
        'Error creating matrix credentials for pupils without contact info: $e',
      );
      return null;
    } finally {
      _notificationService.setHeavyLoadingValue(false);
    }
  }
}
