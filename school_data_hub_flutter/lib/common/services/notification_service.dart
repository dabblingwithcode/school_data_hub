import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';

export 'package:school_data_hub_flutter/common/models/enums.dart';

class NotificationData {
  final NotificationType type;
  final String message;

  NotificationData(this.type, this.message);
}

final _log = Logger('NotificationService');

class NotificationService {
  final _snackBar = ValueNotifier<NotificationData>(
    NotificationData(NotificationType.success, ''),
  );
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
    switch (type) {
      case NotificationType.success:
        _log.info('''SNACK BAR SUCCESS:
        $message''');
      case NotificationType.error:
        _log.severe('''SNACK BAR ERROR:
        $message''');
      case NotificationType.info:
        _log.info('''SNACK BAR INFO:
        $message''');
      case NotificationType.warning:
        _log.warning('''SNACK BAR WARNING:
        $message''');
      case NotificationType.dialog:
        _log.info('''SNACK BAR DIALOG:
        $message''');
    }

    //- TODO: Investigate when we really want to show one
    //- before uncommenting this
    // _snackBar.value = NotificationData(type, message);
  }

  void showInformationDialog(String message) {
    _snackBar.value = NotificationData(NotificationType.dialog, message);

    _log.fine('''INFORMATION DIALOG:
      $message
      ''');
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
