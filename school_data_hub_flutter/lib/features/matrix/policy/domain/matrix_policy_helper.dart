import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/matrix_credentials.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/policy.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

final _log = Logger('MatrixPolicyHelperFunctions');

class MatrixPolicyHelper {
  static MatrixPolicyManager get _matrixPolicyManager =>
      di<MatrixPolicyManager>();
  static HubSecureStorage get _secureStorage => HubSecureStorage();
  static EnvManager get _envManager => di<EnvManager>();
  static Future<void> registerMatrixPolicyManager({
    MatrixCredentials? passedCredentials,
  }) async {
    // We are passing the credentials here for convenience
    // when they come from the SetMatrixEnvironmentPage
    // (and they are not stored in secure storage yet)
    // if they are null, we will read them from secure storage

    final secureStorageKey = _envManager.storageKeyForMatrixCredentials;
    if (passedCredentials == null) {
      _log.warning(
        'No matrix credentials passed, the app is initializing\nreading matrix credentials from secure storage',
      );
      final String? matrixStoredValues = await _secureStorage.getString(
        secureStorageKey,
      );

      if (matrixStoredValues == null) {
        throw Exception('Matrix stored values are null');
      }
    } else {
      _log.info('Matrix credentials passed, storing them in secure storage');

      await _secureStorage.setString(
        secureStorageKey,
        jsonEncode(
          MatrixCredentials(
            url: passedCredentials.url,
            userServerAddress: passedCredentials.userServerAddress,
            matrixToken: passedCredentials.matrixToken,
            policyToken: passedCredentials.policyToken,
            matrixAdmin: passedCredentials.matrixAdmin,
            encryptionKey: passedCredentials.encryptionKey,
          ),
        ),
      );
    }

    // if the MatrixPolicyManager is already registered, we will return
    // and not register it again
    // instead we will update the credentials in the manager
    // calling a function and fetch the policy again
    if (di.isRegistered<MatrixPolicyManager>()) {
      return;
    }

    // is the passed credentials are null, we will use the stored ones
    // final validCredentials = passedCredentials ?? storedCredentials;

    await InitManager.registerMatrixManagers();

    return;
  }

  static String generatePolicyJson() {
    final Policy policy = _matrixPolicyManager.matrixPolicy!;
    final policyMap = policy.toJson();
    final hooks = policy.hooks;
    if (hooks != null) {
      policyMap['hooks'] = hooks.map((hook) => hook.toCorporalJson()).toList();
    }

    return jsonEncode(policyMap);
  }

  static Policy refreshMatrixPolicy() {
    final oldPolicy = _matrixPolicyManager.matrixPolicy;

    final List<MatrixRoom> rooms = _matrixPolicyManager.matrixRooms.value;

    final List<String> roomIds = rooms.map((room) => room.id).toList();

    // Rebuild matrixUsers via Policy's type so copyWith receives List<MatrixUser>
    // from the same library as Policy (avoids subtype mismatch at runtime).
    final matrixUsersJson = _matrixPolicyManager.matrixUsers.value
        .map((u) => u.toJson())
        .toList();
    final matrixUsers = Policy.matrixUsersFromJsonMaps(matrixUsersJson);

    final refreshedPolicy = oldPolicy!.copyWith(
      managedRoomIds: roomIds,
      matrixUsers: matrixUsers,
    );
    return refreshedPolicy;
  }

  static String generateMatrixId({required isParent}) {
    var uuid = const Uuid();
    String randomUUID = uuid.v4().replaceAll('-', '');

    final matrixId = randomUUID.substring(0, 12);
    switch (isParent) {
      case true:
        return '${matrixId}_e';
      case false:
        return '${matrixId}_';
    }

    return matrixId;
  }

  static String generatePassword() {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?@#&';
    const digits = '0123456789';
    final random = Random();

    // Generate 8 random characters
    final randomCharacters = List.generate(8, (_) {
      final index = random.nextInt(characters.length);
      return characters[index];
    });

    // Generate 4 random digits
    final randomDigits = List.generate(4, (_) {
      final index = random.nextInt(digits.length);
      return digits[index];
    });

    // Combine the characters and digits to form the password
    final password = randomCharacters.followedBy(randomDigits).join();
    return password;
  }

  static Future<void> launchMatrixUrl(
    BuildContext context,
    String contact,
  ) async {
    final Uri matrixUrl = Uri.parse('https://matrix.to/#/$contact');

    try {
      final bool launched = await launchUrl(
        matrixUrl,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      if (!launched) {
        _log.severe('Failed to launch $matrixUrl');
      }
    } catch (e) {
      _log.severe('An error occurred while launching $matrixUrl: $e');
    }

    return;
  }
}
