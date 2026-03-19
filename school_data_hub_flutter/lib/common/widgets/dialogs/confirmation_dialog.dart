import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/confirmation_popup.dart';

Future<bool?> confirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
}) async {
  final completer = Completer<bool?>();

  await ConfirmationPopup.show(
    context: context,
    title: title,
    description: message,
    confirmLabel: 'JA',
    cancelLabel: 'NEIN',
    onConfirm: () {
      if (!completer.isCompleted) {
        completer.complete(true);
      }
    },
    onCancel: () {
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    },
  );

  // If the popup was dismissed by tapping the barrier or pressing Escape,
  // neither callback fired — complete with null.
  if (!completer.isCompleted) {
    completer.complete(null);
  }

  return completer.future;
}
