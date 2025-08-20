import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/core/di/dependency_injection.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/policy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('MatrixPolicyHelperFunctions');

final _matrixPolicyManager = di<MatrixPolicyManager>();
final _secureStorage = HubSecureStorage();
final _envManager = di<EnvManager>();

class MatrixPolicyHelper {
  static Future<void> registerMatrixPolicyManager(
      {MatrixCredentials? passedCredentials}) async {
    // We are passing the credentials here for convenience
    // when they come from the SetMatrixEnvironmentPage
    // (and they are not stored in secure storage yet)
    // if they are null, we will read them from secure storage

    final _secureStorageKey = _envManager.storageKeyForMatrixCredentials;
    MatrixCredentials? storedCredentials;
    if (passedCredentials == null) {
      _log.warning(
          'No matrix credentials passed, the app is initializing\nreading matrix credentials from secure storage');
      final String? matrixStoredValues =
          await _secureStorage.getString(_secureStorageKey);

      if (matrixStoredValues == null) {
        throw Exception('Matrix stored values are null');
      }

      storedCredentials =
          MatrixCredentials.fromJson(jsonDecode(matrixStoredValues));
    } else {
      _log.info('Matrix credentials passed, storing them in secure storage');

      await _secureStorage.setString(
          _secureStorageKey,
          jsonEncode(MatrixCredentials(
              url: passedCredentials.url,
              matrixToken: passedCredentials.matrixToken,
              policyToken: passedCredentials.policyToken,
              matrixAdmin: passedCredentials.matrixAdmin)));
    }

    // if the MatrixPolicyManager is already registered, we will return
    // and not register it again
    // instead we will update the credentials in the manager
    // calling a function and fetch the policy again
    if (di.isRegistered<MatrixPolicyManager>()) {
      return;
    }

    // is the passed credentials are null, we will use the stored ones
    final validCredentials = passedCredentials ?? storedCredentials;

    await DiManager.registerMatrixManagers(validCredentials!);

    return;
  }

  static Future<File> generatePolicyJsonFile({required String filename}) async {
    // create a new json file with the policy

    final File file = File('$filename.json');
    if (file.existsSync()) {
      file.deleteSync();
    }
    final Policy policy = _matrixPolicyManager.matrixPolicy!;
    final Map<String, dynamic> jsonString = policy.toJson();
    // transform the map into a json string
    final String policyJson = jsonEncode(jsonString);

    file.writeAsStringSync(policyJson);

    return file;
  }

  static Policy refreshMatrixPolicy() {
    final oldPolicy = _matrixPolicyManager.matrixPolicy;

    final List<MatrixRoom> rooms = _matrixPolicyManager.matrixRooms.value;

    final List<String> roomIds = rooms.map((room) => room.id).toList();

    final refreshedPolicy = oldPolicy!.copyWith(
        managedRoomIds: roomIds,
        matrixUsers: _matrixPolicyManager.matrixUsers.value);
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
      BuildContext context, String contact) async {
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
