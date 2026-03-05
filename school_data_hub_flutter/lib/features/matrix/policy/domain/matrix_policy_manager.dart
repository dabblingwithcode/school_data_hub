import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/data/matrix_api_service.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/flags.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/hook.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/matrix_credentials.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/matrix_event_report.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/models/policy.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';

class MatrixPolicyManager {
  final _notificationService = di<NotificationService>();

  final _sessionManager = di<HubSessionManager>();

  final _secureStorage = HubSecureStorage();

  final _log = Logger('MatrixPolicyManager');

  MatrixPolicyManager(
    this._matrixUrl,
    this._userServerAddress,
    this._corporalToken,
    this._matrixToken,
    this._matrixAdminId,
    this._encryptionKey,
  ) : _matrixApiService = MatrixApiService(
        matrixUrl: _matrixUrl,
        corporalToken: _corporalToken,
        matrixToken: _matrixToken,
      );

  final _secureStorageKey = di<EnvManager>().storageKeyForMatrixCredentials;

  String _matrixUrl;
  String get matrixUrl => _matrixUrl;

  String? _userServerAddress;
  String? get userServerAddress => _userServerAddress;

  String? _matrixAdminId;
  String? get matrixAdminId => _matrixAdminId;

  String _matrixToken;
  String get matrixToken => 'Bearer $_matrixToken';

  String _corporalToken;
  String get corporalToken => 'Bearer $_corporalToken';

  String _encryptionKey;
  String get encryptionKey => _encryptionKey;

  MatrixCredentials getMatrixCredentials() {
    final normalizedUrl = _matrixUrl.replaceFirst(RegExp(r'^https?://'), '');
    return MatrixCredentials(
      url: normalizedUrl,
      userServerAddress: _userServerAddress ?? '',
      matrixToken: _matrixToken,
      policyToken: _corporalToken,
      matrixAdmin: _matrixAdminId ?? '',
      encryptionKey: _encryptionKey,
    );
  }

  String exportMatrixCredentialsJsonForTransfer() {
    return jsonEncode(getMatrixCredentials().toJson());
  }

  // List<String> _compulsoryRooms;
  // List<String> get compulsoryRooms => _compulsoryRooms;

  Policy? _matrixPolicy;
  Policy? get matrixPolicy => _matrixPolicy;

  bool get isMatrixPolicyLoaded => _matrixPolicy != null;

  // Sub-managers
  late final MatrixRoomManager _roomManager;
  late final MatrixUserManager _userManager;

  MatrixApiService get matrixApiService => _matrixApiService;

  // Expose sub-managers
  MatrixRoomManager get rooms => _roomManager;
  MatrixUserManager get users => _userManager;

  // Delegate to sub-managers for backward compatibility
  ValueListenable<List<MatrixUser>> get matrixUsers => _userManager.matrixUsers;
  ValueListenable<List<MatrixRoom>> get matrixRooms => _roomManager.matrixRooms;

  final _reportedEvents = ValueNotifier<List<MatrixReportedEvent>>([]);
  ValueListenable<List<MatrixReportedEvent>> get reportedEvents =>
      _reportedEvents;

  final _reportedEventsLoading = ValueNotifier<bool>(false);
  ValueListenable<bool> get reportedEventsLoading => _reportedEventsLoading;

  final _reportedEventsLoadingMore = ValueNotifier<bool>(false);
  ValueListenable<bool> get reportedEventsLoadingMore =>
      _reportedEventsLoadingMore;

  final _reportedEventsTotal = ValueNotifier<int>(0);
  ValueListenable<int> get reportedEventsTotal => _reportedEventsTotal;

  final _reportedEventsError = ValueNotifier<String?>(null);
  ValueListenable<String?> get reportedEventsError => _reportedEventsError;

  int? _reportedEventsNextToken;
  int? get reportedEventsNextToken => _reportedEventsNextToken;

  String _reportedEventsDir = 'b';
  String get reportedEventsDir => _reportedEventsDir;

  String? _reportedEventsUserIdFilter;
  String? get reportedEventsUserIdFilter => _reportedEventsUserIdFilter;

  String? _reportedEventsRoomIdFilter;
  String? get reportedEventsRoomIdFilter => _reportedEventsRoomIdFilter;

  String? _reportedEventsSenderUserIdFilter;
  String? get reportedEventsSenderUserIdFilter =>
      _reportedEventsSenderUserIdFilter;

  int _reportedEventsPageLimit = 50;
  int get reportedEventsPageLimit => _reportedEventsPageLimit;

  // TODO: improve lookups with maps

  final _policyPendingChanges = ValueNotifier<bool>(false);
  ValueListenable<bool> get pendingChanges => _policyPendingChanges;

  late final MatrixApiService _matrixApiService;

  Future<MatrixPolicyManager> init() async {
    _notificationService.showSnackBar(
      NotificationType.success,
      'Matrix-Räumeverwaltung wird geladen...',
    );
    _roomManager = MatrixRoomManager(matrixAdminId!, _matrixApiService);
    _userManager = MatrixUserManager(
      _matrixApiService,
      pendingChangesHandler,
      _matrixUrl,
      applyPolicyChanges,
    );

    await fetchMatrixPolicy();
    // Initialize the sub-managers with callback functions instead of direct ValueNotifier access

    return this;
  }

