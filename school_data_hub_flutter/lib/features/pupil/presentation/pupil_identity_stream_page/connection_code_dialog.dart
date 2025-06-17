import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_identity_stream_page/pupil_identity_stream_page.dart';

Future<void> showConnectionCodeDialog(BuildContext context) async {
  final controller = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Verbindungscode eingeben'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Gib den Verbindungscode ein, den du vom Sender erhalten hast.',
              style: TextStyle(fontSize: 14),
            ),
            const Gap(16),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Verbindungscode',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Abbrechen'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Verbinden'),
            onPressed: () {
              final code = controller.text.trim();
              if (code.isNotEmpty) {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PupilIdentityStreamPage(
                      role: PupilIdentityStreamRole.receiver,
                      encryptedData: null,
                      importedChannelName: code,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
