import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

Future<bool?> logoutDevicesDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: Icon(
          Icons.warning_rounded,
          color: AppColors.dangerButtonColor,
          size: 50,
        ),
        title: const Text(
          'Alle Geräte abmelden?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const SizedBox(
          width: 300,
          child: Text(
            'Sollen alle Geräte mit diesem Konto abgemeldet werden?\nWenn die Zugangsdaten verloren und keine bekannten Geräte angemeldet sind, solten Sie "Ja" wählen!',
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: AppStyles.actionButtonStyle,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }, // Add onPressed
                    child: const Text("NEIN", style: AppStyles.buttonTextStyle),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: AppStyles.actionButtonStyle,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }, // Add onPressed
                    child: const Text("JA", style: AppStyles.buttonTextStyle),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: AppStyles.cancelButtonStyle,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("ABBRECHEN", style: AppStyles.buttonTextStyle),
            ),
          ),
        ],
      );
    },
  );
}
