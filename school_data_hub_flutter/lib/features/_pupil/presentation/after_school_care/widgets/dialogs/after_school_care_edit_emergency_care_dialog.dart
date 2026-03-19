import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';

Future<void> afterSchoolCareEditEmergencyCareDialog(
  BuildContext context,
  PupilProxy pupil,
) async {
  final afterSchoolCare = pupil.afterSchoolCare;
  bool? currentValue = afterSchoolCare?.emergencyCare;

  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Notbetreuung bearbeiten'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ist Notbetreuung aktiviert?',
                  style: context.typography.subtitle,
                ),
                Gap(Style.spacing.xl),
                RadioGroup<bool?>(
                  groupValue: currentValue,
                  onChanged: (value) {
                    setState(() {
                      currentValue = value;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Radio<bool?>(value: true),
                      const Text('Ja'),
                      Gap(Style.spacing.xxl),
                      const Radio<bool?>(value: false),
                      const Text('Nein'),
                      Gap(Style.spacing.xxl),
                      const Radio<bool?>(value: null),
                      const Text('Nicht gesetzt'),
                    ],
                  ),
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
              Button(
                variant: ButtonVariant.primary,
                onPressed: () async {
                  await PupilMutator().updateAfterSchoolCare(
                    pupilId: pupil.pupilId,
                    emergencyCare: (value: currentValue),
                  );

                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                },
                label: 'SPEICHERN',
              ),
            ],
          );
        },
      );
    },
  );
}
