import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/select_support_category_page/select_support_category_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/goal_examples_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_category_parents_names.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';

class NewSupportCategoryStatusPage extends StatelessWidget {
  final NewSupportCategoryStatusController controller;
  const NewSupportCategoryStatusPage(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final pupilManager = di<PupilProxyManager>();
    final learningSupportPlanManager = di<LearningSupportManager>();
    final supportCategoryManager = di<SupportCategoryManager>();
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white,
        focusColor: AppColors.backgroundColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            controller.widget.appBarTitle,
            style: AppStyles.appBarTextStyle,
          ),
        ),
        body: Center(
          heightFactor: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Row(
                          children: [
                            Text(
                              'Förderkategorie',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        controller.goalCategoryId == null ||
                                controller.goalCategoryId == 0
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: AppColors.backgroundColor,
                                  minimumSize: const Size.fromHeight(60),
                                ),
                                onPressed: () async {
                                  final int? categoryId =
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) =>
                                              SelectSupportCategoryPage(
                                                pupil: pupilManager
                                                    .getPupilByPupilId(
                                                      controller.widget.pupilId,
                                                    )!,
                                                elementType: controller
                                                    .widget
                                                    .elementType,
                                              ),
                                        ),
                                      );
                                  if (categoryId == null) {
                                    return;
                                  }
                                  controller.setGoalCategoryId(categoryId);
                                },
                                child: const Text(
                                  'KATEGORIE AUSWÄHLEN',
                                  style: AppStyles.buttonTextStyle,
                                ),
                              )
                            : CategoryTreeAncestors(
                                showBadge: true,
                                categoryId: controller.goalCategoryId!,
                              ),

                        const Gap(5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (controller.widget.appBarTitle ==
                                          'Neues Förderziel' ||
                                      controller.isEditMode)
                                  ? 'Förderziel'
                                  : 'Beobachtungen',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        if (controller.widget.appBarTitle ==
                                'Neues Förderziel' ||
                            controller.isEditMode) ...[
                          TextField(
                            minLines: 1,
                            maxLines: 3,
                            controller:
                                controller.descriptionTextFieldController,
                            decoration: AppStyles.textFieldDecoration(
                              labelText: 'Beschreibung des Zieles',
                            ),
                          ),
                          const Gap(20),
                          const Row(
                            children: [
                              Text(
                                'Strategien',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                        ],
                        TextField(
                          minLines: 4,
                          maxLines: 4,
                          controller: controller.strategiesTextField2Controller,
                          decoration: AppStyles.textFieldDecoration(
                            labelText:
                                (controller.widget.appBarTitle ==
                                        'Neues Förderziel' ||
                                    controller.isEditMode)
                                ? 'Hilfen für das Erreichen des Zieles'
                                : 'Beschreibung des Ist-Zustandes',
                          ),
                        ),
                        const Gap(20),
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
                              const Gap(10),
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
                          ElevatedButton(
                            style: AppStyles.actionButtonStyle,
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
                            child: const Text(
                              'BEISPIELE',
                              style: AppStyles.buttonTextStyle,
                            ),
                          ),
                          const Gap(15),
                        ],
                      ElevatedButton(
                        style: AppStyles.successButtonStyle,
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
                        child: Text(
                          controller.isEditMode ? 'SPEICHERN' : 'SENDEN',
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                      const Gap(15),
                      ElevatedButton(
                        style: AppStyles.cancelButtonStyle,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'ABBRECHEN',
                          style: AppStyles.buttonTextStyle,
                        ),
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
