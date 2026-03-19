import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/models/enums.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';

final _notificationService = di<NotificationManager>();

Future<({String serverName, String serverUrl, HubRunMode hubRunMode})?>
showNewEnvKeysDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (builderContext, setState) {
          final serverNameController = TextEditingController();
          final serverUrlController = TextEditingController();
          HubRunMode selectedHubRunMode =
              HubRunMode.development; // Default value

          return AlertDialog(
            title: const Text('Neuen Schulschlüssel erstellen'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Geben Sie die Schulschlüssel-Daten ein.\nIm Anschluss werden Sie gefragt. in welchem Ordner Sie den Schlüssel speichern möchten.',
                ),
                TextField(
                  controller: serverNameController,
                  decoration: const InputDecoration(labelText: 'Server Name'),
                ),
                TextField(
                  controller: serverUrlController,
                  decoration: const InputDecoration(labelText: 'Server URL'),
                ),
                const SizedBox(height: 16),
                const Text('Servermodus:'),
                DropdownButton<HubRunMode>(
                  value: selectedHubRunMode,
                  onChanged: (newValue) {
                    if (newValue != selectedHubRunMode && newValue != null) {
                      setState(() {
                        selectedHubRunMode = newValue;
                      });
                    }
                  },
                  items: HubRunMode.values.map((HubRunMode mode) {
                    return DropdownMenuItem<HubRunMode>(
                      value: mode,
                      child: Text(mode.name),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(Style.spacing.xs),
                child: Button(
                  variant: ButtonVariant.secondary,
                  label: 'ABBRECHEN',
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Style.spacing.xs),
                child: Button(
                  label: 'ERSTELLEN',
                  onPressed: () {
                    if (serverNameController.text.isEmpty ||
                        serverUrlController.text.isEmpty) {
                      _notificationService.showInformationDialog(
                        NotificationType.error,
                        'Bitte füllen Sie alle Felder aus.',
                      );
                      return;
                    }
                    Navigator.of(context).pop((
                      serverName: serverNameController.text,
                      serverUrl: serverUrlController.text,
                      hubRunMode: selectedHubRunMode,
                    ));
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
