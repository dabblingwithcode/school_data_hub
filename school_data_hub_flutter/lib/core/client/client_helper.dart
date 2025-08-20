import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();
final _hubSessionManager = di<HubSessionManager>();

class ClientHelper {
  // Make it a singleton
  static final ClientHelper _instance = ClientHelper._internal();
  factory ClientHelper() => _instance;
  ClientHelper._internal();

  static Future<T?> apiCall<T>(
      {required Future<T> Function() call, String? errorMessage}) async {
    try {
      _notificationService.apiRunning(true);
      final result = await call();
      _notificationService.apiRunning(false);
      return result;
    } on ServerpodClientException catch (e) {
      _notificationService.apiRunning(false);
      _notificationService.showInformationDialog('Client error: $e');

      if (e.toString().contains('Not authorized') ||
          e.toString().contains('401')) {
        // Handle authentication error specifically
        _notificationService.showInformationDialog(
            'Authentication required. Please log in again.');
        _hubSessionManager.signOutDevice();
        // Optionally, trigger a logout or redirect to login
      }
      return null;
    } catch (e) {
      _notificationService.apiRunning(false);
      _notificationService
          .showInformationDialog('API Fehler:\n $errorMessage: $e');

      return null;
    }
  }
}
