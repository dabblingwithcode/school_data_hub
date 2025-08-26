import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

class NewLearningSupportPlanPage extends WatchingWidget {
  final NewLearningSupportPlanController controller;

  const NewLearningSupportPlanPage(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final currentSemester = di<SchoolCalendarManager>().currentSemester;
    // final currentSemester =
    //     watchPropertyValue(
    //       (SchoolCalendarManager m) => m.currentSemester,
    //     ).value;

    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white,
        focusColor: AppColors.backgroundColor,
      ),
      child: Scaffold(
        backgroundColor: AppColors.canvasColor,
        appBar: const GenericAppBar(
          iconData: Icons.support_rounded,
          title: 'Neuer Förderplan',
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pupil Information Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Schüler/in', style: AppStyles.title),
                        const Gap(8),
                        Text(
                          '${controller.pupil.firstName} ${controller.pupil.lastName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          'Klasse: ${controller.pupil.schoolGrade}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Gap(20),

                  // Support Level Selection
                  Text('Förderstufe *', style: AppStyles.title),
                  const Gap(10),
                  ValueListenableBuilder<int?>(
                    valueListenable: controller.selectedSupportLevelNotifier,
                    builder: (context, selectedLevel, child) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color:
                                selectedLevel == null
                                    ? Colors.red.withValues(alpha: 0.5)
                                    : AppColors.backgroundColor.withValues(
                                      alpha: 0.3,
                                    ),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => controller.setSupportLevel(1),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Icon(
                                      selectedLevel == 1
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: AppColors.backgroundColor,
                                    ),
                                    const Gap(10),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Stufe 1 - Präventive Förderung',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Text(
                                            'Grundlegende Unterstützung im Regelunterricht',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(height: 1),
                            InkWell(
                              onTap: () => controller.setSupportLevel(2),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Icon(
                                      selectedLevel == 2
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: AppColors.backgroundColor,
                                    ),
                                    const Gap(10),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Stufe 2 - Erweiterte Förderung',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Text(
                                            'Zusätzliche individuelle Fördermaßnahmen',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(height: 1),
                            InkWell(
                              onTap: () => controller.setSupportLevel(3),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Icon(
                                      selectedLevel == 3
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: AppColors.backgroundColor,
                                    ),
                                    const Gap(10),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Stufe 3 - Intensive Förderung',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Text(
                                            'Umfassende sonderpädagogische Unterstützung',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const Gap(20),

                  // Plan ID Field
                  const Text('Plan-Bezeichnung *', style: AppStyles.title),
                  const Gap(10),
                  TextField(
                    controller: controller.planIdController,
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'z.B. Förderplan 2024/1 - Max Mustermann',
                    ),
                    onChanged: (_) => controller.validateForm(),
                  ),

                  const Gap(20),

                  // Comment Field
                  Text('Kommentar', style: AppStyles.title),
                  const Gap(10),
                  TextField(
                    controller: controller.commentController,
                    maxLines: 4,
                    decoration: AppStyles.textFieldDecoration(
                      labelText:
                          'Zusätzliche Bemerkungen zum Förderplan (optional)',
                    ),
                  ),

                  const Gap(30),

                  // Semester Information
                  ValueListenableBuilder<String>(
                    valueListenable: controller.semesterInfoNotifier,
                    builder: (context, currentSemester, child) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: AppColors.backgroundColor.withValues(
                              alpha: 0.3,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: AppColors.backgroundColor,
                              size: 20,
                            ),
                            const Gap(8),
                            const Text(
                              'Semesterinformation',
                              style: AppStyles.subtitle,
                            ),
                            const Gap(4),
                            Text(
                              currentSemester,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const Gap(40),

                  // Action Buttons
                  ValueListenableBuilder<bool>(
                    valueListenable: controller.isValidNotifier,
                    builder: (context, isValid, child) {
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style:
                                  isValid
                                      ? AppStyles.actionButtonStyle
                                      : ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                              onPressed: isValid ? controller.createPlan : null,
                              child: const Text(
                                'FÖRDERPLAN ERSTELLEN',
                                style: AppStyles.buttonTextStyle,
                              ),
                            ),
                          ),
                          const Gap(15),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: AppStyles.cancelButtonStyle,
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'ABBRECHEN',
                                style: AppStyles.buttonTextStyle,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
