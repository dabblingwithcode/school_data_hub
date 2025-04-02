import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

snackbar(BuildContext context, snackbarType, message) {
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
  }
}

snackbarInfo(BuildContext context, message) {
  if (context.mounted) {
    showTopSnackBar(
      Overlay.of(context),
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
            icon: const Icon(
              Icons.school,
              color: Colors.blue,
            ),
            message: message,
          ),
        ),
      ),
      animationDuration: const Duration(milliseconds: 1600),
      displayDuration: const Duration(
        milliseconds: 80,
      ),
    );
  }
}

snackbarSuccess(context, message) {
  if (context.mounted) {
    showTopSnackBar(
      Overlay.of(context),
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
            icon: const Icon(
              Icons.school,
              color: Colors.green,
            ),
            message: message,
          ),
        ),
      ),
      animationDuration: const Duration(milliseconds: 1600),
      displayDuration: const Duration(
        milliseconds: 80,
      ),
    );
  }
}

snackbarWarning(context, message) {
  if (context.mounted) {
    showTopSnackBar(
      Overlay.of(context),
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
            icon: const Icon(
              Icons.school,
              color: Colors.orange,
            ),
            message: message,
          ),
        ),
      ),
      animationDuration: const Duration(milliseconds: 1600),
      displayDuration: const Duration(
        milliseconds: 80,
      ),
    );
  }
}

snackbarError(context, message) {
  if (context.mounted) {
    showTopSnackBar(
      Overlay.of(context),
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: CustomSnackBar.success(
            backgroundColor: Colors.red,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
            icon: const Icon(
              Icons.school,
              color: Colors.red,
            ),
            message: message,
          ),
        ),
      ),
      animationDuration: const Duration(milliseconds: 3000),
      displayDuration: const Duration(
        milliseconds: 80,
      ),
    );
  }
}
