import 'package:flutter/foundation.dart';
import 'package:school_data_hub_flutter/core/models/enums.dart';

class NotificationData {
  final NotificationType type;
  final String message;

  NotificationData(this.type, this.message);
}

class NotificationService {
  final _snackBar = ValueNotifier<NotificationData>(
      NotificationData(NotificationType.success, ''));
  ValueListenable<NotificationData> get notification => _snackBar;

  final _apiRunning = ValueNotifier<bool>(false);
  ValueListenable<bool> get isRunning => _apiRunning;
  final _loadingNewInstance = ValueNotifier<bool>(false);
  ValueListenable<bool> get loadingNewInstance => _loadingNewInstance;

  final _heavyLoading = ValueNotifier<bool>(false);
  ValueListenable<bool> get heavyLoading => _heavyLoading;

  NotificationService();

  void showSnackBar(NotificationType type, String message) {
    if (_loadingNewInstance.value) {
      return;
    }
    _snackBar.value = NotificationData(type, message);
  }

  void showInformationDialog(String message) {
    _snackBar.value = NotificationData(NotificationType.infoDialog, message);
  }

  void apiRunning(bool value) {
    _apiRunning.value = value;
  }

  void setNewInstanceLoadingValue(bool value) {
    _loadingNewInstance.value = value;
  }

  void setHeavyLoadingValue(bool value) {
    _heavyLoading.value = value;
  }
}
