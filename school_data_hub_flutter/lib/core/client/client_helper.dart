import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';

/// Status codes that indicate a server restart or transient gateway issue.
/// These are always suppressed silently — the hub stream reconnect will
/// trigger a re-fetch once the server is back.
const _transientStatusCodes = {404, 502, 503};

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
      di<NotificationManager>().apiRunning(true);
      final result = await call();
      di<NotificationManager>().apiRunning(false);
      return result;
    } on ServerpodClientException catch (e) {
      di<NotificationManager>().apiRunning(false);

      // Suppress transient gateway/restart errors silently.
      if (_transientStatusCodes.contains(e.statusCode)) {
        return null;
      }

      if (e.statusCode == 401 || e.toString().contains('Not authorized')) {
        SessionHelper.logoutAndDeleteAllInstanceData(
          reason:
              'Die Sitzung ist nicht mehr gültig. '
              'Alle lokalen Daten wurden gelöscht. '
              'Bitte loggen Sie sich erneut ein.',
        );
        return null;
      }

      di<NotificationManager>().showInformationDialog(
        NotificationType.error,
        'API Fehler: ${errorMessage ?? "Unbekannt"}: $e',
      );
      return null;
    } catch (e) {
      di<NotificationManager>().apiRunning(false);
      di<NotificationManager>().showInformationDialog(
        NotificationType.error,
        'API Fehler:\n $errorMessage: $e',
      );

      return null;
    }
  }
}
