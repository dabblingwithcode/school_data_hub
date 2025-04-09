import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:watch_it/watch_it.dart';

//- DEPENDENCY INJECTIONS

final _log = Logger('UserManager');

final _client = di<Client>();

final _sessionManager = di<ServerpodSessionManager>();

final _notificationService = di<NotificationService>();

class UserManager {
  ValueListenable<List<StaffUser>> get users => _users;
  final _users = ValueNotifier<List<StaffUser>>([]);

  UserManager();
  Future<UserManager> init() async {
    return this;
  }

  Future<void> fetchUsers() async {
    if (_sessionManager.isAdmin == false) {
      return;
    }

    try {
      final List<StaffUser> responseUsers = await _client.admin.getAllUsers();

      // reorder the list alphabetically by the user's name
      responseUsers.sort(
          (a, b) => a.userInfo!.userName!.compareTo(b.userInfo!.userName!));
      _users.value = responseUsers;
    } catch (e) {
      // Handle the error appropriately
      _log.severe('Error fetching users: $e');
      // You might want to set an error state or show a notification
    }

    return;
  }

  Future<void> createUser(
      {required String userName,
      required String fullName,
      required String password,
      required String email,
      required bool isAdmin,
      required int timeUnits,
      required int credit,
      required String contact,
      required List<String> scopeNames,
      required Role role,
      String? tutoring}) async {
    final StaffUser user = await _client.admin.createUser(
      userName: userName,
      fullName: fullName,
      email: email,
      password: password,
      role: role,
      timeUnits: timeUnits,
      scopeNames: scopeNames,
    );

    addUser(user);

    _notificationService.showSnackBar(
        NotificationType.success, 'User erstellt!');
    return;
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    final success = await _client.user.changePassword(oldPassword, newPassword);
    if (!success) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Passwort konnte nicht geändert werden!');
      return;
    }

    _notificationService.showSnackBar(
        NotificationType.success, 'Passwort erfolgreich geändert!');
    return;
  }

  // Future<void> updateUserProperties({
  //   required StaffUser user,
  //   bool? admin,
  //   String? contact,
  //   int? credit,
  //   String? name,
  //   String? role,
  //   int? timeUnits,
  //   String? tutoring,
  // }) async {
  //   final StaffUser updatedUser = await userApiService.patchUser(
  //       publicId: user.publicId,
  //       admin: admin,
  //       contact: contact,
  //       credit: credit,
  //       name: name,
  //       role: role,
  //       timeUnits: timeUnits,
  //       tutoring: tutoring);
  //   updateUser(updatedUser);
  //   notificationService.showSnackBar(
  //       NotificationType.success, 'User aktualisiert!');
  //   return;
  // }

  Future<void> blockUser(StaffUser user) async {
    if (!_sessionManager.isAdmin) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Sie sind kein Admin!');
      return;
    }
    await _client.admin.deleteUser(user.userInfo!.id!);
    removeUser(user);
    _notificationService.showSnackBar(
        NotificationType.success, 'User gelöscht!');
    return;
  }

  void setUsers(List<StaffUser> users) {
    _users.value = users;
  }

  void addUser(StaffUser user) {
    final List<StaffUser> users = List.from(_users.value);
    users.add(user);

    users
        .sort((a, b) => a.userInfo!.userName!.compareTo(b.userInfo!.userName!));
    _users.value = users;
  }

  void removeUser(StaffUser user) {
    _users.value =
        _users.value.where((element) => element.id != user.id).toList();
  }

  // void updateUser(StaffUser user) {
  //   _users.value = _users.value
  //       .map((e) => e.publicId == user.publicId ? user : e)
  //       .toList();
  // }

  void clearUsers() {
    _users.value = [];
  }

  void removeUsers(List<StaffUser> users) {
    _users.value =
        _users.value.where((element) => !users.contains(element)).toList();
  }

  void addUsers(List<StaffUser> users) {
    _users.value = [..._users.value, ...users];
  }

  void updateUsers(List<StaffUser> users) {
    _users.value = users;
  }

  // void addOrUpdateUser(StaffUser user) {
  //   if (_users.value.any((element) => element.publicId == user.publicId)) {
  //     updateUser(user);
  //   } else {
  //     addUser(user);
  //   }
  // }

  // Future<void> increaseUsersCredit() async {

  //   final List<StaffUser> users = await userApiService.increaseUsersCredit();
  //   updateUsers(users);
  //   notificationService
  //       .showSnackBar(NotificationType.success, 'Guthaben erfolgreich erhöht!');
  // }
}
