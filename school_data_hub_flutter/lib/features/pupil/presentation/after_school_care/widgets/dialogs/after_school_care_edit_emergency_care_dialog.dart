import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';

Future<void> afterSchoolCareEditEmergencyCareDialog(
  BuildContext context,
  PupilProxy pupil,
) async {
  final afterSchoolCare = pupil.afterSchoolCare;
  bool? currentValue = afterSchoolCare?.emergencyCare;

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Notbetreuung bearbeiten'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Ist Notbetreuung aktiviert?',
                  style: TextStyle(fontSize: 16),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<bool?>(
                      value: true,
                      groupValue: currentValue,
                      onChanged: (value) {
                        setState(() {
                          currentValue = value;
                        });
                      },
                    ),
                    const Text('Ja'),
                    const Gap(30),
                    Radio<bool?>(
                      value: false,
                      groupValue: currentValue,
                      onChanged: (value) {
                        setState(() {
                          currentValue = value;
                        });
                      },
                    ),
                    const Text('Nein'),
                    const Gap(30),
                    Radio<bool?>(
                      value: null,
                      groupValue: currentValue,
                      onChanged: (value) {
                        setState(() {
                          currentValue = value;
                        });
                      },
                    ),
                    const Text('Nicht gesetzt'),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('ABBRECHEN'),
              ),
              ElevatedButton(
                style: AppStyles.successButtonStyle,
                onPressed: () async {
                  await PupilMutator().updateAfterSchoolCare(
                    pupilId: pupil.pupilId,
                    emergencyCare: (value: currentValue),
                  );

                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                },
                child: const Text(
                  'SPEICHERN',
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
