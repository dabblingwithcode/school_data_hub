import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_screen/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/goal_examples_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_category_parents_names.dart';

class NewSupportCategoryStatusScreen extends StatelessWidget {
  final NewSupportCategoryStatusController controller;
  const NewSupportCategoryStatusScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupilManager = di<PupilProxyManager>();
    final learningSupportPlanManager = di<LearningSupportManager>();
    final supportCategoryManager = di<SupportCategoryManager>();
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: style.colors.background,
        focusColor: style.colors.accent,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: style.colors.accent,
          title: Text(
            controller.widget.appBarTitle,
            style: context.typography.title.withColor(style.colors.background),
          ),
        ),
        body: Center(
          heightFactor: 1,
          child: Padding(
            padding: EdgeInsets.all(Style.spacing.md),
            child: Column(
              children: [
                SingleChildScrollView(
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
                        Gap(Style.spacing.xs),
                        controller.goalCategoryId == null ||
                                controller.goalCategoryId == 0
                            ? Button(
                                onPressed: () async {
                                  final int? categoryId =
                                      await context.push<int>(
                                        RoutePaths.learningSupportCategorySelect,
                                        extra: {
                                          'pupil': pupilManager
                                              .getPupilByPupilId(
                                                controller.widget.pupilId,
                                              )!,
                                          'elementType':
                                              controller.widget.elementType,
                                        },
                                      );
                                  if (categoryId == null) {
                                    return;
                                  }
                                  controller.setGoalCategoryId(categoryId);
                                },
                                label: 'KATEGORIE AUSWÄHLEN',
                              )
                            : CategoryTreeAncestors(
                                showBadge: true,
                                categoryId: controller.goalCategoryId!,
                              ),

                        Gap(Style.spacing.xs),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (controller.widget.appBarTitle ==
                                          'Neues Förderziel' ||
                                      controller.isEditMode)
                                  ? 'Förderziel'
                                  : 'Beobachtungen',
                              style: context.typography.title.withColor(
                                style.colors.foreground,
                              ),
                            ),
                          ],
                        ),
                        Gap(Style.spacing.xs),
                        if (controller.widget.appBarTitle ==
                                'Neues Förderziel' ||
                            controller.isEditMode) ...[
                          TextField(
                            minLines: 1,
                            maxLines: 3,
                            controller:
                                controller.descriptionTextFieldController,
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
                          minLines: 4,
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
                                        'Neues Förderziel' ||
                                    controller.isEditMode)
                                ? 'Hilfen für das Erreichen des Zieles'
                                : 'Beschreibung des Ist-Zustandes',
                          ),
                        ),
                        Gap(Style.spacing.xl),
                        if (controller.widget.appBarTitle !=
                                'Neues Förderziel' &&
                            !controller.isEditMode)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ist-Zustand:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Gap(Style.spacing.md),
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GrowthDropdown(
                                  dropdownValue: controller.categoryStatusValue,
                                  onChangedFunction: (newValue) {
                                    controller.setCategoryStatusValue(newValue);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                              ),
                            ],
                          ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      if (controller.goalCategoryId != null)
                        if (supportCategoryManager
                            .getGoalsForSupportCategory(
                              controller.goalCategoryId!,
                            )
                            .isNotEmpty) ...<Widget>[
                          Button(
                            onPressed: () async {
                              final Map<String, String?>? result =
                                  await goalExamplesDialog(
                                    context,
                                    'Beispiele',
                                    supportCategoryManager
                                        .getGoalsForSupportCategory(
                                          controller.goalCategoryId!,
                                        ),
                                  );
                              if (result != null) {
                                controller.setTextFieldControllerValues(
                                  description: result['goal']!,
                                  strategies: result['strategies']!,
                                );
                              }
                            },
                            label: 'BEISPIELE',
                          ),
                          Gap(Style.spacing.lg),
                        ],
                      Button(
                        onPressed: () {
                          if (controller.isEditMode) {
                            controller.updateCategoryGoal();
                          } else if (controller.widget.appBarTitle ==
                              'Neues Förderziel') {
                            controller.postCategoryGoal();
                          } else {
                            learningSupportPlanManager
                                .postSupportCategoryStatus(
                                  pupilId: controller.widget.pupilId,
                                  supportCategoryId: controller.goalCategoryId!,
                                  status: controller.categoryStatusValue,
                                  comment: controller
                                      .strategiesTextField2Controller
                                      .text,
                                );
                          }
                          Navigator.pop(context);
                        },
                        label: controller.isEditMode ? 'SPEICHERN' : 'SENDEN',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
