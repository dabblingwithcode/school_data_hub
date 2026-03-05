import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_helper.dart';

class NewLearningSupportPlanPage extends WatchingWidget {
  final NewLearningSupportPlanController controller;

  const NewLearningSupportPlanPage(this.controller, {super.key});

  String _getSupportLevelDescription(int level) {
    switch (level) {
      case 1:
        return 'Individueller Förderplan';
      case 2:
        return 'individuell erweiterter Förderplan';
      case 3:
        return 'Förderplan gemäß AO-SF § 21 (7)';
      default:
        return 'Unbekannte Förderebene';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSemester = watch(controller.semesterInfoNotifier).value;
    final isValid = watch(controller.isValidNotifier).value;

    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white,
        focusColor: AppColors.backgroundColor,
      ),
      child: Scaffold(
        backgroundColor: AppColors.canvasColor,
        appBar: GenericAppBar(
          iconData: Icons.support_rounded,
          title: controller.isEditing
              ? 'Förderplan bearbeiten'
              : 'Neuer Förderplan',
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Gap(8),
                            Expanded(
                              child: Text(
                                currentSemester,
                                style: AppStyles.title,
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        // Pupil Information Card
                        _PupilInformationCard(
                          pupil: controller.pupil,
                          groupTutorDisplayName:
                              controller.groupTutorDisplayName,
                        ),

                        const Gap(15),
                        // Support Level Display (Read-only)
                        const Text('Förderebene', style: AppStyles.title),
                        const Gap(10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: AppColors.backgroundColor.withValues(
                                alpha: 0.3,
                              ),
                              width: 2,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Gap(6),
                                Text(
                                  '${controller.fixedSupportLevel} ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.interactiveColor,
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getSupportLevelDescription(
                                          controller.fixedSupportLevel,
                                        ),
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

                        // Number Field
                        const Text('Plan-Nummer *', style: AppStyles.title),
                        const Gap(10),
                        TextField(
                          controller: controller.numberController,
                          keyboardType: TextInputType.number,
                          decoration: AppStyles.textFieldDecoration(
                            labelText: 'Plan-Nummer',
                          ),
                          onChanged: (_) => controller.validateForm(),
                        ),
                        const Gap(20),

                        // Plan ID Field
                        // const Text('Plan-Bezeichnung *', style: AppStyles.title),
                        // const Gap(10),
                        // TextField(
                        //   controller: controller.planIdController,
                        //   readOnly: controller.isEditing,
                        //   decoration: AppStyles.textFieldDecoration(
                        //     labelText: 'z.B. Förderplan 2024/1 - Max Mustermann',
                        //   ),
                        //   onChanged: (_) => controller.validateForm(),
                        // ),
                        // const Gap(20),

                        // Special Needs Teacher Field
                        const Text('Sonderpädagog*in', style: AppStyles.title),
                        const Gap(10),
                        TextField(
                          controller: controller.specialNeedsTeacherController,
                          decoration: AppStyles.textFieldDecoration(
                            labelText: '(kann später ausgefüllt werden)',
                          ),
                          onChanged: (_) => controller.validateForm(),
                        ),
                        const Gap(20),

                        // Social Pedagogue Field
                        const Text('Sozialpädagoge', style: AppStyles.title),
                        const Gap(10),
                        TextField(
                          controller: controller.socialPedagogueController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: AppColors.backgroundColor,
                            ),
                            labelText: 'Sozialpädagoge',
                            hintText:
                                'Name des Sozialpädagogen (Kann später ausgefüllt werden)',
                          ),
                        ),

                        const Gap(20),

                        // Professionals Involved Field
                        const Text(
                          'Beteiligte Fachkräfte',
                          style: AppStyles.title,
                        ),
                        const Gap(10),
                        TextField(
                          controller:
                              controller.proffesionalsInvolvedController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: AppColors.backgroundColor,
                            ),
                            labelText: '(Kann später ausgefüllt werden)',
                            hintText:
                                'Liste der beteiligten Fachkräfte (Kann später ausgefüllt werden)',
                          ),
                        ),

                        const Gap(20),

                        // Strengths Description Field
                        const Text(
                          'Stärkenbeschreibung',
                          style: AppStyles.title,
                        ),
                        const Gap(10),
                        TextField(
                          controller: controller.strengthsDescriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: AppColors.backgroundColor,
                            ),
                            labelText: 'Stärkenbeschreibung',
                            hintText:
                                'Beschreibung der Stärken des Schülers (Kann später ausgefüllt werden)',
                          ),
                        ),

                        const Gap(20),

                        // Problems Description Field
                        const Text(
                          'Problembeschreibung',
                          style: AppStyles.title,
                        ),
                        const Gap(10),
                        TextField(
                          controller: controller.problemsDescriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: AppColors.backgroundColor,
                            ),
                            labelText: 'Problembeschreibung',
                            hintText:
                                'Beschreibung der Probleme und Herausforderungen (Kann später ausgefüllt werden)',
                          ),
                        ),
                        const Gap(20),

                        // Comment Field
                        const Text(
                          'Ergänzende Hinweise und Absprachen',
                          style: AppStyles.title,
                        ),
                        const Gap(10),
                        TextField(
                          controller: controller.commentController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.backgroundColor,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: AppColors.backgroundColor,
                            ),
                            labelText: 'Hinweise und Absprachen',
                            hintText:
                                'Zusätzliche Bemerkungen zum Förderplan (Kann später ausgefüllt werden)',
                          ),
                        ),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
                // Action Buttons - Fixed at bottom
                Container(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    bottom: 16.0,
                    right: 16.0,
                    top: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.canvasColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: isValid
                              ? AppStyles.actionButtonStyle
                              : ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  minimumSize: const Size.fromHeight(50),
                                ),
                          onPressed: isValid ? controller.savePlan : null,
                          child: Text(
                            controller.isEditing
                                ? 'FÖRDERPLAN SPEICHERN'
                                : 'FÖRDERPLAN ERSTELLEN',
                            style: AppStyles.buttonTextStyle,
                          ),
                        ),
                      ),
                      const Gap(10),
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

