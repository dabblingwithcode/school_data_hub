import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/di/dependency_injection.dart';
import 'package:school_data_hub_flutter/core/env/models/enums.dart';
import 'package:school_data_hub_flutter/core/env/models/env.dart';
import 'package:school_data_hub_flutter/core/models/populated_server_session_data.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:watch_it/watch_it.dart';

class EnvManager with ChangeNotifier {
  final _log = Logger('EnvManager');

  final _notificationService = di<NotificationService>();

  bool _dependentMangagersRegistered = false;
  bool get dependentManagersRegistered => _dependentMangagersRegistered;

  final _isAuthenticated = ValueNotifier<bool>(false);

  // TODO ADVICE: Decouple encryption key for allowing login
  // - And transfer encryption keys over stream as with the pupil identities
  // - with additional one-time password to access the stream

  /// TODO ADVICE: is this proxy authentication flag a hack or is this acceptable?
  /// We need to observe in [MaterialApp] if a user is authenticated
  /// without accessing [HubSessionManager], because if there is not
  // an active env yet, it will still be unregistered.
  /// So this is a workaround setting a flag here
  /// **CAUTION**
  /// Handle this value only with [HubSessionManager] every time
  /// it makes an authentication status change.
  ValueListenable<bool> get isAuthenticated => _isAuthenticated;

  /// **WARNING:**
  ///
  /// This method should only be called from [HubSessionManager]
  void setUserAuthenticatedOnlyByHubSessionManager(bool value) {
    _log.info('setUserAuthenticated: $value');
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

  String get storageKeyForAuthKey =>
      '${_activeEnv!.serverName}_${_activeEnv!.runMode.name}_hub_auth_key';

  String get storageKeyForUserInfo =>
      '${_activeEnv!.serverName}_${_activeEnv!.runMode.name}_hub_user_info';

  String get storageKeyForPupilIdentities =>
      '${_activeEnv!.serverName}_${_activeEnv!.runMode.name}_pupil_identities';

  String get storageKeyForMatrixCredentials =>
      '${_activeEnv!.serverName}_${_activeEnv!.runMode.name}_matrix_credentials';

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
        supportCategories: false,
      );

  PopulatedServerSessionData get populatedEnvServerData =>
      _populatedEnvServerData;

  void setPopulatedEnvServerData({
    bool? schoolSemester,
    bool? schooldays,
    bool? competences,
    bool? supportCategories,
  }) {
    final data = _populatedEnvServerData.copyWith(
      schoolSemester: schoolSemester ?? _populatedEnvServerData.schoolSemester,
      schooldays: schooldays ?? _populatedEnvServerData.schooldays,
      competences: competences ?? _populatedEnvServerData.competences,
      supportCategories:
          supportCategories ?? _populatedEnvServerData.supportCategories,
    );
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
        await _environmentsInStorage();

    if (environmentsMapWithDefaultServerEnv == null) {
      _envIsReady.value = false;
      return;
    }

    _defaultEnv = environmentsMapWithDefaultServerEnv.defaultEnv;

    _environments = environmentsMapWithDefaultServerEnv.environmentsMap;

    _activeEnv =
        environmentsMapWithDefaultServerEnv.environmentsMap[_defaultEnv];
    notifyListeners();
    _log.info('Default Environment set: $_defaultEnv');

    _envIsReady.value = true;
    await DiManager.registerManagersOnActiveEnvScope();
    setDependentManagersRegistered(true);

    if (await HubSecureStorage().containsKey(storageKeyForMatrixCredentials)) {
      final matrixCredentialsJson = await HubSecureStorage().getString(
        storageKeyForMatrixCredentials,
      );
      final matrixCredentials = MatrixCredentials.fromJson(
        json.decode(matrixCredentialsJson!) as Map<String, dynamic>,
      );
      DiManager.registerMatrixManagers(matrixCredentials);
    }
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
    _log.info('dependentManagersRegistered: $value');
  }

