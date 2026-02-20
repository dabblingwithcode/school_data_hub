import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/data/matrix_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_event_report.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/policy.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_manager.dart';

class MatrixPolicyManager {
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
      );

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

  MatrixCredentials exportMatrixCredentialsForTransfer() {
    final normalizedUrl = _matrixUrl.replaceFirst(RegExp(r'^https?://'), '');
    return MatrixCredentials(
      url: normalizedUrl,
      matrixToken: _matrixToken,
      policyToken: _corporalToken,
      matrixAdmin: _matrixAdminId ?? '',
      encryptionKey: _encryptionKey,
      encryptionIv: _encryptionIv,
    );
  }

  String exportMatrixCredentialsJsonForTransfer() {
    return jsonEncode(exportMatrixCredentialsForTransfer().toJson());
  }

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

  final _eventReports = ValueNotifier<List<MatrixEventReport>>([]);
  ValueListenable<List<MatrixEventReport>> get eventReports => _eventReports;

  final _eventReportsLoading = ValueNotifier<bool>(false);
  ValueListenable<bool> get eventReportsLoading => _eventReportsLoading;

  final _eventReportsLoadingMore = ValueNotifier<bool>(false);
  ValueListenable<bool> get eventReportsLoadingMore => _eventReportsLoadingMore;

  final _eventReportsTotal = ValueNotifier<int>(0);
  ValueListenable<int> get eventReportsTotal => _eventReportsTotal;

  final _eventReportsError = ValueNotifier<String?>(null);
  ValueListenable<String?> get eventReportsError => _eventReportsError;

  int? _eventReportsNextToken;
  int? get eventReportsNextToken => _eventReportsNextToken;

  String _eventReportsDir = 'b';
  String get eventReportsDir => _eventReportsDir;

  String? _eventReportsUserIdFilter;
  String? get eventReportsUserIdFilter => _eventReportsUserIdFilter;

  String? _eventReportsRoomIdFilter;
  String? get eventReportsRoomIdFilter => _eventReportsRoomIdFilter;

  String? _eventReportsSenderUserIdFilter;
  String? get eventReportsSenderUserIdFilter => _eventReportsSenderUserIdFilter;

  int _eventReportsPageLimit = 50;
  int get eventReportsPageLimit => _eventReportsPageLimit;

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

  void dispose() {
    _roomManager.dispose();
    _userManager.dispose();
    _policyPendingChanges.dispose();
    _eventReports.dispose();
    _eventReportsLoading.dispose();
    _eventReportsLoadingMore.dispose();
    _eventReportsTotal.dispose();
    _eventReportsError.dispose();
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
    await di.dropScope(InitScope.onMatrixEnvScope.name);

    _sessionManager.changeMatrixPolicyManagerRegistrationStatus(false);
    _notificationService.showSnackBar(
      NotificationType.success,
      'Matrix-Räumeverwaltung deaktiviert',
    );
  }

  Future<void> fetchMatrixPolicy() async {
    _log.info('Fetching Matrix policy...');
    Policy? policy;
    try {
      policy = await _matrixApiService.fetchMatrixPolicy();
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden der Matrix-Räumeverwaltung',
      );
      _log.severe('Error fetching Matrix policy: $e');
      return;
    }
    if (policy == null) {
      _log.severe('Error fetching Matrix policy!');
      return;
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Matrix-Räumeverwaltung geladen',
    );

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

    try {
      await _matrixApiService.putMatrixPolicy();
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Setzen der Policy',
      );
      _log.severe('Error applying Matrix policy changes: $e');
      return;
    }

    _notificationService.showSnackBar(
      NotificationType.success,
      'Policy erfolgreich gesetzt',
    );

    di<MatrixPolicyFilterManager>().resetAllMatrixFilters();
    _policyPendingChanges.value = false;
  }

  // Message API methods
  Future<Map<String, String>> sendDirectTextMessage({
    required String targetUserId,
    required String text,
    String? transactionId,
  }) async {
    _log.info('Sending direct text message to $targetUserId');
    _log.info('targetUserId: $targetUserId');
    _log.info('text: $text');
    _log.info('transactionId: $transactionId');

    try {
      final purgedRooms = await _matrixApiService.cleanupAdminOnlyDirectRooms(
        currentUserId: _matrixAdminId!,
      );
      if (purgedRooms > 0) {
        _log.info('Purged $purgedRooms orphan direct rooms before DM send');
      }

      // First, check if there's already an existing direct message room
      // This checks both the sender's and receiver's account data
      _log.info('Checking for existing direct message room...');
      final roomId = await _matrixApiService.getOrCreateDirectMessageRoom(
        targetUserId: targetUserId,
        currentUserId: _matrixAdminId!,
      );
      _log.info('Using room ID: $roomId');

      // Ensure admin is in the room before sending
      // (This is handled internally by the API service, but we log it here for clarity)
      _log.info('Sending message to existing/created room: $roomId');

      // Send the message to the room
      final response = await _matrixApiService.sendTextMessage(
        roomId: roomId,
        text: text,
        transactionId: transactionId,
      );

      final result = {'eventId': response.eventId, 'roomId': roomId};

      _log.info('MatrixPolicyManager.sendDirectTextMessage result: $result');
      return result;
    } catch (e, stackTrace) {
      _log.severe('MatrixPolicyManager.sendDirectTextMessage error: $e');
      _log.severe(
        'MatrixPolicyManager.sendDirectTextMessage stackTrace: $stackTrace',
      );
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

  Future<void> refreshEventReports({
    int? limit,
    String? dir,
    String? userId,
    String? roomId,
    String? eventSenderUserId,
  }) async {
    if (_eventReportsLoading.value) {
      return;
    }

    if (limit != null && limit > 0) {
      _eventReportsPageLimit = limit;
    }
    if (dir != null && (dir == 'b' || dir == 'f')) {
      _eventReportsDir = dir;
    }

    _eventReportsUserIdFilter = userId;
    _eventReportsRoomIdFilter = roomId;
    _eventReportsSenderUserIdFilter = eventSenderUserId;

    _eventReportsLoading.value = true;
    _eventReportsError.value = null;

    try {
      final response = await _matrixApiService.fetchEventReports(
        from: 0,
        limit: _eventReportsPageLimit,
        dir: _eventReportsDir,
        userId: _eventReportsUserIdFilter,
        roomId: _eventReportsRoomIdFilter,
        eventSenderUserId: _eventReportsSenderUserIdFilter,
      );

      _eventReports.value = response.eventReports;
      _eventReportsTotal.value = response.total;
      _eventReportsNextToken = response.nextToken;
    } catch (e) {
      _eventReportsError.value = 'Fehler beim Laden der Event Reports';
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden der Event Reports',
      );
      _log.severe('Error refreshing event reports: $e');
    } finally {
      _eventReportsLoading.value = false;
    }
  }

  Future<void> loadMoreEventReports() async {
    final nextToken = _eventReportsNextToken;
    if (nextToken == null ||
        _eventReportsLoading.value ||
        _eventReportsLoadingMore.value) {
      return;
    }

    _eventReportsLoadingMore.value = true;
    _eventReportsError.value = null;

    try {
      final response = await _matrixApiService.fetchEventReports(
        from: nextToken,
        limit: _eventReportsPageLimit,
        dir: _eventReportsDir,
        userId: _eventReportsUserIdFilter,
        roomId: _eventReportsRoomIdFilter,
        eventSenderUserId: _eventReportsSenderUserIdFilter,
      );

      _eventReports.value = [..._eventReports.value, ...response.eventReports];
      _eventReportsTotal.value = response.total;
      _eventReportsNextToken = response.nextToken;
    } catch (e) {
      _eventReportsError.value = 'Fehler beim Laden weiterer Event Reports';
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden weiterer Event Reports',
      );
      _log.severe('Error loading more event reports: $e');
    } finally {
      _eventReportsLoadingMore.value = false;
    }
  }

  Future<MatrixEventReportDetail?> fetchEventReportDetail(int reportId) async {
    try {
      return await _matrixApiService.fetchEventReportDetail(reportId);
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden des Event Report Details',
      );
      _log.severe('Error fetching event report detail for $reportId: $e');
      return null;
    }
  }

  Future<bool> deleteEventReport(int reportId) async {
    try {
      await _matrixApiService.deleteEventReport(reportId);

      _eventReports.value = _eventReports.value
          .where((report) => report.id != reportId)
          .toList();

      if (_eventReportsTotal.value > 0) {
        _eventReportsTotal.value = _eventReportsTotal.value - 1;
      }

      _notificationService.showSnackBar(
        NotificationType.success,
        'Event Report gelöscht',
      );
      return true;
    } catch (e) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Löschen des Event Reports',
      );
      _log.severe('Error deleting event report $reportId: $e');
      return false;
    }
  }
}
