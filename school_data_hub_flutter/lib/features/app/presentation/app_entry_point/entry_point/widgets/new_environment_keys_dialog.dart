import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/env/models/enums.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

Future<({String serverName, String serverUrl, HubRunMode hubRunMode})?>
    showNewEnvKeysDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (builderContext, setState) {
        final serverNameController = TextEditingController();
        final serverUrlController = TextEditingController();
        HubRunMode selectedHubRunMode = HubRunMode.development; // Default value

        return AlertDialog(
          title: const Text('Neuen Schulschlüssel erstellen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Geben Sie die Schulschlüssel-Daten ein.\nIm Anschluss werden Sie gefragt. in welchem Ordner Sie den Schlüssel speichern möchten.',
              ),
              TextField(
                controller: serverNameController,
                decoration: const InputDecoration(
                  labelText: 'Server Name',
                ),
              ),
              TextField(
                controller: serverUrlController,
                decoration: const InputDecoration(
                  labelText: 'Server URL',
                ),
              ),
              const SizedBox(height: 16),
              Text('Servermodus:'),
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
                    child: Text(mode.name), // Use the enum's name property
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                style: AppStyles.cancelButtonStyle,
                onPressed: () {
                  Navigator.of(context).pop(null);
                }, // Add onPressed
                child: const Text(
                  "ABBRECHEN",
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                style: AppStyles.successButtonStyle,
                onPressed: () {
                  if (serverNameController.text.isEmpty ||
                      serverUrlController.text.isEmpty) {
                    _notificationService.showInformationDialog(
                        'Bitte füllen Sie alle Felder aus.');
                    return;
                  }
                  Navigator.of(context).pop((
                    serverName: serverNameController.text,
                    serverUrl: serverUrlController.text,
                    hubRunMode: selectedHubRunMode,
                  ));
                }, // Add onPressed
                child: const Text(
                  "ERSTELLEN",
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ),
          ],
        );
      });
    },
  );
}
