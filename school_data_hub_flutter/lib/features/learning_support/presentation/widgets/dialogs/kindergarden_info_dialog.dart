import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';

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
      final monthsController = TextEditingController(
        text: attendedMonths > 0 ? attendedMonths.toString() : '',
      );
      final commentsController = TextEditingController(text: comments);

      return StatefulBuilder(
        builder: (context, setState) {
          final style = Style.of(context);
          return AlertDialog(
            contentPadding: EdgeInsets.all(Style.spacing.xl),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Info box
                  Container(
                    padding: EdgeInsets.all(Style.spacing.md),
                    decoration: BoxDecoration(
                      color: style.colors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Style.radii.small),
                      border: Border.all(
                        color: style.colors.accent.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.child_care,
                          color: style.colors.accent,
                          size: 20,
                        ),
                        Gap(Style.spacing.sm),
                        Expanded(
                          child: Text(
                            'Informationen zum Kindergartenbesuch des Kindes.',
                            style: context.typography.body.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(Style.spacing.lg),
                  // Attended months input
                  TextField(
                    controller: monthsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(Style.spacing.sm),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Style.radii.small),
                      ),
                      labelText: 'Besuchte Monate',
                    ),
                    onChanged: (value) {
                      attendedMonths = int.tryParse(value) ?? 0;
                    },
                  ),
                  Gap(Style.spacing.md),
                  // Comments input
                  TextField(
                    controller: commentsController,
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    style: context.typography.subtitle,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(Style.spacing.sm),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Style.radii.small),
                      ),
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
                Icon(Icons.child_care, color: style.colors.accent, size: 24),
                Gap(Style.spacing.sm),
                const Text('Kindergartenbesuch'),
              ],
            ),
            actions: <Widget>[
              Button.small(
                variant: ButtonVariant.ghost,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: 'ABBRECHEN',
              ),
              // Delete button (only if data already exists)
              if (currentInfo != null)
                Button.small(
                  variant: ButtonVariant.destructive,
                  onPressed: () async {
                    await di<PupilMutator>().updateKindergardenInfo(
                      pupilId: pupil.pupilId,
                      kindergardenInfo: null,
                    );
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  label: 'LÖSCHEN',
                ),
              Button.small(
                onPressed: () async {
                  final newInfo = KindergardenInfo(
                    attendedMonths: attendedMonths,
                    comments: comments,
                  );
                  await PupilMutator().updateKindergardenInfo(
                    pupilId: pupil.pupilId,
                    kindergardenInfo: newInfo,
                  );
                  if (context.mounted) Navigator.of(context).pop();
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
