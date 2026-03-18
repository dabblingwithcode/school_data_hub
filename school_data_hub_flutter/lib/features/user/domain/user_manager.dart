import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/user/data/user_api_service.dart';
import 'package:school_data_hub_flutter/features/user/domain/batch_create_result.dart';
import 'package:school_data_hub_flutter/features/user/domain/staff_import_password_generator.dart';
import 'package:school_data_hub_flutter/features/user/domain/staff_import_row.dart';

final _log = Logger('UserManager');

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
  Set<int>? pupilsAuth,
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
  Set<int>? pupilsAuth,
});

class UserManager {
  StreamSubscription<dynamic>? _hubSubscription;
  final _apiService = UserApiService();
  HubSessionManager get _sessionManager => di<HubSessionManager>();
  NotificationManager get _notificationService => di<NotificationManager>();

  final _usersWithDevices = ValueNotifier<List<UserWithDevices>>([]);
  final _users = ValueNotifier<List<User>>([]);

  ValueListenable<List<UserWithDevices>> get usersWithDevices =>
      _usersWithDevices;

  /// Derived list of users for search bar and backward compatibility.
  ValueListenable<List<User>> get users => _users;

  void _syncUsersFromDevices() {
    _users.value = _usersWithDevices.value.map((e) => e.user).toList();
  }

  //-- Commands --

