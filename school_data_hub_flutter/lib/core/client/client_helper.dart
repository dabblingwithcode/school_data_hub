import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

class ClientHelper {
  // Make it a singleton
  static final ClientHelper _instance = ClientHelper._internal();
  factory ClientHelper() => _instance;
  ClientHelper._internal();

  static Future<T> apiCall<T>(
      {required Future<T> Function() call, String? errorMessage}) async {
    try {
      _notificationService.apiRunning(true);
      final result = await call();
      _notificationService.apiRunning(false);
      return result;
    } catch (e) {
      _notificationService.apiRunning(false);
      _notificationService.showInformationDialog('$errorMessage: $e');

      throw Exception('$errorMessage: $e');
    }
  }
}
