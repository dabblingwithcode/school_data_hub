import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:flutter_it/flutter_it.dart';

/// API service for user-related operations.
class UserApiService {
  Client get _client => di<Client>();

  /// Fetch all users.
  Future<List<User>> getAllUsers() async {
    return _client.user.getAllUsers();
  }

  /// Get the currently authenticated user.
  Future<User?> getCurrentUser() async {
    return _client.user.getCurrentUser();
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
  }) async {
    await _client.adminUser.createUser(
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
    );
  }

  /// Reset a user's password. Returns `true` on success.
  Future<bool> resetPassword(String userEmail, String newPassword) async {
    return _client.adminUser.resetPassword(userEmail, newPassword);
  }

  /// Change the current user's password. Returns `true` on success.
  Future<bool> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    return _client.user.changePassword(oldPassword, newPassword);
  }

  /// Delete (block) a user by ID.
  Future<void> deleteUser(int userId) async {
    await _client.adminUser.deleteUser(userId);
  }

  /// Increase staff credit for all users. Returns `true` on success.
  Future<bool> increaseStaffCredit() async {
    return _client.user.increaseStaffCredit();
  }
}
