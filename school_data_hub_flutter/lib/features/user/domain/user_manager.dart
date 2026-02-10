import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/user/data/user_api_service.dart';
import 'package:flutter_it/flutter_it.dart';

/// Data class for createUser command parameters.
typedef CreateUserParams = ({
  String userName,
  String fullName,
  String password,
  String email,
  String matrixUserId,
  int timeUnits,
  int reliefTimeUnits,
  int credit,
  List<String> scopeNames,
  Role role,
  bool isTester,
  String? tutoring,
});

/// Data class for resetPassword command parameters.
typedef ResetPasswordParams = ({String userEmail, String newPassword});

/// Data class for changePassword command parameters.
typedef ChangePasswordParams = ({String oldPassword, String newPassword});

/// Data class for updateUser command parameters.
typedef UpdateUserParams = ({
  int userInfoId,
  String userName,
  String fullName,
  String email,
  Role role,
  String? matrixUserId,
  int timeUnits,
  int reliefTimeUnits,
  int credit,
  bool isTester,
});

class UserManager {
  final _apiService = UserApiService();
  HubSessionManager get _sessionManager => di<HubSessionManager>();
  NotificationService get _notificationService => di<NotificationService>();

  final _users = ValueNotifier<List<User>>([]);
  ValueListenable<List<User>> get users => _users;

  //-- Commands --

  late final fetchUsersCommand = Command.createAsyncNoParamNoResult(
    _fetchUsers,
    debugName: 'fetchUsers',
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final createUserCommand = Command.createAsyncNoResult<CreateUserParams>(
    _createUser,
    debugName: 'createUser',
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final resetPasswordCommand =
      Command.createAsyncNoResult<ResetPasswordParams>(
    _resetPassword,
    debugName: 'resetPassword',
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final changePasswordCommand =
      Command.createAsyncNoResult<ChangePasswordParams>(
    _changePassword,
    debugName: 'changePassword',
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final blockUserCommand = Command.createAsyncNoResult<User>(
    _blockUser,
    debugName: 'blockUser',
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final updateUserCommand = Command.createAsyncNoResult<UpdateUserParams>(
    _updateUser,
    debugName: 'updateUser',
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final increaseUsersCreditCommand =
      Command.createAsyncNoParamNoResult(
    _increaseUsersCredit,
    debugName: 'increaseUsersCredit',
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  UserManager();

  void dispose() {
    _users.dispose();
  }

  Future<UserManager> init() async {
    await fetchUsersCommand.runAsync();
    return this;
  }

  //-- Command implementations --

  Future<void> _fetchUsers() async {
    final List<User> responseUsers = await _apiService.getAllUsers();
    responseUsers.sort(
      (a, b) => a.userInfo!.userName!.compareTo(b.userInfo!.userName!),
    );
    _users.value = responseUsers;
  }

  Future<void> _createUser(CreateUserParams params) async {
    await _apiService.createUser(
      userName: params.userName,
      fullName: params.fullName,
      email: params.email,
      matrixUserId: params.matrixUserId,
      password: params.password,
      role: params.role,
      timeUnits: params.timeUnits,
      reliefTimeUnits: params.reliefTimeUnits,
      scopeNames: params.scopeNames,
      isTester: params.isTester,
    );
    final userWithDetails = await _apiService.getCurrentUser();
    _addUser(userWithDetails!);

    _notificationService.showSnackBar(
      NotificationType.success,
      'User erstellt!',
    );
  }

  Future<void> _resetPassword(ResetPasswordParams params) async {
    final success = await _apiService.resetPassword(
      params.userEmail,
      params.newPassword,
    );
    if (!success) {
      throw Exception('Passwort konnte nicht zurückgesetzt werden!');
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Passwort erfolgreich zurückgesetzt!',
    );
  }

  Future<void> _changePassword(ChangePasswordParams params) async {
    final success = await _apiService.changePassword(
      params.oldPassword,
      params.newPassword,
    );
    if (!success) {
      throw Exception('Passwort konnte nicht geändert werden!');
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Passwort erfolgreich geändert!',
    );
  }

  Future<void> _blockUser(User user) async {
    if (!_sessionManager.isAdmin) {
      throw Exception('Sie sind kein Admin!');
    }
    await _apiService.deleteUser(user.userInfo!.id!);
    removeUser(user);
    _notificationService.showSnackBar(
      NotificationType.success,
      'User gelöscht!',
    );
  }

  Future<void> _updateUser(UpdateUserParams params) async {
    await _apiService.updateUser(
      userId: params.userInfoId,
      userName: params.userName,
      fullName: params.fullName,
      email: params.email,
      role: params.role,
      matrixUserId: params.matrixUserId,
      timeUnits: params.timeUnits,
      reliefTimeUnits: params.reliefTimeUnits,
      credit: params.credit,
      isTester: params.isTester,
    );
    await fetchUsersCommand.runAsync();
    _notificationService.showSnackBar(
      NotificationType.success,
      'Benutzer aktualisiert!',
    );
  }

  Future<void> _increaseUsersCredit() async {
    final success = await _apiService.increaseStaffCredit();
    if (!success) {
      throw Exception('Guthaben konnte nicht erhöht werden!');
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Guthaben erfolgreich erhöht!',
    );
  }

  //-- Convenience wrappers for backward compatibility --
  //
  // These allow existing UI code to call `await userManager.fetchUsers()`
  // while the underlying implementation uses Commands.

  Future<void> fetchUsers() => fetchUsersCommand.runAsync();

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
  }) =>
      createUserCommand.runAsync((
        userName: userName,
        fullName: fullName,
        password: password,
        email: email,
        matrixUserId: matrixUserId,
        timeUnits: timeUnits,
        reliefTimeUnits: reliefTimeUnits,
        credit: credit,
        scopeNames: scopeNames,
        role: role,
        isTester: isTester,
        tutoring: tutoring,
      ));

  Future<void> resetPassword(String userEmail, String newPassword) =>
      resetPasswordCommand
          .runAsync((userEmail: userEmail, newPassword: newPassword));

  Future<void> changePassword(String oldPassword, String newPassword) =>
      changePasswordCommand
          .runAsync((oldPassword: oldPassword, newPassword: newPassword));

  Future<void> blockUser(User user) => blockUserCommand.runAsync(user);

  Future<void> updateUser(UpdateUserParams params) =>
      updateUserCommand.runAsync(params);

  Future<void> increaseUsersCredit() =>
      increaseUsersCreditCommand.runAsync();

  //-- Local state helpers --

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
}
