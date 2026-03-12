import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';

/// API service for user-related operations.
class UserApiService {
  Client get _client => di<Client>();

  /// Fetch all users.
  Future<List<User>?> getAllUsers() async {
    return ClientHelper.apiCall(
      call: () => _client.user.getAllUsers(),
      errorMessage: 'Benutzer abrufen',
    );
  }

  /// Fetch all users with UserInfo and list of UserDevices per user.
  Future<List<UserWithDevices>?> getAllUsersWithDevices() async {
    return ClientHelper.apiCall(
      call: () => _client.user.getAllUsersWithDevices(),
      errorMessage: 'Benutzer mit Geräten abrufen',
    );
  }

  /// Get the currently authenticated user.
  Future<User?> getCurrentUser() async {
    return ClientHelper.apiCall<User?>(
      call: () => _client.user.getCurrentUser(),
      errorMessage: 'Aktuellen Benutzer abrufen',
    );
  }

  /// Create a new user.
  Future<void> createUser({
    required String userName,
    required String fullName,
    required String email,
    required String matrixUserId,
    required String password,
    required Role role,
    required int timeUnits,
    required int reliefTimeUnits,
    required List<String> scopeNames,
    required bool isTester,
    Set<int>? pupilsAuth,
  }) async {
    await ClientHelper.apiCall(
      call: () => _client.adminUser.createUser(
        userName: userName,
        fullName: fullName,
        email: email,
        matrixUserId: matrixUserId,
        password: password,
        role: role,
        timeUnits: timeUnits,
        reliefTimeUnits: reliefTimeUnits,
        scopeNames: scopeNames,
        isTester: isTester,
        pupilsAuth: pupilsAuth,
      ),
      errorMessage: 'Benutzer erstellen',
    );
  }

  /// Update user and UserInfo in one go. [userId] is the UserInfo id.
  /// [imageUrl] is stored in UserInfo when the server endpoint supports it.
  Future<void> updateUser({
    required int userId,
    required String userName,
    required String fullName,
    required String email,
    required Role role,
    String? matrixUserId,
    required int timeUnits,
    required int reliefTimeUnits,
    required int credit,
    required bool isTester,
    Set<int>? pupilsAuth,
  }) async {
    await ClientHelper.apiCall(
      call: () => _client.adminUser.updateUser(
        userId,
        userName: userName,
        fullName: fullName,
        email: email,
        role: role,
        matrixUserId: matrixUserId,
        timeUnits: timeUnits,
        reliefTimeUnits: reliefTimeUnits,
        credit: credit,
        isTester: isTester,
        pupilsAuth: pupilsAuth,
      ),
      errorMessage: 'Benutzer aktualisieren',
    );
  }

  /// Reset a user's password. Returns `true` on success.
  Future<bool?> resetPassword(String userEmail, String newPassword) async {
    return ClientHelper.apiCall(
      call: () => _client.adminUser.resetPassword(userEmail, newPassword),
      errorMessage: 'Passwort zurücksetzen',
    );
  }

  /// Change the current user's password. Returns `true` on success.
  Future<bool?> changePassword(String oldPassword, String newPassword) async {
    return ClientHelper.apiCall(
      call: () => _client.user.changePassword(oldPassword, newPassword),
      errorMessage: 'Passwort ändern',
    );
  }

  /// Delete (block) a user by ID.
  Future<void> deleteUser(int userId) async {
    await ClientHelper.apiCall(
      call: () => _client.adminUser.deleteUser(userId),
      errorMessage: 'Benutzer löschen',
    );
  }

  /// Delete the auth key associated with a device. Returns updated user+devices
  /// for the session user (or null if not authenticated).
  Future<UserWithDevices?> deleteAuthKeyAssociatedWithDevice(
    UserDevice device,
  ) async {
    return ClientHelper.apiCall<UserWithDevices?>(
      call: () => _client.adminUser.deleteAuthKeyAssociatedWithDevice(device),
      errorMessage: 'Geräte-Auth-Key löschen',
    );
  }

  /// Increase staff credit for all users. Returns `true` on success.
  Future<bool?> increaseStaffCredit() async {
    return ClientHelper.apiCall(
      call: () => _client.user.increaseStaffCredit(),
      errorMessage: 'Mitarbeiter-Guthaben erhöhen',
    );
  }

  /// Streams batch create results one-by-one (avoids HTTP timeout). No wrapper so caller can listen and handle errors.
  Stream<BatchCreateUserEvent> batchCreateUsersStream(
    List<CreateUserRequest> requests,
  ) {
    return _client.adminUser.batchCreateUsersStream(requests);
  }
}