  late final fetchUsersCommand = Command.createAsyncNoParamNoResult(
    _fetchUsers,
    debugName: 'fetchUsers',
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

  late final deleteDeviceCommand = Command.createAsyncNoResult<UserDevice>(
    _deleteDevice,
    debugName: 'deleteDevice',
    errorFilter: const LocalErrorFilter(),
  );

  late final increaseUsersCreditCommand = Command.createAsyncNoParamNoResult(
    _increaseUsersCredit,
    debugName: 'increaseUsersCredit',
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  UserManager();

  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _usersWithDevices.dispose();
    _users.dispose();
  }

  Future<UserManager> init() async {
    await fetchUsersCommand.runAsync();
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
    return this;
  }

  void _onHubEvent(dynamic event) {
    if (event is User) {
      _upsertUserFromStream(event);
    } else if (event is HubDeleteEvent &&
        event.objectType == HubObjectType.user) {
      _deleteUserFromStream(event.id);
    } else if (event is HubReconnected) {
      fetchUsersCommand.runAsync();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.user)) {
        fetchUsersCommand.runAsync();
      }
    }
  }

  void _upsertUserFromStream(User user) {
    _log.fine('[STREAM] upsert user ${user.id}');
    final list = List<UserWithDevices>.from(_usersWithDevices.value);
    final index = list.indexWhere((e) => e.user.id == user.id);
    if (index != -1) {
      // Preserve existing devices, update user data
      list[index] = list[index].copyWith(user: user);
    } else {
      list.add(UserWithDevices(user: user, devices: []));
    }
    list.sort(
      (a, b) => (a.user.userInfo?.userName ?? '').compareTo(
        b.user.userInfo?.userName ?? '',
      ),
    );
    _usersWithDevices.value = list;
    _syncUsersFromDevices();
  }

  void _deleteUserFromStream(int id) {
    _log.fine('[STREAM] delete user $id');
    final list = _usersWithDevices.value.where((e) => e.user.id != id).toList();
    if (list.length != _usersWithDevices.value.length) {
      _usersWithDevices.value = list;
      _syncUsersFromDevices();
    }
  }

  //-- Command implementations --

  Future<void> _fetchUsers() async {
    final list = await _apiService.getAllUsersWithDevices();
    if (list == null) return;
    list.sort(
      (a, b) => (a.user.userInfo?.userName ?? '').compareTo(
        b.user.userInfo?.userName ?? '',
      ),
    );
    _usersWithDevices.value = list;
    _syncUsersFromDevices();
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
      pupilsAuth: params.pupilsAuth,
    );
    final userWithDetails = await _apiService.getCurrentUser();
    if (userWithDetails != null) _addUser(userWithDetails);

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
    if (success != true) {
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
    if (success != true) {
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
      pupilsAuth: params.pupilsAuth,
    );
    await fetchUsersCommand.runAsync();
    _notificationService.showSnackBar(
      NotificationType.success,
      'Benutzer aktualisiert!',
    );
  }

  Future<void> _deleteDevice(UserDevice device) async {
    await _apiService.deleteAuthKeyAssociatedWithDevice(device);
    await fetchUsersCommand.runAsync();
    _notificationService.showSnackBar(
      NotificationType.success,
      'Gerät gelöscht.',
    );
  }

  Future<void> _increaseUsersCredit() async {
    final success = await _apiService.increaseStaffCredit();
    if (success != true) {
      throw Exception('Guthaben konnte nicht erhöht werden!');
    }
    _notificationService.showSnackBar(
      NotificationType.success,
      'Guthaben erfolgreich erhöht!',
    );
  }

  /// Builds [CreateUserRequest] list from import rows (shared by batch and stream).
  List<CreateUserRequest> buildCreateUserRequestsFromImportRows(
    List<StaffImportRow> rows, {
    String Function(StaffImportRow)? generatePassword,
  }) {
    final gen = generatePassword ?? (_) => generateRandomStaffPassword();
    final requests = <CreateUserRequest>[];
    for (final row in rows) {
      final userName = row.kurzel.trim();
      final email = row.email.trim().isEmpty
          ? '$userName@schule.local'
          : row.email.trim();
      final scopeNames = row.role == Role.admin ? ['admin'] : <String>[];
      requests.add(
        CreateUserRequest(
          userName: userName,
          fullName: row.fullName,
          email: email,
          password: gen(row),
          role: row.role,
          timeUnits: row.timeUnits,
          reliefTimeUnits: row.reliefTimeUnits,
          scopeNames: scopeNames,
          isTester: false,
          matrixUserId: null,
          credit: null,
          pupilsAuth: null,
        ),
      );
    }
    return requests;
  }

  /// Batch-creates users via the streaming endpoint, yielding one
  /// [BatchCreateResult] per user (success or error).
  Stream<BatchCreateResult> batchCreateUsersViaStream(
    List<StaffImportRow> rows, {
    String Function(StaffImportRow)? generatePassword,
  }) async* {
    final requests = buildCreateUserRequestsFromImportRows(
      rows,
      generatePassword: generatePassword,
    );
    _log.info(
      '[UserManager] batchCreateUsersViaStream: rows=${rows.length} -> '
      'requests=${requests.length}',
    );

    final stream = _apiService.batchCreateUsersStream(requests);

    await for (final event in stream) {
      if (event.credential != null) {
        final c = event.credential!;
        yield BatchCreateResult(
          credentials: [
            StaffCredentialEntry(
              userName: c.userName,
              fullName: c.fullName,
              email: c.email,
              password: c.password,
            ),
          ],
          errors: [],
        );
      } else if (event.error != null) {
        final e = event.error!;
        yield BatchCreateResult(
          credentials: [],
          errors: [
            BatchCreateError(
              rowIndex: e.rowIndex,
              userNameOrKurzel: e.userNameOrKurzel,
              message: e.message,
            ),
          ],
        );
      }
    }

    _log.info('[UserManager] batchCreateUsersViaStream: done');
    await fetchUsersCommand.runAsync();
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
    Set<int>? pupilsAuth,
  }) async {
    await _createUser((
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
      pupilsAuth: pupilsAuth,
    ));
  }

  Future<void> resetPassword(String userEmail, String newPassword) =>
      resetPasswordCommand.runAsync((
        userEmail: userEmail,
        newPassword: newPassword,
      ));

  Future<void> changePassword(String oldPassword, String newPassword) =>
      changePasswordCommand.runAsync((
        oldPassword: oldPassword,
        newPassword: newPassword,
      ));

  Future<void> blockUser(User user) => blockUserCommand.runAsync(user);

  Future<void> deleteDevice(UserDevice device) =>
      deleteDeviceCommand.runAsync(device);

  Future<void> updateUser(UpdateUserParams params) =>
      updateUserCommand.runAsync(params);

  Future<void> increaseUsersCredit() => increaseUsersCreditCommand.runAsync();

  //-- Local state helpers --

  void setUsers(List<User> users) {
    final list = users
        .map((u) => UserWithDevices(user: u, userDevices: []))
        .toList();
    list.sort(
      (a, b) => (a.user.userInfo?.userName ?? '').compareTo(
        b.user.userInfo?.userName ?? '',
      ),
    );
    _usersWithDevices.value = list;
    _syncUsersFromDevices();
  }

  void _addUser(User user) {
    final list = List<UserWithDevices>.from(_usersWithDevices.value);
    list.add(UserWithDevices(user: user, userDevices: []));
    list.sort(
      (a, b) => (a.user.userInfo?.userName ?? '').compareTo(
        b.user.userInfo?.userName ?? '',
      ),
    );
    _usersWithDevices.value = list;
    _syncUsersFromDevices();
  }

  void removeUser(User user) {
    _usersWithDevices.value = _usersWithDevices.value
        .where(
          (e) => e.user.id != user.id && e.user.userInfoId != user.userInfoId,
        )
        .toList();
    _syncUsersFromDevices();
  }

  void clearUsers() {
    _usersWithDevices.value = [];
    _syncUsersFromDevices();
  }

  void removeUsers(List<User> users) {
    final ids = users.map((u) => u.id).toSet();
    final infoIds = users.map((u) => u.userInfoId).toSet();
    _usersWithDevices.value = _usersWithDevices.value
        .where(
          (e) =>
              !ids.contains(e.user.id) && !infoIds.contains(e.user.userInfoId),
        )
        .toList();
    _syncUsersFromDevices();
  }

  void addUsers(List<User> users) {
    final list = List<UserWithDevices>.from(_usersWithDevices.value);
    for (final u in users) {
      list.add(UserWithDevices(user: u, userDevices: []));
    }
    list.sort(
      (a, b) => (a.user.userInfo?.userName ?? '').compareTo(
        b.user.userInfo?.userName ?? '',
      ),
    );
    _usersWithDevices.value = list;
    _syncUsersFromDevices();
  }

  void updateUsers(List<User> users) {
    final byInfoId = {
      for (final uwd in _usersWithDevices.value) uwd.user.userInfoId: uwd,
    };
    final newList = <UserWithDevices>[];
    for (final u in users) {
      final existing = byInfoId[u.userInfoId];
      newList.add(
        existing != null
            ? UserWithDevices(user: u, userDevices: existing.userDevices)
            : UserWithDevices(user: u, userDevices: []),
      );
    }
    newList.sort(
      (a, b) => (a.user.userInfo?.userName ?? '').compareTo(
        b.user.userInfo?.userName ?? '',
      ),
    );
    _usersWithDevices.value = newList;
    _syncUsersFromDevices();
  }
}
