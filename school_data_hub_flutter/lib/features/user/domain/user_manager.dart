import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:watch_it/watch_it.dart';

//- DEPENDENCY INJECTIONS

final _log = Logger('UserManager');

final _client = di<Client>();

final _sessionManager = di<HubSessionManager>();

final _notificationService = di<NotificationService>();

class UserManager {
  ValueListenable<List<User>> get users => _users;
  final _users = ValueNotifier<List<User>>([]);

  UserManager();
  Future<UserManager> init() async {
    return this;
  }

  Future<void> fetchUsers() async {
    if (_sessionManager.isAdmin == false) {
      return;
    }

    try {
      final List<User> responseUsers = await _client.admin.getAllUsers();

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
    final User user = await _client.admin.createUser(
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
  //   required User user,
  //   bool? admin,
  //   String? contact,
  //   int? credit,
  //   String? name,
  //   String? role,
  //   int? timeUnits,
  //   String? tutoring,
  // }) async {
  //   final User updatedUser = await userApiService.patchUser(
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

  Future<void> blockUser(User user) async {
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

  void setUsers(List<User> users) {
    _users.value = users;
  }

  void addUser(User user) {
    final List<User> users = List.from(_users.value);
    users.add(user);

    users
        .sort((a, b) => a.userInfo!.userName!.compareTo(b.userInfo!.userName!));
    _users.value = users;
  }

  void removeUser(User user) {
    _users.value =
        _users.value.where((element) => element.id != user.id).toList();
  }

  // void updateUser(User user) {
  //   _users.value = _users.value
  //       .map((e) => e.publicId == user.publicId ? user : e)
  //       .toList();
  // }

  void clearUsers() {
    _users.value = [];
  }

  void removeUsers(List<User> users) {
    _users.value =
        _users.value.where((element) => !users.contains(element)).toList();
  }

  void addUsers(List<User> users) {
    _users.value = [..._users.value, ...users];
  }

  void updateUsers(List<User> users) {
    _users.value = users;
  }

  // void addOrUpdateUser(User user) {
  //   if (_users.value.any((element) => element.publicId == user.publicId)) {
  //     updateUser(user);
  //   } else {
  //     addUser(user);
  //   }
  // }

  Future<void> increaseUsersCredit() async {
    final success = await _client.user.increaseStaffCredit();
    // TODO: This is not implemented yet
    //  updateUsers(users);
    if (!success) {
      _notificationService.showSnackBar(
          NotificationType.error, 'Guthaben konnte nicht erhöht werden!');
      return;
    }
    _notificationService.showSnackBar(
        NotificationType.success, 'Guthaben erfolgreich erhöht!');
  }
}
