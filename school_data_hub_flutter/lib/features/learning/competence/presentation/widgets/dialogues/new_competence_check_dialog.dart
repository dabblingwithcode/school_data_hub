import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

final GlobalKey<FormState> _competenceStatusKey = GlobalKey<FormState>();
final TextEditingController _textEditingController = TextEditingController();

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> newCompetenceCheckDialog({
  required PupilProxy pupil,
  required int competenceId,
  required bool isReport,
  required BuildContext parentContext,
}) async {
  return await showDialog(
    context: parentContext,
    builder: (context) {
      int competenceCheckStatusValue = 0;
      final style = Style.of(context);
      return StatefulBuilder(
        builder: (statefulContext, setState) {
          void onChangedFunction(int newValue) {
            setState(() {
              competenceCheckStatusValue = newValue;
            });
          }

          return AlertDialog(
            content: Form(
              key: _competenceStatusKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: style.colors.accent),
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    width: 300,
                    child: Padding(
                      padding: EdgeInsets.all(Style.spacing.sm),
                      child: TextField(
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: context.typography.subtitle,
                        keyboardType: TextInputType.multiline,
                        controller: _textEditingController,
                        decoration: null,
                      ),
                    ),
                  ),
                  Gap(Style.spacing.sm),
                  Row(
                    children: [
                      Text(
                        'Eine Stufe auswählen:',
                        style: context.typography.body.bold,
                      ),
                      Gap(Style.spacing.sm),
                      GrowthDropdown(
                        dropdownValue: competenceCheckStatusValue,
                        onChangedFunction: onChangedFunction,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            title: const Text('Neuer Kompetenzcheck'),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: Style.spacing.sm),
                child: Button(
                  label: 'ABBRECHEN',
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    _textEditingController.clear();
                    Navigator.of(parentContext).pop();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: Style.spacing.sm),
                child: Button(
                  label: 'SENDEN',
                  onPressed: () async {
                    if (_competenceStatusKey.currentState!.validate()) {
                      await di<CompetenceManager>().postCompetenceCheck(
                        pupilId: pupil.pupilId,
                        competenceId: competenceId,
                        score: competenceCheckStatusValue,
                        competenceComment: _textEditingController.text,
                        groupId: null,
                      );

                      _textEditingController.clear();
                      if (parentContext.mounted) {
                        Navigator.of(parentContext).pop();
                      }
                    }
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
