import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';

export 'package:school_data_hub_flutter/common/models/enums.dart';

enum NotificationTarget { snackBar, informationDialog, overlay, idle }

class NotificationData {
  final NotificationTarget target;
  final NotificationType type;
  final String message;

  const NotificationData({
    required this.target,
    required this.type,
    required this.message,
  });
}

final _log = Logger('NotificationManager');

class NotificationManager {
  final _notification = ValueNotifier<NotificationData>(
    const NotificationData(
      target: NotificationTarget.idle,
      type: NotificationType.success,
      message: '',
    ),
  );
  ValueListenable<NotificationData> get notification => _notification;

  final _apiRunning = ValueNotifier<bool>(false);
  ValueListenable<bool> get isRunning => _apiRunning;
  final _loadingNewInstance = ValueNotifier<bool>(false);
  ValueListenable<bool> get loadingNewInstance => _loadingNewInstance;

  final _heavyLoading = ValueNotifier<bool>(false);
  ValueListenable<bool> get heavyLoading => _heavyLoading;
  int _heavyLoadingCounter = 0;

  NotificationManager();

  void showSnackBar(NotificationType type, String message) {
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
    }

    _notification.value = NotificationData(
      target: NotificationTarget.snackBar,
      type: type,
      message: message,
    );
  }

  void showInformationDialog(NotificationType type, String message) {
    _notification.value = NotificationData(
      target: NotificationTarget.informationDialog,
      type: type,
      message: message,
    );
  }

  void showInformationDialogMessage(
    String message, {
    NotificationType type = NotificationType.info,
  }) {
    showInformationDialog(type, message);
  }

  void showErrorDialog(String message) {
    showInformationDialogMessage(message, type: NotificationType.error);
  }

  void apiRunning(bool value) {
    final phase = SchedulerBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _apiRunning.value = value;
      });
    } else {
      _apiRunning.value = value;
    }
  }

  void setNewInstanceLoadingValue(bool value) {
    _loadingNewInstance.value = value;
  }

  void setHeavyLoadingValue(bool value) {
    if (value) {
      beginHeavyLoading();
      return;
    }
    endHeavyLoading();
  }

  void beginHeavyLoading() {
    _heavyLoadingCounter += 1;
    if (_heavyLoadingCounter == 1) {
      _heavyLoading.value = true;
    }
  }

  void endHeavyLoading() {
    if (_heavyLoadingCounter == 0) {
      return;
    }
    _heavyLoadingCounter -= 1;
    if (_heavyLoadingCounter == 0) {
      _heavyLoading.value = false;
    }
  }

  Future<T> runWithHeavyLoading<T>(Future<T> Function() action) async {
    beginHeavyLoading();
    try {
      return await action();
    } finally {
      endHeavyLoading();
    }
  }
}
