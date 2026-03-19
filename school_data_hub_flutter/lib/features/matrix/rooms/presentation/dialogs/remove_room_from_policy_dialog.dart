import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

/// Result of confirming removal of a room from the policy.
/// [purge] is the checkbox value: whether to also purge the room on the server.
typedef RemoveRoomFromPolicyResult = ({bool remove, bool purge});

/// Shows a dialog to confirm removing a room from the policy, with an optional
/// choice to also purge the room on the server.
Future<RemoveRoomFromPolicyResult?> showRemoveRoomFromPolicyDialog(
  BuildContext context, {
  required String roomName,
}) async {
  bool purge = false;
  return showDialog<RemoveRoomFromPolicyResult>(
    context: context,
    builder: (BuildContext context) {
      final style = Style.of(context);
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              'Raum aus der Policy rausnehmen',
              style: context.typography.subtitle.bold,
            ),
            icon: Icon(
              Icons.question_mark_rounded,
              color: style.colors.accent,
              size: 50,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Raum $roomName aus der Policy löschen?',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  value: purge,
                  onChanged: (value) => setState(() => purge = value ?? false),
                  title: Text(
                    'Raum auch purgen (auf Server verlassen und vergessen)',
                    style: context.typography.body,
                  ),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Button(
                        variant: ButtonVariant.destructive,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        label: 'NEIN',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Button(
                        variant: ButtonVariant.primary,
                        onPressed: () {
                          Navigator.of(context).pop((remove: true, purge: purge));
                        },
                        label: 'JA',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}
