import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String userName;
  final VoidCallback onConfirm;
  final VoidCallback onReject;

  const ConfirmationDialog({
    Key? key,
    required this.userName,
    required this.onConfirm,
    required this.onReject,
  }) : super(key: key);

  static Future<bool?> show(BuildContext context, String userName) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Datenanfrage bestätigen'),
          content: Text(
            'Der Benutzer "$userName" möchte Schülerdaten empfangen. Möchten Sie die Übertragung starten?',
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Bestätigen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    'Ablehnen',
                    style: TextStyle(color: Colors.white),
                  ),
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
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Bestätigen',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: onReject,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Ablehnen',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
