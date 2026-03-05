import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

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
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              'Raum aus der Policy rausnehmen',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: Icon(
              Icons.question_mark_rounded,
              color: AppColors.backgroundColor,
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
                  title: const Text(
                    'Raum auch purgen (auf Server verlassen und vergessen)',
                    style: TextStyle(fontSize: 14),
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
                      child: ElevatedButton(
                        style: AppStyles.cancelButtonStyle,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'NEIN',
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: AppStyles.successButtonStyle,
                        onPressed: () {
                          Navigator.of(context).pop((remove: true, purge: purge));
                        },
                        child: const Text(
                          'JA',
                          style: AppStyles.buttonTextStyle,
                        ),
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
