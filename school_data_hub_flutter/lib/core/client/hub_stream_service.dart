import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/env/utils/env_utils.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';

final _log = Logger('HubStreamService');

/// Connection state for the hub stream.
enum HubConnectionState {
  disconnected,
  connecting,
  connected,
  waitingRetry,
  background,
}

/// Local event emitted by [HubStreamService] when stream has reconnected (managers should refetch).
sealed class HubLocalEvent {}

/// Emitted after a successful reconnect; subscribers should refetch their data.
final class HubReconnected extends HubLocalEvent {}

/// Emitted when only specific object types changed during disconnect.
final class HubSelectiveReconnect extends HubLocalEvent {
  final Set<HubObjectType> changedTypes;
  HubSelectiveReconnect(this.changedTypes);
}

/// Given a list of per-type last-change timestamps from the server and
/// the moment this client disconnected, returns the set of [HubObjectType]s
/// that were modified while the client was offline.
///
/// Extracted as a top-level function so it can be unit-tested without
/// standing up [HubStreamService].
Set<HubObjectType> computeChangedTypes(
  List<HubTypeLastUpdate> changeTimes,
  DateTime disconnectedAt,
) {
  return changeTimes
      .where((ct) => ct.changedAt.isAfter(disconnectedAt))
      .map((ct) => ct.objectType)
      .toSet();
}

/// Backoff cap in milliseconds.
const _maxReconnectDelayMs = 30000;
const _initialReconnectDelayMs = 1000;
const _dnsGraceDelayMs = 100;

class HubStreamService with WidgetsBindingObserver {
  HubStreamService() {
    WidgetsBinding.instance.addObserver(this);
  }

  StreamSubscription<dynamic>? _subscription;
  Timer? _reconnectTimer;
  bool _connecting = false;
  bool _appInForeground = true;
  bool _hasReceivedFirstEvent = false;
  int _reconnectDelayMs = _initialReconnectDelayMs;
  bool _disposed = false;
  final _random = Random();
  VoidCallback? _connectivityListener;
  String? _currentDeviceId;
  DateTime? _disconnectedAt;

  final _events = StreamController<Object>.broadcast();

  /// All hub messages (server payloads + [HubReconnected]). Managers subscribe here.
  Stream<Object> get events => _events.stream;

  final _streamActivity = ValueNotifier<bool>(false);
  Timer? _streamActivityTimer;

  /// Briefly true whenever the hub stream receives any event.
  ValueListenable<bool> get streamActivity => _streamActivity;

  void _pingStreamActivity() {
    _streamActivity.value = true;
    _streamActivityTimer?.cancel();
    _streamActivityTimer = Timer(const Duration(milliseconds: 400), () {
      _streamActivity.value = false;
    });
  }

  final _state = ValueNotifier<HubConnectionState>(
    HubConnectionState.disconnected,
  );
  ValueListenable<HubConnectionState> get connectionState => _state;

  /// True when state is [HubConnectionState.connected].
  bool get isConnected => _state.value == HubConnectionState.connected;

