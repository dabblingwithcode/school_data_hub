import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';

final GlobalKey<FormState> _categoryStatusKey = GlobalKey<FormState>();
final TextEditingController _textEditingController = TextEditingController();
// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> supportCategoryStatusDialog(
  PupilProxy pupil,
  int goalCategoryId,
  BuildContext parentContext,
) async {
  return await showDialog(
    context: parentContext,
    builder: (context) {
      int categoryStatusValue = 1;
      return StatefulBuilder(
        builder: (statefulContext, setState) {
          final style = Style.of(statefulContext);
          return AlertDialog(
            content: Form(
              key: _categoryStatusKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: style.colors.accent),
                      borderRadius: BorderRadius.circular(Style.spacing.xs),
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
                  Gap(Style.spacing.md),
                  Row(
                    children: [
                      Text(
                        'Eine Stufe auswählen:',
                        style: context.typography.body.bold,
                      ),
                      Gap(Style.spacing.md),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: GrowthDropdown(
                          dropdownValue: categoryStatusValue,
                          onChangedFunction: (newValue) {
                            setState(() {
                              categoryStatusValue = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            title: const Text('Neuer Kategoriestatus'),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: Style.spacing.lg,
                  right: Style.spacing.lg,
                  bottom: Style.spacing.md,
                ),
                child: Button(
                  variant: ButtonVariant.destructive,
                  onPressed: () {
                    _textEditingController.clear();
                    Navigator.of(parentContext).pop();
                  },
                  label: 'ABBRECHEN',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Style.spacing.lg,
                  right: Style.spacing.lg,
                  bottom: Style.spacing.md,
                ),
                child: Button(
                  onPressed: () async {
                    if (_categoryStatusKey.currentState!.validate()) {
                      await di<LearningSupportManager>()
                          .postSupportCategoryStatus(
                            pupilId: pupil.pupilId,
                            supportCategoryId: goalCategoryId,
                            status: categoryStatusValue,
                            comment: _textEditingController.text,
                          );
                      _textEditingController.clear();
                      if (parentContext.mounted) {
                        Navigator.of(parentContext).pop();
                      }
                    }
                  },
                  label: 'OKAY',
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
