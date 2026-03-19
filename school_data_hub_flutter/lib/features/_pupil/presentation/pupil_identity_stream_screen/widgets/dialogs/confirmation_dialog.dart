import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class ConfirmationDialog extends StatelessWidget {
  final String userName;
  final VoidCallback onConfirm;
  final VoidCallback onReject;

  const ConfirmationDialog({
    super.key,
    required this.userName,
    required this.onConfirm,
    required this.onReject,
  });

  static Future<bool?> show(BuildContext context, String userName) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Datenanfrage bestätigen'),
          content: Text(
            'Der Benutzer "$userName" möchte Schülerdaten empfangen. Möchten Sie die Übertragung starten?',
            style: context.typography.body,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button.small(
                  onPressed: () => Navigator.of(context).pop(true),
                  label: 'Bestätigen',
                  variant: ButtonVariant.primary,
                ),
                Button.small(
                  onPressed: () => Navigator.of(context).pop(false),
                  label: 'Ablehnen',
                  variant: ButtonVariant.destructive,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Datenanfrage bestätigen'),
      content: Text(
        'Der Benutzer "$userName" möchte Schülerdaten empfangen. Möchten Sie die Übertragung starten?',
        style: context.typography.body,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button.small(
              onPressed: onConfirm,
              label: 'Bestätigen',
              variant: ButtonVariant.primary,
            ),
            Button.small(
              onPressed: onReject,
              label: 'Ablehnen',
              variant: ButtonVariant.destructive,
            ),
          ],
        ),
      ],
    );
  }
}
