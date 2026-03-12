import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

OverlayState? _resolveOverlay(BuildContext context) {
  final navState = MyApp.navigatorKey.currentState;
  if (navState != null) return navState.overlay;
  if (context.mounted) return Overlay.of(context);
  return null;
}

OverlayState? get _rootOverlay => MyApp.navigatorKey.currentState?.overlay;

/// Shows a snackbar on the root navigator overlay. No BuildContext needed.
/// Use this when showing from a global handler (e.g. NotificationService).
void showSnackBarOnRootOverlay({
  required NotificationType type,
  required String message,
  bool retrying = false,
}) {
  final overlay = _rootOverlay;
  if (overlay == null && !retrying) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSnackBarOnRootOverlay(type: type, message: message, retrying: true);
    });
    return;
  }
  if (overlay == null) return;
  switch (type) {
    case NotificationType.error:
      _showTopSnackBarError(overlay, message);
      break;
    case NotificationType.warning:
      _showTopSnackBarWarning(overlay, message);
      break;
    case NotificationType.info:
      _showTopSnackBarInfo(overlay, message);
      break;
    case NotificationType.success:
      _showTopSnackBarSuccess(overlay, message);
      break;
    case NotificationType.dialog:
      break;
  }
}

void snackBar({
  required BuildContext context,
  required NotificationType snackbarType,
  required String message,
  bool retrying = false,
}) {
  if (!retrying) {
    final overlay = _resolveOverlay(context);
    if (overlay == null && context.mounted) {
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
  switch (snackbarType) {
    case NotificationType.error:
      snackbarError(context, message);
      break;
    case NotificationType.warning:
      snackbarWarning(context, message);
      break;
    case NotificationType.info:
      snackbarInfo(context, message);
      break;
    case NotificationType.success:
      snackbarSuccess(context, message);
      break;
    case NotificationType.dialog:
      break;
  }
}

void _showTopSnackBarInfo(OverlayState overlay, String message) {
  showTopSnackBar(
    overlay,
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: CustomSnackBar.info(
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          icon: const Icon(Icons.school, color: Colors.blue),
          message: message,
        ),
      ),
    ),
    animationDuration: const Duration(milliseconds: 600),
    displayDuration: const Duration(seconds: 3),
  );
}

void _showTopSnackBarSuccess(OverlayState overlay, String message) {
  showTopSnackBar(
    overlay,
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: CustomSnackBar.success(
          backgroundColor: Colors.green,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          icon: const Icon(Icons.school, color: Colors.green),
          message: message,
        ),
      ),
    ),
    animationDuration: const Duration(milliseconds: 600),
    displayDuration: const Duration(seconds: 3),
  );
}

void _showTopSnackBarWarning(OverlayState overlay, String message) {
  showTopSnackBar(
    overlay,
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: CustomSnackBar.info(
          backgroundColor: Colors.orange,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          icon: const Icon(Icons.school, color: Colors.orange),
          message: message,
        ),
      ),
    ),
    animationDuration: const Duration(milliseconds: 600),
    displayDuration: const Duration(seconds: 3),
  );
}

void _showTopSnackBarError(OverlayState overlay, String message) {
  showTopSnackBar(
    overlay,
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: CustomSnackBar.error(
          backgroundColor: Colors.red,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          icon: const Icon(Icons.school, color: Colors.red),
          message: message,
        ),
      ),
    ),
    animationDuration: const Duration(milliseconds: 800),
    displayDuration: const Duration(seconds: 4),
  );
}

void snackbarInfo(BuildContext context, String message) {
  final overlay = _resolveOverlay(context);
  if (overlay != null) _showTopSnackBarInfo(overlay, message);
}

void snackbarSuccess(BuildContext context, String message) {
  final overlay = _resolveOverlay(context);
  if (overlay != null) _showTopSnackBarSuccess(overlay, message);
}

void snackbarWarning(BuildContext context, String message) {
  final overlay = _resolveOverlay(context);
  if (overlay != null) _showTopSnackBarWarning(overlay, message);
}

void snackbarError(BuildContext context, String message) {
  final overlay = _resolveOverlay(context);
  if (overlay != null) _showTopSnackBarError(overlay, message);
}
