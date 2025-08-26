import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class SuccessDialog extends StatelessWidget {
  final int newCount;
  final int totalCount;

  const SuccessDialog({
    Key? key,
    required this.newCount,
    required this.totalCount,
  }) : super(key: key);

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
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            Navigator.of(context).pop(); // Close stream page
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentColor,
          ),
          child: const Text('OK', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