  Future<EnvsInStorage?> _environmentsInStorage() async {
    try {
      bool environmentsInStorage = await HubSecureStorage().containsKey(
        _storageKeyForEnvironments,
      );

      if (environmentsInStorage == true) {
        final String? storedEnvironmentsAsString = await HubSecureStorage()
            .getString(_storageKeyForEnvironments);

        if (storedEnvironmentsAsString == null) {
          _log.warning('No environments data found in storage');
          return null;
        }

        try {
          final environmentsInStorage = EnvsInStorage.fromJson(
            json.decode(storedEnvironmentsAsString) as Map<String, dynamic>,
          );

          return environmentsInStorage;
        } catch (e) {
          _log.severe(
            'Error parsing environments from secureStorage: $e',
            StackTrace.current,
          );

          _log.warning('deleting faulty environments from secure storage');

          try {
            await HubSecureStorage().remove(_storageKeyForEnvironments);
          } catch (removeError) {
            _log.warning('Could not remove faulty environments: $removeError');
          }

          return null;
        }
      }
    } catch (e) {
      _log.severe(
        'Error accessing secure storage for environments: $e',
        StackTrace.current,
      );

      // Don't throw the error, just return null to allow app to continue
      return null;
    }

    return null;
  }

  // set the environment from a string
  void importNewEnv(String envAsString) async {
    // decode the json string to an Env object
    final Env env = Env.fromJson(
      json.decode(envAsString) as Map<String, dynamic>,
    );

    // add the env to the environments map
    _environments = {..._environments, env.serverName: env};

    _log.info(
      'Environment ${env.serverName} added to environments map in memory',
    );

    // the modified environments map will be stored
    // in the [activateEnv] method
    activateEnv(envName: env.serverName);

    return;
  }

  Future<void> updateActiveEnv({
    String? serverName,
    HubRunMode? runMode,
    String? key,
    String? iv,
    DateTime? lastIdentitiesUpdate,
  }) async {
    if (_activeEnv == null) {
      _log.warning('No active environment set, cannot update it.');
      return;
    }
    _activeEnv = _activeEnv!.copyWith(
      serverName: serverName ?? _activeEnv!.serverName,
      runMode: runMode ?? _activeEnv!.runMode,
      key: key ?? _activeEnv!.key,
      iv: iv ?? _activeEnv!.iv,
      lastIdentitiesUpdate:
          lastIdentitiesUpdate ?? _activeEnv!.lastIdentitiesUpdate,
    );
    _environments[_activeEnv!.serverName] = _activeEnv!;
    notifyListeners();
    // The active environment changed, we need to update
    // this information in storage
    final updatedEnvsForStorage = EnvsInStorage(
      defaultEnv: _activeEnv!.serverName,
      environmentsMap: _environments,
    );

    final String jsonEnvs = jsonEncode(updatedEnvsForStorage.toJson());

    // write the updated environments to secure storage
    await HubSecureStorage().setString(_storageKeyForEnvironments, jsonEnvs);
    _log.info('Active environment updated: ${_activeEnv!.serverName}');
  }

  Future<void> activateEnv({required String envName}) async {
    _log.info('Activating environment: $envName');

    // 1. Reset or drop managers holding data from the old env
    _log.info(
      '[DI] Dropping logged in user scope to reset user-dependent managers',
    );
    await DiManager.dropOnLoggedInUserScope();

    // Reset environment-dependent managers
    _log.info('[DI] Resetting active environment dependent managers');
    await DiManager.resetActiveEnvDependentManagers();

    // 2. Set the selected env as active
    _activeEnv = _environments[envName]!;
    _defaultEnv = envName;

    _log.info('Environment set as active: ${_activeEnv!.serverName}');

    // Update storage with new environment configuration
    final updatedEnvsForStorage = EnvsInStorage(
      defaultEnv: _activeEnv!.serverName,
      environmentsMap: _environments,
    );

    final String jsonEnvs = jsonEncode(updatedEnvsForStorage);
    await HubSecureStorage().setString(_storageKeyForEnvironments, jsonEnvs);

    // Register managers for the new environment
    _log.info('[DI] Registering managers for new environment');
    await DiManager.registerManagersOnActiveEnvScope();
    setDependentManagersRegistered(true);

    // Handle matrix credentials if they exist
    if (await HubSecureStorage().containsKey(storageKeyForMatrixCredentials)) {
      final matrixCredentialsJson = await HubSecureStorage().getString(
        storageKeyForMatrixCredentials,
      );
      final matrixCredentials = MatrixCredentials.fromJson(
        json.decode(matrixCredentialsJson!) as Map<String, dynamic>,
      );
      DiManager.registerMatrixManagers(matrixCredentials);
    }

    // Wait for all DI registrations to be ready
    _log.info('[DI] Waiting for all managers to be ready...');
    await di.allReady();

    // Set environment as ready
    _envIsReady.value = true;
    notifyListeners();

    _log.info('Environment activated and ready: ${_activeEnv!.serverName}');

    // 3. Check if credentials are stored - if so, log in
    // Add a small delay to ensure everything is properly initialized
    await Future.delayed(const Duration(milliseconds: 100));
    await _checkAndAttemptAutoLogin();

    // 4. Register user-dependent managers if auto-login was successful
    // This ensures UI components can access auth-dependent managers like PupilsFilter
    if (_isAuthenticated.value) {
      _log.info(
        '[DI] User is authenticated, registering user-dependent managers',
      );
      await DiManager.registerManagersDependingOnAuthedSession();
    }

    // Show success notification after everything is set up
    _notificationService.showSnackBar(
      NotificationType.success,
      'Umgebung ${_activeEnv!.serverName} aktiviert!',
    );
  }

