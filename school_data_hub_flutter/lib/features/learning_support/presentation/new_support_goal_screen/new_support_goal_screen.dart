import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_screen/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/select_support_category_screen/select_support_category_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_category_parents_names.dart';

class NewSupportGoalScreen extends StatelessWidget {
  final NewSupportCategoryStatusController controller;
  const NewSupportGoalScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupilManager = di<PupilProxyManager>();
    final learningSupportManager = di<SupportCategoryManager>();
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: style.colors.background,
        focusColor: style.colors.accent,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: style.colors.accent,
          title: Text(controller.widget.appBarTitle),
        ),
        body: Center(
          heightFactor: 1,
          child: Padding(
            padding: EdgeInsets.all(Style.spacing.lg),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          'Förderkategorie',
                          style: context.typography.title.withColor(
                            style.colors.foreground,
                          ),
                        ),
                      ],
                    ),
                    Gap(Style.spacing.md),
                    controller.goalCategoryId == null ||
                            controller.goalCategoryId == 0
                        ? Button(
                            onPressed: () async {
                              final int?
                              categoryId = await Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute<int>(
                                  builder: (ctx) => SelectSupportCategoryScreen(
                                    pupil: pupilManager.getPupilByPupilId(
                                      controller.widget.pupilId,
                                    )!,
                                    elementType: controller.widget.elementType,
                                  ),
                                ),
                              );
                              if (categoryId == null) {
                                return;
                              }
                              controller.setGoalCategoryId(categoryId);
                            },
                            label: 'KATEGORIE AUSWÄHLEN',
                          )
                        : GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: learningSupportManager.getCategoryColor(
                                  controller.goalCategoryId!,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 8,
                                ),
                                child: CategoryTreeAncestors(
                                  categoryId: controller.goalCategoryId!,
                                ),
                              ),
                            ),
                          ),
                    Gap(Style.spacing.md),
                    controller.goalCategoryId == null
                        ? const SizedBox.shrink()
                        : controller.goalCategoryId == 0
                        ? const SizedBox.shrink()
                        : Row(
                            children: [
                              Flexible(
                                child: Text(
                                  learningSupportManager
                                      .getSupportCategory(
                                        controller.goalCategoryId!,
                                      )
                                      .name,
                                  style: context.typography.title.withColor(
                                    learningSupportManager.getCategoryColor(
                                      controller.goalCategoryId!,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    Gap(Style.spacing.lg),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (controller.widget.appBarTitle == 'Neues Förderziel')
                              ? 'Förderziel'
                              : 'Status',
                          style: context.typography.title.withColor(
                            style.colors.foreground,
                          ),
                        ),
                      ],
                    ),
                    Gap(Style.spacing.md),
                    if (controller.widget.appBarTitle ==
                        'Neues Förderziel') ...[
                      TextField(
                        minLines: 1,
                        maxLines: 3,
                        controller: controller.descriptionTextFieldController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(Style.spacing.sm),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              Style.radii.small,
                            ),
                          ),
                          labelText: 'Beschreibung des Zieles',
                        ),
                      ),
                      Gap(Style.spacing.xl),
                      Row(
                        children: [
                          Text(
                            'Strategien',
                            style: context.typography.title.withColor(
                              style.colors.foreground,
                            ),
                          ),
                        ],
                      ),
                      Gap(Style.spacing.md),
                    ],
                    TextField(
                      minLines: 3,
                      maxLines: 4,
                      controller: controller.strategiesTextField2Controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(Style.spacing.sm),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Style.radii.small,
                          ),
                        ),
                        labelText:
                            (controller.widget.appBarTitle ==
                                'Neues Förderziel')
                            ? 'Hilfen für das Erreichen des Zieles'
                            : 'Beschreibung des Status',
                      ),
                    ),
                    Gap(Style.spacing.xl),
                    if (controller.widget.appBarTitle != 'Neues Förderziel')
                      Row(
                        children: [
                          const Text(
                            'Eine Farbe auswählen:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Gap(Style.spacing.md),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: GrowthDropdown(
                              dropdownValue: controller.categoryStatusValue,
                              onChangedFunction: (newValue) {
                                controller.setCategoryStatusValue(newValue);
                              },
                            ),
                          ),
                        ],
                      ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
                    Button(
                      onPressed: () {
                        if (controller.widget.appBarTitle ==
                            'Neues Förderziel') {
                          controller.postCategoryGoal();
                        } else {
                          controller.postCategoryStatus();
                        }
                        Navigator.pop(context);
                      },
                      label: 'SENDEN',
                    ),
                    Gap(Style.spacing.lg),
                    Button(
                      variant: ButtonVariant.secondary,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: 'ABBRECHEN',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