  void dispose() {
    _roomManager.dispose();
    _userManager.dispose();
    _policyPendingChanges.dispose();
    _reportedEvents.dispose();
    _reportedEventsLoading.dispose();
    _reportedEventsLoadingMore.dispose();
    _reportedEventsTotal.dispose();
    _reportedEventsError.dispose();
  }

  void pendingChangesHandler(bool newValue) {
    if (newValue == _policyPendingChanges.value) return;
    _policyPendingChanges.value = newValue;
  }

  void setPolicyFlags(MatrixPolicyFlags flags) {
    if (_matrixPolicy == null) return;
    _matrixPolicy = _matrixPolicy!.copyWith(flags: flags);
  }

  void setPolicyHooks(List<Hook> hooks) {
    if (_matrixPolicy == null) return;
    _matrixPolicy = _matrixPolicy!.copyWith(hooks: hooks);
  }

  Future<void> setMatrixEnvironmentValues({
    required String url,
    String? userServerAddress,
    required String policyToken,
    required String matrixToken,
    required String matrixAdmin,
    required String encryptionKey,
  }) async {
    _matrixUrl = url;
    if (userServerAddress != null) _userServerAddress = userServerAddress;
    _corporalToken = policyToken;
    _matrixToken = matrixToken;
    _matrixAdminId = matrixAdmin;
    _encryptionKey = encryptionKey;

    _secureStorage.setString(
      _secureStorageKey,
      jsonEncode(
        MatrixCredentials(
          url: url,
          userServerAddress: _userServerAddress ?? '',
          matrixToken: matrixToken,
          policyToken: policyToken,
          matrixAdmin: matrixAdmin,
          encryptionKey: encryptionKey,
        ),
      ),
    );

    await fetchMatrixPolicy();
  }

  Future<void> deleteAndDeregisterMatrixPolicyManager() async {
    final bool matrixPolicyManagerIsRegistered =
        di<HubSessionManager>().matrixPolicyManagerRegistrationStatus;
    await _secureStorage.remove(_secureStorageKey);
    if (matrixPolicyManagerIsRegistered) {
      await di.dropScope(InitScope.onMatrixEnvScope.name);
    }

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
    final matrixUsers = policy.matrixUsers;

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
    if (_reportedEventsLoading.value) {
      return;
    }

    if (limit != null && limit > 0) {
      _reportedEventsPageLimit = limit;
    }
    if (dir != null && (dir == 'b' || dir == 'f')) {
      _reportedEventsDir = dir;
    }

    _reportedEventsUserIdFilter = userId;
    _reportedEventsRoomIdFilter = roomId;
    _reportedEventsSenderUserIdFilter = eventSenderUserId;

    _reportedEventsLoading.value = true;
    _reportedEventsError.value = null;

    try {
      final response = await _matrixApiService.fetchEventReports(
        from: 0,
        limit: _reportedEventsPageLimit,
        dir: _reportedEventsDir,
        userId: _reportedEventsUserIdFilter,
        roomId: _reportedEventsRoomIdFilter,
        eventSenderUserId: _reportedEventsSenderUserIdFilter,
      );

      _reportedEvents.value = response.reportedEvents;
      _reportedEventsTotal.value = response.total;
      _reportedEventsNextToken = response.nextToken;
    } catch (e) {
      _reportedEventsError.value = 'Fehler beim Laden der Event Reports';
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden der Event Reports',
      );
      _log.severe('Error refreshing event reports: $e');
    } finally {
      _reportedEventsLoading.value = false;
    }
  }

  Future<void> loadMoreEventReports() async {
    final nextToken = _reportedEventsNextToken;
    if (nextToken == null ||
        _reportedEventsLoading.value ||
        _reportedEventsLoadingMore.value) {
      return;
    }

    _reportedEventsLoadingMore.value = true;
    _reportedEventsError.value = null;

    try {
      final response = await _matrixApiService.fetchEventReports(
        from: nextToken,
        limit: _reportedEventsPageLimit,
        dir: _reportedEventsDir,
        userId: _reportedEventsUserIdFilter,
        roomId: _reportedEventsRoomIdFilter,
        eventSenderUserId: _reportedEventsSenderUserIdFilter,
      );

      _reportedEvents.value = [
        ..._reportedEvents.value,
        ...response.reportedEvents,
      ];
      _reportedEventsTotal.value = response.total;
      _reportedEventsNextToken = response.nextToken;
    } catch (e) {
      _reportedEventsError.value = 'Fehler beim Laden weiterer Event Reports';
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Laden weiterer Event Reports',
      );
      _log.severe('Error loading more event reports: $e');
    } finally {
      _reportedEventsLoadingMore.value = false;
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

      _reportedEvents.value = _reportedEvents.value
          .where((report) => report.id != reportId)
          .toList();

      if (_reportedEventsTotal.value > 0) {
        _reportedEventsTotal.value = _reportedEventsTotal.value - 1;
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
