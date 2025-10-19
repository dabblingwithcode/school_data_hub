import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';
import 'package:watch_it/watch_it.dart';

class NewLearningSupportPlanPage extends WatchingWidget {
  final NewLearningSupportPlanController controller;

  const NewLearningSupportPlanPage(this.controller, {super.key});

  String _getSupportLevelDescription(int level) {
    switch (level) {
      case 1:
        return 'Präventive Förderung';
      case 2:
        return 'Erweiterte Förderung';
      case 3:
        return 'Intensive Förderung';
      default:
        return 'Unbekannte Förderebene';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        const Text(
                          'Name des Kindes',
                          style: AppStyles.textLabel,
                        ),
                        const Gap(8),
                        Text(
                          '${controller.pupil.firstName} ${controller.pupil.lastName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(4),
                        Row(
                          children: [
                            Text(
                              'Klasse: ${controller.pupil.group}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Jahrgang: ${controller.pupil.schoolGrade.name}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        if (controller.groupTutorDisplayName != null) ...[
                          const Gap(4),
                          Text(
                            'Klassenlehrer: ${controller.groupTutorDisplayName}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const Gap(15),

                  // Semester Information
                  ValueListenableBuilder<String>(
                    valueListenable: controller.semesterInfoNotifier,
                    builder: (context, currentSemester, child) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
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
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: AppColors.backgroundColor,
                              size: 16,
                            ),
                            const Gap(8),
                            Expanded(
                              child: Text(
                                currentSemester,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const Gap(20),

                  // Support Level Display (Read-only)
                  const Text('Förderebene', style: AppStyles.title),
                  const Gap(10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: AppColors.backgroundColor.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.backgroundColor,
                          ),
                          const Gap(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.fixedSupportLevel} - ${_getSupportLevelDescription(controller.fixedSupportLevel)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  'Aktuelle Förderebene des Schülers',
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
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      labelStyle: const TextStyle(
                        color: AppColors.backgroundColor,
                      ),
                      labelText: 'Kommentar',
                      hintText:
                          'Zusätzliche Bemerkungen zum Förderplan (Kann später ausgefüllt werden)',
                    ),
                  ),

                  const Gap(20),

                  // Social Pedagogue Field
                  Text('Sozialpädagoge', style: AppStyles.title),
                  const Gap(10),
                  TextField(
                    controller: controller.socialPedagogueController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      labelStyle: const TextStyle(
                        color: AppColors.backgroundColor,
                      ),
                      labelText: 'Sozialpädagoge',
                      hintText:
                          'Name des Sozialpädagogen (Kann später ausgefüllt werden)',
                    ),
                  ),

                  const Gap(20),

                  // Professionals Involved Field
                  Text('Beteiligte Fachkräfte', style: AppStyles.title),
                  const Gap(10),
                  TextField(
                    controller: controller.proffesionalsInvolvedController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(color: AppColors.backgroundColor),
                      labelText: '(Kann später ausgefüllt werden)',
                      hintText:
                          'Liste der beteiligten Fachkräfte (Kann später ausgefüllt werden)',
                    ),
                  ),

                  const Gap(20),

                  // Strengths Description Field
                  Text('Stärkenbeschreibung', style: AppStyles.title),
                  const Gap(10),
                  TextField(
                    controller: controller.strengthsDescriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      labelStyle: const TextStyle(
                        color: AppColors.backgroundColor,
                      ),
                      labelText: 'Stärkenbeschreibung',
                      hintText:
                          'Beschreibung der Stärken des Schülers (Kann später ausgefüllt werden)',
                    ),
                  ),

                  const Gap(20),

                  // Problems Description Field
                  Text('Problembeschreibung', style: AppStyles.title),
                  const Gap(10),
                  TextField(
                    controller: controller.problemsDescriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.backgroundColor,
                          width: 2,
                        ),
                      ),
                      labelStyle: const TextStyle(
                        color: AppColors.backgroundColor,
                      ),
                      labelText: 'Problembeschreibung',
                      hintText:
                          'Beschreibung der Probleme und Herausforderungen (Kann später ausgefüllt werden)',
                    ),
                  ),

                  const Gap(30),

                  // Action Buttons
                  ValueListenableBuilder<bool>(
                    valueListenable: controller.isValidNotifier,
                    builder: (context, isValid, child) {
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: isValid
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
