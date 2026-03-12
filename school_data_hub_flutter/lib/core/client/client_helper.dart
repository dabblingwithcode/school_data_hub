import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/hub_stream_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';

class ClientHelper {
  // Make it a singleton
  static final ClientHelper _instance = ClientHelper._internal();
  factory ClientHelper() => _instance;
  ClientHelper._internal();

  static Future<T?> apiCall<T>({
    required Future<T> Function() call,
    String? errorMessage,
  }) async {
    try {
      di<NotificationService>().apiRunning(true);
      final result = await call();
      di<NotificationService>().apiRunning(false);
      return result;
    } on ServerpodClientException catch (e) {
      di<NotificationService>().apiRunning(false);

      // 502 / 503 during a server restart are expected transients.
      // Suppress them while the hub stream is not yet connected so the
      // reconnect-flush doesn't clutter the overlay with gateway errors.
      if (e.statusCode == 502 || e.statusCode == 503) {
        try {
          final hub = di<HubStreamService>();
          if (hub.connectionState.value != HubConnectionState.connected) {
            return null;
          }
        } catch (_) {
          // HubStreamService not yet registered — fall through to show error.
        }
      }

      di<NotificationService>().showInformationDialog(
        NotificationType.error,
        'API Fehler: ${errorMessage ?? "Unbekannt"}: $e',
      );

      if (e.toString().contains('Not authorized') ||
          e.toString().contains('401')) {
        di<NotificationService>().showInformationDialog(
          NotificationType.error,
          'Authentication required. Please log in again.',
        );
        di<HubSessionManager>().signOutDevice();
      }
      return null;
    } catch (e) {
      di<NotificationService>().apiRunning(false);
      di<NotificationService>().showInformationDialog(
        NotificationType.error,
        'API Fehler:\n $errorMessage: $e',
      );

      return null;
    }
  }
}
