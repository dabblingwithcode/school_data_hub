import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/utils/logger.dart';
import 'package:school_data_hub_flutter/common/utils/secure_storage.dart';
import 'package:school_data_hub_flutter/core/dependency_injection.dart';
import 'package:school_data_hub_flutter/core/env/models/enums.dart';
import 'package:school_data_hub_flutter/core/env/models/env.dart';
import 'package:school_data_hub_flutter/core/models/populated_server_session_data.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

class EnvManager {
  bool _dependentMangagersRegistered = false;
  bool get dependentManagersRegistered => _dependentMangagersRegistered;

  /// we need to observe in [MaterialApp] if a user is authenticated
  /// without accessing [ServerpodSessionManager], because if there is not
  // an active env yet, it will still be unregistered.
  /// So this is a workaround setting a flag here
  /// that should be changed every time there is an authentication change
  /// in the [ServerpodSessionManager].
  final _isUserAuthenticated = ValueNotifier<bool>(false);
  ValueListenable<bool> get isUserAuthenticated => _isUserAuthenticated;

  void setUserAuthenticated(bool value) {
    _isUserAuthenticated.value = value;
  }

  final _activeEnvRunMode = ValueNotifier<HubRunMode>(HubRunMode.development);
  ValueListenable<HubRunMode> get activeEnvRunMode => _activeEnvRunMode;

  Env? _activeEnv;

  Env? get activeEnv => _activeEnv;

  Map<String, Env> _environments = {};
  Map<String, Env> get envs => _environments;

  String _defaultEnv = '';
  String get defaultEnv => _defaultEnv;

  final _envIsReady = ValueNotifier<bool>(false);
  ValueListenable<bool> get envIsReady => _envIsReady;

  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  PackageInfo get packageInfo => _packageInfo;

  /// With [PopulatedServerSessionData] we are monitoring
  /// if  important data for the server session is populated -
  /// Without them, other features won't work properly.
  /// We nag with a notification until all data is populated.
  PopulatedServerSessionData _populatedEnvServerData =
      PopulatedServerSessionData(
          schoolSemester: false,
          schooldays: false,
          competences: false,
          supportCategories: false);

  PopulatedServerSessionData get populatedEnvServerData =>
      _populatedEnvServerData;

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

  bool isAnyImportantEnvDataNotPopulatedInServer() {
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
    _dependentMangagersRegistered = value;
    log('EnvManager - dependentManagersRegistered: $value');
  }

  Future<void> firstRun() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _packageInfo = packageInfo;

    final EnvsInStorage? environmentsObject = await environmentsInStorage();

    if (environmentsObject == null) {
      _envIsReady.value = false;
      return;
    }

    _defaultEnv = environmentsObject.defaultEnv;

    _environments = environmentsObject.environmentsMap;

    _activeEnv = environmentsObject.environmentsMap[_defaultEnv];

    log('Default Environment: $_defaultEnv');

    // set the base url for the api client

    // di<ApiClient>().setBaseUrl(_activeEnv!.serverUrl);

