import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:watch_it/watch_it.dart';

class UserManager {
  final _log = Logger('UserManager');

  final _client = di<Client>();

  final _sessionManager = di<HubSessionManager>();

  final _notificationService = di<NotificationService>();
  ValueListenable<List<User>> get users => _users;
  final _users = ValueNotifier<List<User>>([]);

  UserManager();
  Future<UserManager> init() async {
    await fetchUsers();
    return this;
  }

  Future<void> fetchUsers() async {
    try {
      final List<User> responseUsers = await _client.user.getAllUsers();

      // reorder the list alphabetically by the user's name
      responseUsers.sort(
        (a, b) => a.userInfo!.userName!.compareTo(b.userInfo!.userName!),
      );
      _users.value = responseUsers;
    } catch (e) {
      // Handle the error appropriately
      _log.severe('Error fetching users: $e');
      // You might want to set an error state or show a notification
    }

    return;
  }

  Future<void> createUser({
    required String userName,
    required String fullName,
    required String password,
    required String email,
    required String matrixUserId,
    required int timeUnits,
    required int reliefTimeUnits,
    required int credit,
    required List<String> scopeNames,
    required Role role,
    required bool isTester,
    String? tutoring,
  }) async {
    //- TODO: Move to an api service in data folder!
    await _client.admin.createUser(
      userName: userName,
      fullName: fullName,
      email: email,
      matrixUserId: matrixUserId,
      password: password,
      role: role,
      timeUnits: timeUnits,
      reliefTimeUnits: 0,
      scopeNames: scopeNames,
      isTester: isTester,
    );
    final userWithDetails = await _client.user.getCurrentUser();

    _addUser(userWithDetails!);

    _notificationService.showSnackBar(
      NotificationType.success,
      'User erstellt!',
    );
    return;
  }

  Future<void> resetPassword(String userEmail, String newPassword) async {
    final success = await _client.admin.resetPassword(userEmail, newPassword);
    if (!success) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Passwort konnte nicht zurückgesetzt werden!',
      );
      return;
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Passwort erfolgreich zurückgesetzt!',
    );
    return;
  }

  //- CHANGE PASSWORD
  Future<void> changePassword(String oldPassword, String newPassword) async {
    final success = await _client.user.changePassword(oldPassword, newPassword);
    if (!success) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Passwort konnte nicht geändert werden!',
      );
      return;
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Passwort erfolgreich geändert!',
    );
    return;
  }

  //- TODO: Implement updateUserProperties

  Future<void> blockUser(User user) async {
    if (!_sessionManager.isAdmin) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Sie sind kein Admin!',
      );
      return;
    }
    await _client.admin.deleteUser(user.userInfo!.id!);
    removeUser(user);
    _notificationService.showSnackBar(
      NotificationType.success,
      'User gelöscht!',
    );
    return;
  }

  void setUsers(List<User> users) {
    _users.value = users;
  }

  void _addUser(User user) {
    final List<User> users = List.from(_users.value);
    users.add(user);

    users.sort(
      (a, b) => a.userInfo!.userName!.compareTo(b.userInfo!.userName!),
    );
    _users.value = users;
  }

  void removeUser(User user) {
    _users.value = _users.value
        .where((element) => element.id != user.id)
        .toList();
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
    _users.value = _users.value
        .where((element) => !users.contains(element))
        .toList();
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
        NotificationType.error,
        'Guthaben konnte nicht erhöht werden!',
      );
      return;
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Guthaben erfolgreich erhöht!',
    );
  }
}
