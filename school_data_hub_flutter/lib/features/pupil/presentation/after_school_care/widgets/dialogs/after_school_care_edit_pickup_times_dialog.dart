import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';

Future<void> afterSchoolCareEditPickUpTimesDialog(
  BuildContext context,
  PupilProxy pupil,
) async {
  final afterSchoolCare = pupil.afterSchoolCare;
  final currentPickUpTimes = afterSchoolCare?.pickUpTimes;

  // Initialize form state
  final formKey = GlobalKey<FormState>();
  final mondayTimeController = TextEditingController(
    text: currentPickUpTimes?.monday?.time ?? '',
  );
  final mondayModalityController = TextEditingController(
    text: currentPickUpTimes?.monday?.modality ?? '',
  );
  final tuesdayTimeController = TextEditingController(
    text: currentPickUpTimes?.tuesday?.time ?? '',
  );
  final tuesdayModalityController = TextEditingController(
    text: currentPickUpTimes?.tuesday?.modality ?? '',
  );
  final wednesdayTimeController = TextEditingController(
    text: currentPickUpTimes?.wednesday?.time ?? '',
  );
  final wednesdayModalityController = TextEditingController(
    text: currentPickUpTimes?.wednesday?.modality ?? '',
  );
  final thursdayTimeController = TextEditingController(
    text: currentPickUpTimes?.thursday?.time ?? '',
  );
  final thursdayModalityController = TextEditingController(
    text: currentPickUpTimes?.thursday?.modality ?? '',
  );
  final fridayTimeController = TextEditingController(
    text: currentPickUpTimes?.friday?.time ?? '',
  );
  final fridayModalityController = TextEditingController(
    text: currentPickUpTimes?.friday?.modality ?? '',
  );

  final result = await showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Abholzeiten bearbeiten'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDayRow(
                  'Montag',
                  mondayTimeController,
                  mondayModalityController,
                ),
                const Gap(10),
                _buildDayRow(
                  'Dienstag',
                  tuesdayTimeController,
                  tuesdayModalityController,
                ),
                const Gap(10),
                _buildDayRow(
                  'Mittwoch',
                  wednesdayTimeController,
                  wednesdayModalityController,
                ),
                const Gap(10),
                _buildDayRow(
                  'Donnerstag',
                  thursdayTimeController,
                  thursdayModalityController,
                ),
                const Gap(10),
                _buildDayRow(
                  'Freitag',
                  fridayTimeController,
                  fridayModalityController,
                ),
              ],
            ),
          ),
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
              if (!formKey.currentState!.validate()) {
                return;
              }

              // Update pickup times for each weekday
              // The method updates one weekday at a time, so we call it for each weekday
              // We always call it for all weekdays to ensure cleared ones are processed
              // If time is empty string, it will create PickUpInfo with empty time (effectively clearing it)

              // Monday
              await PupilMutator().updateAfterSchoolCare(
                pupilId: pupil.pupilId,
                weekday: (value: AfterSchoolCareWeekday.monday),
                time: mondayTimeController.text.trim(),
                modality: mondayModalityController.text.trim(),
              );

              // Tuesday
              await PupilMutator().updateAfterSchoolCare(
                pupilId: pupil.pupilId,
                weekday: (value: AfterSchoolCareWeekday.tuesday),
                time: tuesdayTimeController.text.trim(),
                modality: tuesdayModalityController.text.trim(),
              );

              // Wednesday
              await PupilMutator().updateAfterSchoolCare(
                pupilId: pupil.pupilId,
                weekday: (value: AfterSchoolCareWeekday.wednesday),
                time: wednesdayTimeController.text.trim(),
                modality: wednesdayModalityController.text.trim(),
              );

              // Thursday
              await PupilMutator().updateAfterSchoolCare(
                pupilId: pupil.pupilId,
                weekday: (value: AfterSchoolCareWeekday.thursday),
                time: thursdayTimeController.text.trim(),
                modality: thursdayModalityController.text.trim(),
              );

              // Friday
              await PupilMutator().updateAfterSchoolCare(
                pupilId: pupil.pupilId,
                weekday: (value: AfterSchoolCareWeekday.friday),
                time: fridayTimeController.text.trim(),
                modality: fridayModalityController.text.trim(),
              );

              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('SPEICHERN', style: AppStyles.buttonTextStyle),
          ),
        ],
      );
    },
  );

  // Dispose controllers after the dialog is fully closed
  WidgetsBinding.instance.addPostFrameCallback((_) {
    mondayTimeController.dispose();
    mondayModalityController.dispose();
    tuesdayTimeController.dispose();
    tuesdayModalityController.dispose();
    wednesdayTimeController.dispose();
    wednesdayModalityController.dispose();
    thursdayTimeController.dispose();
    thursdayModalityController.dispose();
    fridayTimeController.dispose();
    fridayModalityController.dispose();
  });

  return result;
}

Widget _buildDayRow(
  String dayName,
  TextEditingController timeController,
  TextEditingController modalityController,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 80,
        child: Text(
          dayName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      const Gap(10),
      Expanded(
        flex: 2,
        child: TextFormField(
          controller: timeController,
          decoration: const InputDecoration(
            labelText: 'Zeit (z.B. 14:00)',
            hintText: '14:00',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Allow empty - means no pickup time for that day
            if (value == null || value.trim().isEmpty) {
              return null;
            }
            // Basic time format validation
            final timeRegex = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
            if (!timeRegex.hasMatch(value.trim())) {
              return 'Ungültiges Zeitformat (z.B. 14:00)';
            }
            return null;
          },
        ),
      ),
      const Gap(10),
      Expanded(
        flex: 3,
        child: TextFormField(
          controller: modalityController,
          decoration: const InputDecoration(
            labelText: 'Modality (optional)',
            hintText: 'z.B. Abholung, Bus, etc.',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    ],
  );
}