    _envIsReady.value = true;
    await DiManager.registerManagersDependingOnActiveEnv();
    setDependentManagersRegistered(true);
    return;
  }

  Future<EnvsInStorage?> environmentsInStorage() async {
    bool environmentsInStorage = await ServerpodSecureStorage()
        .containsKey(SecureStorageKey.environments.value);

    if (environmentsInStorage == true) {
      final String? storedEnvironmentsAsString = await ServerpodSecureStorage()
          .getString(SecureStorageKey.environments.value);

      try {
        final environmentsInStorage = EnvsInStorage.fromJson(
            json.decode(storedEnvironmentsAsString!) as Map<String, dynamic>);

        return environmentsInStorage;
      } catch (e) {
        logger.f('Error reading env from secureStorage: $e',
            stackTrace: StackTrace.current);

        log('deleting faulty environments from secure storage');

        await ServerpodSecureStorage()
            .remove(SecureStorageKey.environments.value);

        return null;
      }
    }

    return null;
  }

  // set the environment from a string
  void importNewEnv(String envAsString) async {
    // decode the json string to an Env object
    final Env env =
        Env.fromJson(json.decode(envAsString) as Map<String, dynamic>);

    // add the env to the environments map
    _environments = {..._environments, env.name: env};

    log('Environment ${env.name} added to environments map in memory');

    // the modified environments map will be stored
    // in the [activateEnv] method
    activateEnv(envName: env.name);

    return;
  }

  deleteEnv() async {
    final deletedEnvironment = _activeEnv!.name;

    // delete _env.value from _envs

    _environments.remove(_activeEnv!.name);

    // write _envs to secure storage

    final jsonEnvs = json.encode(_environments);

    await ServerpodSecureStorage()
        .setString(SecureStorageKey.environments.value, jsonEnvs);

    // if there are environments left in _envs, set the last one as value

    if (_environments.isNotEmpty) {
      _activeEnv = _environments.values.last;

      _defaultEnv = _environments.keys.last;
      resetManagersDependentOnEnv();
      logger.i('Env $deletedEnvironment New defaultEnv: $_defaultEnv');

      //  di<ApiClient>().setBaseUrl(_activeEnv!.serverUrl);
    } else {
      // if there are no environments left, delete the environments from secure storage

      await ServerpodSecureStorage()
          .remove(SecureStorageKey.environments.value);
      DiManager.unregisterManagersDependingOnActiveEnv();
      _activeEnv = null;

      _defaultEnv = '';

      _envIsReady.value = false;
    }
  }

  Future<void> activateEnv({required String envName}) async {
    _activeEnv = _environments[envName]!;

    _defaultEnv = envName;

    // The active environment changed, we need to update
    // this information in storage
    final updatedEnvsForStorage = EnvsInStorage(
        defaultEnv: _activeEnv!.name, environmentsMap: _environments);

    final String jsonEnvs = jsonEncode(updatedEnvsForStorage);

    // write the updated environments to secure storage
    await ServerpodSecureStorage()
        .setString(SecureStorageKey.environments.value, jsonEnvs);

    _envIsReady.value = true;

    log('Activated Env: ${_activeEnv!.name}');

    logger.i(
        'New Env $envName stored, there are now ${_environments.length} environments stored!');

    di<NotificationService>().showSnackBar(
        NotificationType.success, 'Schulschlüssel für $envName gespeichert!');

    // Check if there are any dependent managers registered
    // and if so, unregister them
    // and register them again with the new environment
    if (dependentManagersRegistered) {
      await resetManagersDependentOnEnv();
    } else {
      await DiManager.registerManagersDependingOnActiveEnv();
    }
    // Set the isAuthenticated flag to false
    // because the user is not authenticated in the new environment (yet)
    // and we need to show the login screen again
    _isUserAuthenticated.value = false;
  }

  void setEnvNotReady() {
    _envIsReady.value = false;
    _activeEnv = null;
  }

  Future<void> resetManagersDependentOnEnv() async {
    await DiManager.unregisterManagersDependingOnActiveEnv();
    await DiManager.registerManagersDependingOnActiveEnv();
  }

  Future<void> propagateNewEnv() async {
    // TODO: implement this if needed
    await di<PupilIdentityManager>().getPupilIdentitiesForEnv();
  }

  Future<void> generateNewEnvKeys(
      {required String serverUrl, required String serverName}) async {
    String generateRandomUtf8StringOfLength(int length) {
      const chars =
          'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      final random = math.Random.secure();
      return List.generate(
          length, (index) => chars[random.nextInt(chars.length)]).join();
    }

    final key = generateRandomUtf8StringOfLength(32);

    final iv = generateRandomUtf8StringOfLength(16);

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

  Future<({String deviceId, String deviceName})> getDeviceNameAndId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      return (
        deviceName: windowsInfo.computerName,
        deviceId: windowsInfo.deviceId
      );
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return (
        deviceName: androidInfo.model,
        deviceId: androidInfo.id,
      );
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return (
        deviceName: iosInfo.name,
        deviceId: iosInfo.modelName,
      );
    } else {
      return (
        deviceId: 'Unknown Device',
        deviceName: 'Unknown Device',
      );
    }
  }
}