class _PupilInformationCard extends StatelessWidget {
  final PupilProxy pupil;
  final String? groupTutorDisplayName;

  const _PupilInformationCard({
    required this.pupil,
    required this.groupTutorDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    final schulbesuchsjahr = PupilProxyHelper.calculateSchulbesuchsjahr(pupil);
    final lernjahr = PupilProxyHelper.calculateLernjahr(pupil);

    return Container(
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
          const Text('Name des Kindes', style: AppStyles.textLabel),
          const Gap(8),
          Text(
            '${pupil.firstName} ${pupil.lastName}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const Gap(12),
          _PupilBasicInfoRow(pupil: pupil, schulbesuchsjahr: schulbesuchsjahr),
          const Gap(5),
          _PupilInfoField(
            icon: Icons.calendar_today_outlined,
            label: 'Schulbesuchsjahr',
            value: schulbesuchsjahr.toString(),
          ),
          if (groupTutorDisplayName != null) ...[
            const Gap(8),
            _PupilInfoField(
              icon: Icons.person_outline,
              label: 'Klassenlehrer*in',
              value: groupTutorDisplayName!,
            ),
          ],
          const Gap(8),
          _PupilLanguageInfo(pupil: pupil, lernjahr: lernjahr),
          if (pupil.specialNeeds != null && pupil.specialNeeds!.isNotEmpty) ...[
            const Gap(8),
            _PupilSpecialNeedsInfo(specialNeeds: pupil.specialNeeds!),
          ],
        ],
      ),
    );
  }
}

class _PupilBasicInfoRow extends StatelessWidget {
  final PupilProxy pupil;
  final int schulbesuchsjahr;

  const _PupilBasicInfoRow({
    required this.pupil,
    required this.schulbesuchsjahr,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PupilInfoField(
              icon: Icons.class_outlined,
              label: 'Klasse',
              value: pupil.group,
            ),
            _PupilInfoField(
              icon: Icons.school_outlined,
              label: 'Jahrgang',
              value: pupil.schoolGrade.name,
            ),
          ],
        ),
      ],
    );
  }
}

class _PupilInfoField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _PupilInfoField({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const Gap(5),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const Gap(5),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _PupilLanguageInfo extends StatelessWidget {
  final PupilProxy pupil;
  final int? lernjahr;

  const _PupilLanguageInfo({required this.pupil, required this.lernjahr});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PupilInfoField(
          icon: Icons.translate_rounded,
          label: 'Familiensprache',
          value: pupil.language,
        ),
        if (lernjahr != null) ...[
          const Gap(4),
          _PupilInfoField(
            icon: Icons.school_outlined,
            label: 'Lernjahr Deutsch',
            value: lernjahr == 4 ? '>3' : lernjahr.toString(),
          ),
        ],
      ],
    );
  }
}

class _PupilSpecialNeedsInfo extends StatelessWidget {
  final String specialNeeds;

  const _PupilSpecialNeedsInfo({required this.specialNeeds});

  @override
  Widget build(BuildContext context) {
    // Special needs format: "CODE1*CODE2" (e.g., "LE*ES")
    final parts = specialNeeds.split('*');
    final code1 = parts.isNotEmpty ? parts[0] : '';
    final code2 = parts.length > 1 ? parts[1] : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.accessibility_new, size: 16, color: Colors.grey),
            Gap(6),
            Text(
              'Förderschwerpunkt(e)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            if (code1.isNotEmpty) ...[
              Text(
                code1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.interactiveColor,
                  letterSpacing: 1.2,
                ),
              ),
              if (code2.isNotEmpty)
                Text(
                  code2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.interactiveColor,
                    letterSpacing: 1.2,
                  ),
                ),
            ],
          ],
        ),
      ],
    );
  }
}
