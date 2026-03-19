import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';

class NewLearningSupportPlanScreen extends WatchingWidget {
  final NewLearningSupportPlanController controller;

  const NewLearningSupportPlanScreen(this.controller, {super.key});

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
    final style = Style.of(context);
    final currentSemester = watch(controller.semesterInfoNotifier).value;
    final isValid = watch(controller.isValidNotifier).value;

    return Theme(
      data: ThemeData(
        unselectedWidgetColor: style.colors.background,
        focusColor: style.colors.accent,
      ),
      child: Scaffold(
        backgroundColor: style.colors.canvas,
        appBar: AppHeader(
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
                    padding: EdgeInsets.all(Style.spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Gap(Style.spacing.sm),
                            Expanded(
                              child: Text(
                                currentSemester,
                                style: context.typography.title,
                              ),
                            ),
                          ],
                        ),
                        Gap(Style.spacing.xl),
                        // Pupil Information Card
                        _PupilInformationCard(
                          pupil: controller.pupil,
                          groupTutorDisplayName:
                              controller.groupTutorDisplayName,
                        ),

                        Gap(Style.spacing.lg),
                        // Support Level Display (Read-only)
                        Text('Förderebene', style: context.typography.title),
                        Gap(Style.spacing.md),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: style.colors.background,
                            borderRadius: BorderRadius.circular(Style.radii.medium),
                            border: Border.all(
                              color: style.colors.accent.withValues(
                                alpha: 0.3,
                              ),
                              width: 2,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(Style.spacing.md),
                            child: Row(
                              children: [
                                const Gap(6),
                                Text(
                                  '${controller.fixedSupportLevel} ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: style.colors.interactive,
                                  ),
                                ),
                                Gap(Style.spacing.md),
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
                                      Text(
                                        'Aktuelle Förderebene des Schülers',
                                        style: context.typography.bodySmall.withColor(style.colors.mutedForeground),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Gap(Style.spacing.xl),

                        // Number Field
                        Text('Plan-Nummer *', style: context.typography.title),
                        Gap(Style.spacing.md),
                        TextField(
                          controller: controller.numberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(Style.spacing.sm),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Style.radii.small),
                            ),
                            labelText: 'Plan-Nummer',
                          ),
                          onChanged: (_) => controller.validateForm(),
                        ),
                        Gap(Style.spacing.xl),

                        // Special Needs Teacher Field
                        Text('Sonderpädagog*in', style: context.typography.title),
                        Gap(Style.spacing.md),
                        TextField(
                          controller: controller.specialNeedsTeacherController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(Style.spacing.sm),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Style.radii.small),
                            ),
                            labelText: '(kann später ausgefüllt werden)',
                          ),
                          onChanged: (_) => controller.validateForm(),
                        ),
                        Gap(Style.spacing.xl),

                        // Social Pedagogue Field
                        Text('Sozialpädagoge', style: context.typography.title),
                        Gap(Style.spacing.md),
                        TextField(
                          controller: controller.socialPedagogueController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(Style.spacing.sm),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: style.colors.accent,
                            ),
                            labelText: 'Sozialpädagoge',
                            hintText:
                                'Name des Sozialpädagogen (Kann später ausgefüllt werden)',
                          ),
                        ),

                        Gap(Style.spacing.xl),

                        // Professionals Involved Field
                        Text(
                          'Beteiligte Fachkräfte',
                          style: context.typography.title,
                        ),
                        Gap(Style.spacing.md),
                        TextField(
                          controller:
                              controller.proffesionalsInvolvedController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(Style.spacing.sm),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: style.colors.accent,
                            ),
                            labelText: '(Kann später ausgefüllt werden)',
                            hintText:
                                'Liste der beteiligten Fachkräfte (Kann später ausgefüllt werden)',
                          ),
                        ),

                        Gap(Style.spacing.xl),

                        // Strengths Description Field
                        Text(
                          'Stärkenbeschreibung',
                          style: context.typography.title,
                        ),
                        Gap(Style.spacing.md),
                        TextField(
                          controller: controller.strengthsDescriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(Style.spacing.sm),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: style.colors.accent,
                            ),
                            labelText: 'Stärkenbeschreibung',
                            hintText:
                                'Beschreibung der Stärken des Schülers (Kann später ausgefüllt werden)',
                          ),
                        ),

                        Gap(Style.spacing.xl),

                        // Problems Description Field
                        Text(
                          'Problembeschreibung',
                          style: context.typography.title,
                        ),
                        Gap(Style.spacing.md),
                        TextField(
                          controller: controller.problemsDescriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(Style.spacing.sm),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: style.colors.accent,
                            ),
                            labelText: 'Problembeschreibung',
                            hintText:
                                'Beschreibung der Probleme und Herausforderungen (Kann später ausgefüllt werden)',
                          ),
                        ),
                        Gap(Style.spacing.xl),

                        // Comment Field
                        Text(
                          'Ergänzende Hinweise und Absprachen',
                          style: context.typography.title,
                        ),
                        Gap(Style.spacing.md),
                        TextField(
                          controller: controller.commentController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(Style.spacing.sm),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: style.colors.accent,
                                width: 2,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: style.colors.accent,
                            ),
                            labelText: 'Hinweise und Absprachen',
                            hintText:
                                'Zusätzliche Bemerkungen zum Förderplan (Kann später ausgefüllt werden)',
                          ),
                        ),
                        Gap(Style.spacing.xl),
                      ],
                    ),
                  ),
                ),
                // Action Buttons - Fixed at bottom
                Container(
                  padding: EdgeInsets.only(
                    left: Style.spacing.lg,
                    bottom: Style.spacing.lg,
                    right: Style.spacing.lg,
                    top: Style.spacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: style.colors.canvas,
                    boxShadow: [
                      BoxShadow(
                        color: style.colors.mutedForeground.withValues(alpha: 0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Button(
                        onPressed: isValid ? controller.savePlan : null,
                        label: controller.isEditing
                            ? 'FÖRDERPLAN SPEICHERN'
                            : 'FÖRDERPLAN ERSTELLEN',
                      ),
                      Gap(Style.spacing.md),
                      Button(
                        variant: ButtonVariant.secondary,
                        onPressed: () => Navigator.of(context).pop(),
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

class _PupilInformationCard extends StatelessWidget {
  final PupilProxy pupil;
  final String? groupTutorDisplayName;

  const _PupilInformationCard({
    required this.pupil,
    required this.groupTutorDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final schulbesuchsjahr = PupilProxyHelper.calculateSchulbesuchsjahr(pupil);
    final lernjahr = PupilProxyHelper.calculateLernjahr(pupil);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Style.spacing.lg),
      decoration: BoxDecoration(
        color: style.colors.background,
        borderRadius: BorderRadius.circular(Style.radii.medium),
        boxShadow: [
          BoxShadow(
            color: style.colors.mutedForeground.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name des Kindes', style: context.typography.bodySmall.withColor(style.colors.mutedForeground)),
          Gap(Style.spacing.sm),
          Text(
            '${pupil.firstName} ${pupil.lastName}',
            style: context.typography.title,
          ),
          Gap(Style.spacing.md),
          _PupilBasicInfoRow(pupil: pupil, schulbesuchsjahr: schulbesuchsjahr),
          Gap(Style.spacing.xs),
          _PupilInfoField(
            icon: Icons.calendar_today_outlined,
            label: 'Schulbesuchsjahr',
            value: schulbesuchsjahr.toString(),
          ),
          if (groupTutorDisplayName != null) ...[
            Gap(Style.spacing.sm),
            _PupilInfoField(
              icon: Icons.person_outline,
              label: 'Klassenlehrer*in',
              value: groupTutorDisplayName!,
            ),
          ],
          Gap(Style.spacing.sm),
          _PupilLanguageInfo(pupil: pupil, lernjahr: lernjahr),
          if (pupil.specialNeeds != null && pupil.specialNeeds!.isNotEmpty) ...[
            Gap(Style.spacing.sm),
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
    final style = Style.of(context);
    return Row(
      children: [
        Icon(icon, size: 16, color: style.colors.mutedForeground),
        Gap(Style.spacing.xs),
        Text(
          '$label: ',
          style: context.typography.body.withColor(style.colors.mutedForeground),
        ),
        Gap(Style.spacing.xs),
        Text(
          value,
          style: context.typography.body.w500,
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
          Gap(Style.spacing.xs),
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
  final List<String> specialNeeds;

  const _PupilSpecialNeedsInfo({required this.specialNeeds});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    // Special needs format: "CODE1*CODE2" (e.g., "LE*ES")

    final code1 = specialNeeds.isNotEmpty ? specialNeeds[0] : '';
    final code2 = specialNeeds.length > 1 ? specialNeeds[1] : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new, size: 16, color: style.colors.mutedForeground),
            const Gap(6),
            Text(
              'Förderschwerpunkt(e)',
              style: context.typography.body.bold.withColor(style.colors.mutedForeground),
            ),
          ],
        ),
        Gap(Style.spacing.sm),
        Row(
          children: [
            if (code1.isNotEmpty) ...[
              Text(
                code1,
                style: context.typography.subtitle.bold.withColor(style.colors.interactive),
              ),
              if (code2.isNotEmpty)
                Text(
                  code2,
                  style: context.typography.subtitle.bold.withColor(style.colors.interactive),
                ),
            ],
          ],
        ),
      ],
    );
  }
}
