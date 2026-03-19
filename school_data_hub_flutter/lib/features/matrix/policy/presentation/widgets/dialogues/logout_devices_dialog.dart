import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

Future<bool?> logoutDevicesDialog(BuildContext context) async {
  final style = Style.of(context);
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: Icon(
          Icons.warning_rounded,
          color: style.colors.error,
          size: 50,
        ),
        title: Text(
          'Alle Geräte abmelden?',
          style: context.typography.title,
        ),
        content: SizedBox(
          width: 300,
          child: Text(
            'Sollen alle Geräte mit diesem Konto abgemeldet werden?\nWenn die Zugangsdaten verloren und keine bekannten Geräte angemeldet sind, solten Sie "Ja" wählen!',
            style: context.typography.body,
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Button.small(
                    variant: ButtonVariant.secondary,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    label: 'NEIN',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Button.small(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    label: 'JA',
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Button.small(
              variant: ButtonVariant.destructive,
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: 'ABBRECHEN',
            ),
          ),
        ],
      );
    },
  );
}