  Future<HubStreamService> init() async {
    _currentDeviceId = (await EnvUtils.getDeviceNameAndId()).deviceId;
    _attemptConnect(isReconnect: false);
    final monitor = di<ServerpodConnectivityMonitor>();
    _connectivityListener = () {
      if (_disposed) return;
      if (!monitor.isConnected.value) {
        _log.info('[HUB] connectivity_lost — setting disconnected');
        _connecting = false;
        _cancelReconnectTimer();
        _cleanupSubscription();
        _setState(HubConnectionState.disconnected);
        return;
      }
      if (!_appInForeground || _connecting) return;
      final s = _state.value;
      if (s == HubConnectionState.waitingRetry ||
          s == HubConnectionState.disconnected) {
        _log.info('[HUB] connectivity_restored — attempting reconnect');
        _attemptConnect(isReconnect: true);
      }
    };
    monitor.isConnected.addListener(_connectivityListener!);
    return this;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        _appInForeground = false;
        _setState(HubConnectionState.background);
        _cancelReconnectTimer();
        _cleanupSubscription();
        _log.info('[HUB] App backgrounded — stream disconnected');
        break;
      case AppLifecycleState.resumed:
        _appInForeground = true;
        if (isConnected) {
          _log.info('[HUB] App resumed — already connected, skipping');
          break;
        }
        _log.info('[HUB] App resumed — scheduling reconnect');
        _scheduleReconnect(
          isReconnect: true,
          delayMs: _dnsGraceDelayMs,
          reason: 'app_resumed',
        );
        break;
      case AppLifecycleState.inactive:
        break;
    }
  }

  void _setState(HubConnectionState value) {
    _state.value = value;
  }

  int _withJitter(int baseMs) {
    final jitter = _random.nextInt(301);
    return (baseMs + jitter).clamp(0, _maxReconnectDelayMs);
  }

  void _cancelReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  void _cleanupSubscription() {
    if (_state.value == HubConnectionState.connected) {
      _disconnectedAt = DateTime.now().toUtc();
    }
    _hasReceivedFirstEvent = false;
    final sub = _subscription;
    _subscription = null;
    sub?.cancel();
  }

  Future<Set<HubObjectType>?> _getChangedTypesSinceDisconnect() async {
    if (_disconnectedAt == null) return null;
    try {
      final changeTimes = await di<Client>().hub.getLastChangeTimes();
      return computeChangedTypes(changeTimes, _disconnectedAt!);
    } catch (e) {
      _log.warning('[HUB] Could not fetch change times: $e');
      return null;
    }
  }

  void _scheduleReconnect({
    required bool isReconnect,
    required int delayMs,
    String reason = 'unknown',
  }) {
    if (!_appInForeground || _disposed) return;
    if (_connecting) return;
    if (_reconnectTimer != null) return;
    final delayWithJitter = _withJitter(delayMs);
    _log.info(
      '[HUB] reconnect_scheduled reason=$reason delayMs=$delayWithJitter',
    );
    _reconnectTimer = Timer(Duration(milliseconds: delayWithJitter), () {
      _reconnectTimer = null;
      _attemptConnect(isReconnect: isReconnect);
    });
  }

  void _attemptConnect({required bool isReconnect}) {
    if (!_appInForeground || _disposed || _connecting) return;

    final hasConnectivity =
        di<ServerpodConnectivityMonitor>().isConnected.value;
    if (!hasConnectivity) {
      _log.info('[HUB] No connectivity — waiting for connectivity listener');
      return;
    }

    _connecting = true;
    _cleanupSubscription();

    final serverUrl = di<EnvManager>().activeEnv?.serverUrl ?? 'unknown';
    final host = Uri.tryParse(serverUrl)?.host ?? serverUrl;
    _log.info(
      '[HUB] connect_attempt host=$host backoffMs=$_reconnectDelayMs '
      'reconnect=$isReconnect',
    );
    _setState(HubConnectionState.connecting);

    if (isReconnect) {
      _reconnectTimer = Timer(
        const Duration(milliseconds: _dnsGraceDelayMs),
        () async {
          _reconnectTimer = null;
          if (!_appInForeground || _disposed) {
            _connecting = false;
            return;
          }

          final changedTypes = await _getChangedTypesSinceDisconnect();
          if (changedTypes == null) {
            _pingStreamActivity();
            _events.add(HubReconnected());
          } else if (changedTypes.isNotEmpty) {
            _log.info(
              '[HUB] Selective reconnect: ${changedTypes.length} types changed',
            );
            _pingStreamActivity();
            _events.add(HubSelectiveReconnect(changedTypes));
          } else {
            _log.info('[HUB] No events missed — skipping refetch');
          }

          _doSubscribe();
        },
      );
    } else {
      _doSubscribe();
    }
  }

  void _doSubscribe() {
    if (!_appInForeground || _disposed) {
      _connecting = false;
      return;
    }

    _log.info('[HUB] Subscribing to hub_events_stream');
    final client = di<Client>();
    try {
      _subscription = client.hub.streamHubEvents().listen(
        (message) {
          if (!_hasReceivedFirstEvent) {
            _hasReceivedFirstEvent = true;
            _reconnectDelayMs = _initialReconnectDelayMs;
          }
          if (_disposed) return;

          // Check for force-logout targeting this device.
          if (message is ForceLogoutEvent &&
              message.deviceId == _currentDeviceId) {
            _log.warning(
              '[HUB] ForceLogoutEvent received for this device — wiping data',
            );
            _cleanupSubscription();
            SessionHelper.logoutAndDeleteAllInstanceData(
              reason:
                  'Die Sitzung für dieses Gerät wurde von einem Administrator '
                  'oder dem Besitzer/der Besitzerin  dieses Gerätes beendet. '
                  'Alle lokalen Daten wurden gelöscht.',
            );
            return;
          }

          _pingStreamActivity();
          _events.add(message as Object);
        },
        onError: (Object error) {
          _handleStreamError(error);
        },
        onDone: () {
          _handleStreamDone();
        },
        cancelOnError: true,
      );
      _setState(HubConnectionState.connected);
      _connecting = false;
    } catch (e, st) {
      _connecting = false;
      _log.severe('[HUB] Subscribe threw: $e', e, st);
      _handleStreamError(e);
      return;
    }
  }

  void _handleStreamError(Object error) {
    _connecting = false;
    _setState(HubConnectionState.disconnected);
    _cleanupSubscription();
    _log.severe('[HUB] Stream error: $error');

    if (error is ServerpodClientUnauthorized ||
        (error is ServerpodClientException && error.statusCode == 401)) {
      _log.warning('[HUB] Unauthorized — wiping data and signing out');
      SessionHelper.logoutAndDeleteAllInstanceData(
        reason:
            'Die Sitzung ist nicht mehr gültig. '
            'Alle lokalen Daten wurden gelöscht. '
            'Bitte loggen Sie sich erneut ein.',
      );
      return;
    }

    final delayMs = _reconnectDelayMs;
    _reconnectDelayMs = (_reconnectDelayMs * 2).clamp(
      _initialReconnectDelayMs,
      _maxReconnectDelayMs,
    );
    _setState(HubConnectionState.waitingRetry);
    _scheduleReconnect(
      isReconnect: true,
      delayMs: delayMs,
      reason: 'stream_error',
    );
  }

  void _handleStreamDone() {
    _connecting = false;
    _setState(HubConnectionState.disconnected);
    _cleanupSubscription();
    _log.warning('[HUB] Stream closed - reconnecting...');

    final delayMs = _reconnectDelayMs;
    _reconnectDelayMs = (_reconnectDelayMs * 2).clamp(
      _initialReconnectDelayMs,
      _maxReconnectDelayMs,
    );
    _setState(HubConnectionState.waitingRetry);
    _scheduleReconnect(
      isReconnect: true,
      delayMs: delayMs,
      reason: 'stream_done',
    );
  }

  void dispose() {
    _disposed = true;
    _streamActivityTimer?.cancel();
    _streamActivity.dispose();
    WidgetsBinding.instance.removeObserver(this);
    final monitor = di<ServerpodConnectivityMonitor>();
    if (_connectivityListener != null) {
      monitor.isConnected.removeListener(_connectivityListener!);
      _connectivityListener = null;
    }
    _cancelReconnectTimer();
    _cleanupSubscription();
    _state.value = HubConnectionState.disconnected;
    _state.dispose();
    _events.close();
  }
}
