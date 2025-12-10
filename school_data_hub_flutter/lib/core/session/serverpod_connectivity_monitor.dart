import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:signals/signals_flutter.dart';
import 'package:watch_it/watch_it.dart';

/// Copied from [FlutterConnectivityMonitor] in the serverpod package
/// and added a ValueNotifier to the class to be able to observe it with watch_it
/// Concrete implementation of [ConnectivityMonitor] for use with Flutter.
class ServerpodConnectivityMonitor extends ConnectivityMonitor {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _receivedFirstEvent = false;
  final _notificationService = di<NotificationService>();
  // value notifier to observe with watch_it
  final Signal<bool> _isConnected = signal(false);
  Signal<bool> get isConnected => _isConnected;

  /// Creates a new connectivity monitor.
  ServerpodConnectivityMonitor() {
    WidgetsFlutterBinding.ensureInitialized();
    const warmupDuration = Duration(seconds: 1);
    var connectionTime = DateTime.now().toUtc();

    // Start listening to connection status changes.
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      event,
    ) {
      final bool hasConnectivity =
          !(event.length == 1 && event.first == ConnectivityResult.none);
      if (hasConnectivity != _isConnected.value) {
        _isConnected.value = hasConnectivity;
        if (hasConnectivity) {
          _notificationService.showSnackBar(
            NotificationType.info,
            'Mit dem Internet verbunden',
          );
        } else {
          _notificationService.showSnackBar(
            NotificationType.error,
            'Keine Internetverbindung',
          );
        }
      }

      if (!_receivedFirstEvent) {
        // Skip the first event if it happens immediately on launch as it may
        // not be correct on some platforms.
        _receivedFirstEvent = true;
        var durationSinceStart = DateTime.now().toUtc().difference(
          connectionTime,
        );
        if (!hasConnectivity && durationSinceStart < warmupDuration) {
          return;
        }
      }
      notifyListeners(hasConnectivity);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }
}
