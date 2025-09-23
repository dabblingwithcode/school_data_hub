import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/di/dependency_injection.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/data/matrix_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/policy.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_manager.dart';
import 'package:watch_it/watch_it.dart';

class MatrixPolicyManager extends ChangeNotifier {
  final _notificationService = di<NotificationService>();

  final _sessionManager = di<HubSessionManager>();

  final _secureStorage = HubSecureStorage();

  final _log = Logger('MatrixPolicyManager');

  MatrixPolicyManager(
    this._matrixUrl,
    this._corporalToken,
    this._matrixToken,
    this._matrixAdminId,
    this._encryptionKey,
    this._encryptionIv,
  ) : _matrixApiService = MatrixApiService(
        matrixUrl: _matrixUrl,
        corporalToken: _corporalToken,
        matrixToken: _matrixToken,
      ) {}

  final _secureStorageKey = di<EnvManager>().storageKeyForMatrixCredentials;

  late final String _matrixUrl;
  String get matrixUrl => _matrixUrl;

  String? _matrixAdminId;
  String? get matrixAdminId => _matrixAdminId;

  String _matrixToken;
  String get matrixToken => 'Bearer $_matrixToken';

  String _corporalToken;
  String get corporalToken => 'Bearer $_corporalToken';

  String _encryptionKey;
  String get encryptionKey => _encryptionKey;
  String _encryptionIv;
  String get encryptionIv => _encryptionIv;

  // List<String> _compulsoryRooms;
  // List<String> get compulsoryRooms => _compulsoryRooms;

  Policy? _matrixPolicy;
  Policy? get matrixPolicy => _matrixPolicy;

  bool get isMatrixPolicyLoaded => _matrixPolicy != null;

  // Sub-managers
  late final MatrixRoomManager _roomManager;
  late final MatrixUserManager _userManager;

  // Expose sub-managers
  MatrixRoomManager get rooms => _roomManager;
  MatrixUserManager get users => _userManager;

  // Delegate to sub-managers for backward compatibility
  ValueListenable<List<MatrixUser>> get matrixUsers => _userManager.matrixUsers;
  ValueListenable<List<MatrixRoom>> get matrixRooms => _roomManager.matrixRooms;

  // TODO: improve lookups with maps

  final _policyPendingChanges = ValueNotifier<bool>(false);
  ValueListenable<bool> get pendingChanges => _policyPendingChanges;

  late final MatrixApiService _matrixApiService;

  Future<MatrixPolicyManager> init() async {
    _notificationService.showSnackBar(
      NotificationType.success,
      'Matrix-Räumeverwaltung wird geladen...',
    );
    _roomManager = MatrixRoomManager(
      matrixAdminId!,
      _matrixApiService,
      pendingChangesHandler,
    );
    _userManager = MatrixUserManager(
      _matrixApiService,
      pendingChangesHandler,
      _matrixUrl,
      applyPolicyChanges,
    );

    // Register MatrixUserManager in DI container for direct access
    di.registerSingleton<MatrixUserManager>(_userManager);

    await fetchMatrixPolicy();
    // Initialize the sub-managers with callback functions instead of direct ValueNotifier access

    return this;
  }

  void clearMatrixCredentials() {
    _matrixUrl = '';
    _corporalToken = '';
    _matrixToken = '';
    _matrixAdminId = null;
    _matrixPolicy = null;
    _encryptionKey = '';
    _encryptionIv = '';
  }

  void pendingChangesHandler(bool newValue) {
    if (newValue == _policyPendingChanges.value) return;
    _policyPendingChanges.value = newValue;
  }

  void setMatrixEnvironmentValues({
    required String url,
    required String policyToken,
    required String matrixToken,
    required String matrixAdmin,
    required String encryptionKey,
    required String encryptionIv,
  }) async {
    _matrixUrl = url;
    _corporalToken = policyToken;
    _matrixToken = matrixToken;
    _matrixAdminId = matrixAdmin;
    _encryptionKey = encryptionKey;
    _encryptionIv = encryptionIv;

    _secureStorage.setString(
      _secureStorageKey,
      jsonEncode(
        MatrixCredentials(
          url: url,
          matrixToken: matrixToken,
          policyToken: policyToken,
          matrixAdmin: matrixAdmin,
          encryptionKey: encryptionKey,
          encryptionIv: encryptionIv,
        ),
      ),
    );

    await fetchMatrixPolicy();
  }

  Future<void> deleteAndDeregisterMatrixPolicyManager() async {
    await _secureStorage.remove(_secureStorageKey);
    di.dropScope(DiScope.onMatrixEnvScope.name);

    _sessionManager.changeMatrixPolicyManagerRegistrationStatus(false);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Matrix-Räumeverwaltung deaktiviert',
    );
  }

  Future<void> fetchMatrixPolicy() async {
    _log.info('Fetching Matrix policy...');
    final Policy? policy = await _matrixApiService.fetchMatrixPolicy();
    if (policy == null) {
      _log.severe('Error fetching Matrix policy!');
      return;
    }

    _matrixPolicy = policy;

    // we get the users from the policy and sort them by name
    final matrixUsers = policy.matrixUsers!;

    matrixUsers.sort((a, b) => a.displayName.compareTo(b.displayName));

    _userManager.setUsers(matrixUsers);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Matrix-Konten geladen! Jetzt die Räume...',
    );

    // Load rooms using the room manager
    await _roomManager.loadRoomsFromPolicy(policy.managedRoomIds);
    _log.info('Fetched Matrix policy!');

    _policyPendingChanges.value = false;

    _sessionManager.changeMatrixPolicyManagerRegistrationStatus(true);

    return;
  }

  Future<void> applyPolicyChanges() async {
    final updatedPolicy = MatrixPolicyHelper.refreshMatrixPolicy();
    _matrixPolicy = updatedPolicy;

    await _matrixApiService.putMatrixPolicy();
    di<MatrixPolicyFilterManager>().resetAllMatrixFilters();
    _policyPendingChanges.value = false;
  }

  // Message API methods
  Future<Map<String, String>> sendDirectTextMessage({
    required String targetUserId,
    required String text,
    String? transactionId,
  }) async {
    log('MatrixPolicyManager.sendDirectTextMessage called');
    log('targetUserId: $targetUserId');
    log('text: $text');
    log('transactionId: $transactionId');

    try {
      final result = await _matrixApiService.sendDirectTextMessage(
        targetUserId: targetUserId,
        text: text,
        transactionId: transactionId,
      );

      log('MatrixPolicyManager.sendDirectTextMessage result: $result');
      return result;
    } catch (e, stackTrace) {
      log('MatrixPolicyManager.sendDirectTextMessage error: $e');
      log('MatrixPolicyManager.sendDirectTextMessage stackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<void> sendTextMessageToRoom({
    required String roomId,
    required String text,
    String? transactionId,
  }) => _matrixApiService.sendTextMessage(
    roomId: roomId,
    text: text,
    transactionId: transactionId,
  );

  Future<List<dynamic>> getRoomMessages({
    required String roomId,
    String? from,
    int limit = 10,
    String dir = 'b',
  }) => _matrixApiService.getRoomMessages(
    roomId: roomId,
    from: from,
    limit: limit,
    dir: dir,
  );
}
