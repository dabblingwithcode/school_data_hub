import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:school_data_hub_flutter/core/models/enums.dart';
import 'package:school_data_hub_flutter/core/models/env.dart';
import 'package:school_data_hub_flutter/core/models/populated_env_server_data.dart';
import 'package:school_data_hub_flutter/core/services/notification_service.dart';
import 'package:school_data_hub_flutter/utils/logger.dart';
import 'package:school_data_hub_flutter/utils/secure_storage.dart';
import 'package:watch_it/watch_it.dart';

class EnvManager {
  final _dependentMangagersRegistered = ValueNotifier<bool>(false);
  ValueListenable<bool> get dependentManagersRegistered =>
      _dependentMangagersRegistered;

  Env? _activeEnv;

  Env? get env => _activeEnv;

  Map<String, Env> _environments = {};
  Map<String, Env> get envs => _environments;

  String _defaultEnv = '';
  String get defaultEnv => _defaultEnv;

  final _envReady = ValueNotifier<bool>(false);
  ValueListenable<bool> get envReady => _envReady;

  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  PackageInfo get packageInfo => _packageInfo;

  PopulatedEnvServerData _populatedEnvServerData = PopulatedEnvServerData(
      schoolSemester: false,
      schooldays: false,
      competences: false,
      supportCategories: false);

  PopulatedEnvServerData get populatedEnvServerData => _populatedEnvServerData;

  void setPopulatedEnvServerData(
      {bool? schoolSemester,
      bool? schooldays,
      bool? competences,
      bool? supportCategories}) {
    final data = _populatedEnvServerData.copyWith(
        schoolSemester:
            schoolSemester ?? _populatedEnvServerData.schoolSemester,
        schooldays: schooldays ?? _populatedEnvServerData.schooldays,
        competences: competences ?? _populatedEnvServerData.competences,
        supportCategories:
            supportCategories ?? _populatedEnvServerData.supportCategories);
    _populatedEnvServerData = data;
  }

  bool anyPopulatedEnvServerDataIsFalse() {
    return _populatedEnvServerData.schoolSemester == false ||
        _populatedEnvServerData.schooldays == false ||
        _populatedEnvServerData.competences == false ||
        _populatedEnvServerData.supportCategories == false;
  }

  Future<EnvManager> init() async {
    await firstRun();
    return this;
  }

  void setDependentManagersRegistered(bool value) {
    _dependentMangagersRegistered.value = value;
    log('message: dependentManagersRegistered: $value');
  }

  Future<void> firstRun() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _packageInfo = packageInfo;

    final EnvsInStorage? environmentsObject = await environmentsInStorage();

    if (environmentsObject == null) {
      _envReady.value = false;
      return;
    }

    _defaultEnv = environmentsObject.defaultEnv;

    _environments = environmentsObject.environmentsMap;

    _activeEnv = environmentsObject.environmentsMap[_defaultEnv];

    log('Default Environment: $_defaultEnv');

    // set the base url for the api client

    // locator<ApiClient>().setBaseUrl(_activeEnv!.serverUrl);

    _envReady.value = true;

    return;
  }

  Future<EnvsInStorage?> environmentsInStorage() async {
    bool environmentsInStorage = await AppSecureStorage()
        .containsKey(SecureStorageKey.environments.value);

    if (environmentsInStorage == true) {
      final String? storedEnvironmentsAsString = await AppSecureStorage()
          .getString(SecureStorageKey.environments.value);

      try {
        final environmentsInStorage = EnvsInStorage.fromJson(
            json.decode(storedEnvironmentsAsString!) as Map<String, dynamic>);

        return environmentsInStorage;
      } catch (e) {
        logger.f('Error reading env from secureStorage: $e',
            stackTrace: StackTrace.current);

        log('deleting faulty environments from secure storage');

        await AppSecureStorage().remove(SecureStorageKey.environments.value);

        return null;
      }
    }

    return null;
  }

  // set the environment from a string
  void importNewEnv(String envAsString) async {
    final Env env =
        Env.fromJson(json.decode(envAsString) as Map<String, dynamic>);

    _environments = {..._environments, env.server: env};

    _defaultEnv = env.server;

    logger.i(
        'New Env ${env.server} stored, there are now ${_environments.length} environments stored!');

    di<NotificationService>().showSnackBar(NotificationType.success,
        'Schulschlüssel für ${env.server} gespeichert!');

    activateEnv(envName: env.server);

    return;
  }

  deleteEnv() async {
    final deletedEnvironment = _activeEnv!.server;

    // delete _env.value from _envs

    _environments.remove(_activeEnv!.server);

    // write _envs to secure storage

    final jsonEnvs = json.encode(_environments);

    await AppSecureStorage()
        .setString(SecureStorageKey.environments.value, jsonEnvs);

    // if there are environments left in _envs, set the last one as value

    if (_environments.isNotEmpty) {
      _activeEnv = _environments.values.last;

      _defaultEnv = _environments.keys.last;

      logger.i('Env $deletedEnvironment New defaultEnv: $_defaultEnv');

      //  locator<ApiClient>().setBaseUrl(_activeEnv!.serverUrl);
    } else {
      // if there are no environments left, delete the environments from secure storage

      await AppSecureStorage().remove(SecureStorageKey.environments.value);

      _activeEnv = null;

      _defaultEnv = '';

      _envReady.value = false;
    }
  }

  Future<void> activateEnv({required String envName}) async {
    _activeEnv = _environments[envName]!;

    final updatedEnvsForStorage = EnvsInStorage(
        defaultEnv: _activeEnv!.server, environmentsMap: _environments);

    final String jsonEnvs = jsonEncode(updatedEnvsForStorage);

    await AppSecureStorage()
        .setString(SecureStorageKey.environments.value, jsonEnvs);

    _defaultEnv = envName;

    _envReady.value = true;

    logger.i('Activated Env: ${_activeEnv!.server}');

    if (_dependentMangagersRegistered.value == true) {
      di<NotificationService>().setNewInstanceLoadingValue(true);

      // await SessionHelper.clearInstanceSessionServerData();

      // locator<SessionManager>().unauthenticate();

      // await locator<SessionManager>().checkStoredCredentials();

      //await propagateNewEnv();
    }
  }

  setEnvNotReady() {
    _envReady.value = false;
    _activeEnv = null;
  }

  Future<void> generateNewKeys(
      {required String serverUrl, required String serverName}) async {
    String generateUtf8String(int length) {
      const chars =
          'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      final random = math.Random.secure();
      return List.generate(
          length, (index) => chars[random.nextInt(chars.length)]).join();
    }

    final key = generateUtf8String(32);

    final iv = generateUtf8String(16);

    final String schoolKey = jsonEncode(
        {"server": serverName, "key": key, "iv": iv, "server_url": serverUrl});

    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      // Save the file in the selected directory
      final schoolKeyFile =
          File('$selectedDirectory/school_key_$serverName.txt');
      await schoolKeyFile.writeAsString(schoolKey);
    } else {
      di<NotificationService>()
          .showSnackBar(NotificationType.error, 'Aktion abgebrochen');
    }
    return;
  }
}