  /// Check for stored credentials and attempt auto-login
  Future<void> _checkAndAttemptAutoLogin() async {
    try {
      // Check if auth key exists for this environment
      if (await HubSecureStorage().containsKey(storageKeyForAuthKey)) {
        _log.info('Found stored auth key, attempting auto-login');

        // Check if user info is also stored
        if (await HubSecureStorage().containsKey(storageKeyForUserInfo)) {
          _log.info('Found stored user info, attempting to restore session');

          try {
            // Check if session manager is available and ready
            if (!di.isRegistered<HubSessionManager>()) {
              _log.warning(
                'Session manager not registered yet, skipping auto-login',
              );
              _isAuthenticated.value = false;
              return;
            }

            // Try to get the session manager - this will throw if not ready
            final sessionManager = di<HubSessionManager>();

            // The session manager should handle the auto-login
            // This will set the authentication status appropriately
            await sessionManager.initialize();

            _log.info('Auto-login completed successfully');
          } catch (sessionError) {
            if (sessionError.toString().contains('not ready yet')) {
              _log.warning(
                'Session manager not ready yet, skipping auto-login: $sessionError',
              );
            } else {
              _log.warning(
                'Session manager error, skipping auto-login: $sessionError',
              );
            }
            // Ensure authentication status is false
            _isAuthenticated.value = false;
          }
        } else {
          _log.warning('Auth key found but no user info, clearing auth key');
          await HubSecureStorage().remove(storageKeyForAuthKey);
          _isAuthenticated.value = false;
        }
      } else {
        _log.info(
          'No stored credentials found, user will need to log in manually',
        );
        // Ensure authentication status is false
        _isAuthenticated.value = false;
      }
    } catch (e) {
      _log.severe('Error during auto-login attempt: $e', StackTrace.current);
      // Clear potentially corrupted credentials
      try {
        await HubSecureStorage().remove(storageKeyForAuthKey);
        await HubSecureStorage().remove(storageKeyForUserInfo);
      } catch (clearError) {
        _log.warning('Could not clear corrupted credentials: $clearError');
      }
      // Ensure authentication status is false
      _isAuthenticated.value = false;
    }
  }

  Future<void> deleteNotActivatedEnv(Env env) async {
    await _environments.remove(env.serverName);
    return;
  }

  Future<void> deleteEnv() async {
    final deletedEnvironment = _activeEnv!.serverName;

    // delete _env.value from _envs

    await _environments.remove(_activeEnv!.serverName);

    // write _envs to secure storage

    final jsonEnvs = json.encode(_environments);

    await HubSecureStorage().setString(_storageKeyForEnvironments, jsonEnvs);

    // if there are environments left in _envs, set the last one as value

    if (_environments.isNotEmpty) {
      _activeEnv = _environments.values.last;

      _defaultEnv = _environments.keys.last;
      _log.info('Env $deletedEnvironment New defaultEnv: $_defaultEnv');

      _notificationService.showSnackBar(
        NotificationType.success,
        'Schulschlüssel für $deletedEnvironment gelöscht!',
      );

      // reset the managers depending on the active environment
      _log.info(
        '[DI] Resetting active environment dependent managers after deleting environment $deletedEnvironment',
      );
      DiManager.resetActiveEnvDependentManagers();
    } else {
      // if there are no environments left, delete the environments from secure storage

      await HubSecureStorage().remove(_storageKeyForEnvironments);
      _log.info(
        '[DDI]Env $deletedEnvironment deleted. No environments left. Unregistering dependent managers.',
      );
      DiManager.unregisterManagersDependentOnEnv();
      _activeEnv = null;

      _defaultEnv = '';

      _envIsReady.value = false;
    }
  }

  //   Future<void> propagateNewEnv() async {
  //     final _pupilIdentityManager = di<PupilIdentityManager>();
  //     // TODO: implement this if needed
  //     await _pupilIdentityManager.getPupilIdentitiesForEnv();
  //   }
}
