import 'package:flutter/widgets.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/toast.dart';
import 'package:school_data_hub_flutter/main.dart';

ToastType _mapType(NotificationType type) {
  return switch (type) {
    NotificationType.success => ToastType.success,
    NotificationType.error => ToastType.error,
    NotificationType.warning => ToastType.warning,
    NotificationType.info => ToastType.info,
    NotificationType.dialog => ToastType.info,
  };
}

/// Shows a snackbar on the root navigator overlay. No BuildContext needed.
/// Use this when showing from a global handler (e.g. NotificationService).
void showSnackBarOnRootOverlay({
  required NotificationType type,
  required String message,
  bool retrying = false,
}) {
  final context = MyApp.navigatorKey.currentContext;
  if (context == null && !retrying) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSnackBarOnRootOverlay(type: type, message: message, retrying: true);
    });
    return;
  }
  if (context == null) return;
  if (type == NotificationType.dialog) return;
  Toast.show(context: context, message: message, type: _mapType(type));
}

void snackBar({
  required BuildContext context,
  required NotificationType snackbarType,
  required String message,
  bool retrying = false,
}) {
  if (snackbarType == NotificationType.dialog) return;
  if (!retrying) {
    // Verify we can resolve a navigator; if not, defer to next frame.
    final navContext =
        MyApp.navigatorKey.currentContext ?? (context.mounted ? context : null);
    if (navContext == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          snackBar(
            context: context,
            snackbarType: snackbarType,
            message: message,
            retrying: true,
          );
        }
      });
      return;
    }
  }
  final effectiveContext = MyApp.navigatorKey.currentContext ?? context;
  Toast.show(
    context: effectiveContext,
    message: message,
    type: _mapType(snackbarType),
  );
}

void snackbarInfo(BuildContext context, String message) {
  Toast.show(context: context, message: message, type: ToastType.info);
}

void snackbarSuccess(BuildContext context, String message) {
  Toast.show(context: context, message: message, type: ToastType.success);
}

void snackbarWarning(BuildContext context, String message) {
  Toast.show(context: context, message: message, type: ToastType.warning);
}

void snackbarError(BuildContext context, String message) {
  Toast.show(context: context, message: message, type: ToastType.error);
}
