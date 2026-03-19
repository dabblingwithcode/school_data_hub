import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class SuccessDialog extends StatelessWidget {
  final int newCount;
  final int totalCount;

  const SuccessDialog({
    super.key,
    required this.newCount,
    required this.totalCount,
  });

  static Future<void> show(
    BuildContext context,
    int newCount,
    int totalCount,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SuccessDialog(newCount: newCount, totalCount: totalCount);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Übertragung erfolgreich!'),
      content: Text(
        totalCount > 0
            ? newCount > 0
                ? 'Es wurden $totalCount Schülerdaten übertragen, davon $newCount neue Einträge.'
                : 'Es wurden $totalCount Schülerdaten erfolgreich übertragen und aktualisiert. Es wurden keine neuen Einträge hinzugefügt.'
            : 'Keine Schülerdaten empfangen.',
        style: context.typography.body,
      ),
      actions: [
        Button.small(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            Navigator.of(context).pop(); // Close stream page
          },
          label: 'OK',
          variant: ButtonVariant.primary,
        ),
      ],
    );
  }
}
