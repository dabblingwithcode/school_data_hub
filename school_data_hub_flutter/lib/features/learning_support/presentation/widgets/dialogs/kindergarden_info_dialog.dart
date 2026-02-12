import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:flutter_it/flutter_it.dart';

Future<void> kindergardenInfoDialog(
  BuildContext context,
  PupilProxy pupil,
  KindergardenInfo? currentInfo,
) async {
  return await showDialog(
    context: context,
    builder: (context) {
      int attendedMonths = currentInfo?.attendedMonths ?? 0;
      String comments = currentInfo?.comments ?? '';

      return StatefulBuilder(
        builder: (context, setState) {
          final monthsController = TextEditingController(
            text: attendedMonths > 0 ? attendedMonths.toString() : '',
          );
          final commentsController = TextEditingController(text: comments);

          return AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Info box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.accentColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.child_care,
                          color: AppColors.accentColor,
                          size: 20,
                        ),
                        const Gap(8),
                        const Expanded(
                          child: Text(
                            'Informationen zum Kindergartenbesuch des Kindes.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(16),
                  // Attended months input
                  TextField(
                    controller: monthsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Besuchte Monate',
                    ),
                    onChanged: (value) {
                      attendedMonths = int.tryParse(value) ?? 0;
                    },
                  ),
                  const Gap(12),
                  // Comments input
                  TextField(
                    controller: commentsController,
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.multiline,
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Anmerkungen',
                    ),
                    onChanged: (value) {
                      comments = value;
                    },
                  ),
                ],
              ),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.child_care,
                  color: AppColors.accentColor,
                  size: 24,
                ),
                const Gap(8),
                const Text('Kindergartenbesuch'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  monthsController.dispose();
                  commentsController.dispose();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'ABBRECHEN',
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Delete button (only if data already exists)
              if (currentInfo != null)
                TextButton(
                  onPressed: () async {
                    monthsController.dispose();
                    commentsController.dispose();
                    await di<PupilMutator>().updateKindergardenInfo(
                      pupilId: pupil.pupilId,
                      kindergardenInfo: null,
                    );
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: const Text(
                    'LÖSCHEN',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () async {
                  final newInfo = KindergardenInfo(
                    attendedMonths: attendedMonths,
                    comments: comments,
                  );
                  monthsController.dispose();
                  commentsController.dispose();
                  await di<PupilMutator>().updateKindergardenInfo(
                    pupilId: pupil.pupilId,
                    kindergardenInfo: newInfo,
                  );
                  if (context.mounted) Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'SPEICHERN',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
