import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/dependency_injection.dart';
import 'package:school_data_hub_flutter/core/env/models/env.dart';
import 'package:school_data_hub_flutter/core/models/populated_server_session_data.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

class EnvManager {
  //- Dependency injection
  final log = Logger('EnvManager');
  final notificationService = di<NotificationService>();

  bool _dependentMangagersRegistered = false;
  bool get dependentManagersRegistered => _dependentMangagersRegistered;

  /// TODO: is this proxy authentication flag a hack or is this acceptable?
  /// We need to observe in [MaterialApp] if a user is authenticated
  /// without accessing [ServerpodSessionManager], because if there is not
  // an active env yet, it will still be unregistered.
  /// So this is a workaround setting a flag here
  /// ! CAUTION !
  /// Handle this value only with [ServerpodSessionManager] every time
  /// it makes an authentication status change.
  final _isAuthenticated = ValueNotifier<bool>(false);
  ValueListenable<bool> get isAuthenticated => _isAuthenticated;

  /// **WARNING:**
  ///
  /// This method should only be called from [ServerpodSessionManager]
  void setUserAuthenticated(bool value) {
    _isAuthenticated.value = value;
  }

  Env? _activeEnv;

  Env? get activeEnv => _activeEnv;

  Map<String, Env> _environments = {};
  Map<String, Env> get envs => _environments;

  String _defaultEnv = '';
  String get defaultEnv => _defaultEnv;

  final _envIsReady = ValueNotifier<bool>(false);
  ValueListenable<bool> get envIsReady => _envIsReady;

  // Declare storage keys for the environment

  final String _storageKeyForEnvironments = 'environments_key';

  String storageKeyForAuthKey() =>
      '${_activeEnv!.serverName}_${_activeEnv!.runMode.name}_hub_auth_key';

  String storageKeyForUserInfo() =>
      '${_activeEnv!.serverName}_${_activeEnv!.runMode.name}_hub_user_info';

  String storageKeyForPupilIdentities() =>
      '${_activeEnv!.serverName}_${_activeEnv!.runMode.name}_pupil_identities';

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

  Future<void> firstRun() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _packageInfo = packageInfo;

    final EnvsInStorage? environmentsMapWithDefaultServerEnv =
        await environmentsInStorage();

    if (environmentsMapWithDefaultServerEnv == null) {
      _envIsReady.value = false;
      return;
    }

    _defaultEnv = environmentsMapWithDefaultServerEnv.defaultEnv;

    _environments = environmentsMapWithDefaultServerEnv.environmentsMap;

    _activeEnv =
        environmentsMapWithDefaultServerEnv.environmentsMap[_defaultEnv];

    log.info(
      'Default Environment set: $_defaultEnv',
    );

    _envIsReady.value = true;
    await DiManager.registerManagersDependingOnActiveEnv();
    setDependentManagersRegistered(true);
    return;
  }

  /// **TODO:** There should be a better way to handle this.
  /// We need to set the environment to not ready
  /// when we add a new environment
  void setEnvNotReady() {
    _envIsReady.value = false;
    _activeEnv = null;
  }

  void setDependentManagersRegistered(bool value) {
    _dependentMangagersRegistered = value;
    log.info(
      'dependentManagersRegistered: $value',
    );
  }

  Future<EnvsInStorage?> environmentsInStorage() async {
    bool environmentsInStorage =
        await ServerpodSecureStorage().containsKey(_storageKeyForEnvironments);

    if (environmentsInStorage == true) {
      final String? storedEnvironmentsAsString =
          await ServerpodSecureStorage().getString(_storageKeyForEnvironments);

      try {
        final environmentsInStorage = EnvsInStorage.fromJson(
            json.decode(storedEnvironmentsAsString!) as Map<String, dynamic>);

        return environmentsInStorage;
      } catch (e) {
        log.severe(
            'Error reading env from secureStorage: $e', StackTrace.current);

        log.warning('deleting faulty environments from secure storage');

        await ServerpodSecureStorage().remove(_storageKeyForEnvironments);

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
    _environments = {..._environments, env.serverName: env};

    log.info(
        'Environment ${env.serverName} added to environments map in memory');

    // the modified environments map will be stored
    // in the [activateEnv] method
    activateEnv(envName: env.serverName);

    return;
  }

  Future<void> activateEnv({required String envName}) async {
    _activeEnv = _environments[envName]!;

    _defaultEnv = envName;

    // The active environment changed, we need to update
    // this information in storage
    final updatedEnvsForStorage = EnvsInStorage(
        defaultEnv: _activeEnv!.serverName, environmentsMap: _environments);

    final String jsonEnvs = jsonEncode(updatedEnvsForStorage);

    // write the updated environments to secure storage
    await ServerpodSecureStorage()
        .setString(_storageKeyForEnvironments, jsonEnvs);

    _envIsReady.value = true;

    log.info('Activated Env: ${_activeEnv!.serverName}');
    log.info('Environments in storage: ${_environments.length}');

    notificationService.showSnackBar(
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
    _isAuthenticated.value = false;
  }

  deleteEnv() async {
    final deletedEnvironment = _activeEnv!.serverName;

    // delete _env.value from _envs

    _environments.remove(_activeEnv!.serverName);

    // write _envs to secure storage

    final jsonEnvs = json.encode(_environments);

    await ServerpodSecureStorage()
        .setString(_storageKeyForEnvironments, jsonEnvs);

    // if there are environments left in _envs, set the last one as value

    if (_environments.isNotEmpty) {
      _activeEnv = _environments.values.last;

      _defaultEnv = _environments.keys.last;
      log.info('Env $deletedEnvironment New defaultEnv: $_defaultEnv');
      resetManagersDependentOnEnv();
    } else {
      // if there are no environments left, delete the environments from secure storage

      await ServerpodSecureStorage().remove(_storageKeyForEnvironments);
      DiManager.unregisterManagersDependingOnActiveEnv();
      _activeEnv = null;

      _defaultEnv = '';

      _envIsReady.value = false;
    }
  }

  Future<void> resetManagersDependentOnEnv() async {
    await DiManager.unregisterManagersDependingOnActiveEnv();
    await DiManager.registerManagersDependingOnActiveEnv();
  }

  Future<void> propagateNewEnv() async {
    // TODO: implement this if needed
    await di<PupilIdentityManager>().getPupilIdentitiesForEnv();
  }
}
