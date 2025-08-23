import 'package:flutter/material.dart';

class RejectionDialog extends StatelessWidget {
  final bool wasAutoRejected;

  const RejectionDialog({Key? key, this.wasAutoRejected = false})
    : super(key: key);

  static Future<void> show(
    BuildContext context, {
    bool wasAutoRejected = false,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RejectionDialog(wasAutoRejected: wasAutoRejected);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Anfrage abgelehnt'),
      content: Text(
        wasAutoRejected
            ? 'Der Sender hat Ihre Anfrage bereits zuvor abgelehnt. Sie können diesem Stream nicht mehr beitreten.'
            : 'Der Sender hat Ihre Anfrage für Schülerdaten abgelehnt.',
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            Navigator.of(context).pop(); // Close stream page
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('OK', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
