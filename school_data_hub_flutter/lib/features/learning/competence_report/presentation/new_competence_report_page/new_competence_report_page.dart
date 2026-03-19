import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class NewCompetenceReportScreen extends WatchingWidget {
  final PupilProxy pupil;

  const NewCompetenceReportScreen({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final semesters = watchValue(
      (SchoolCalendarManager m) => m.schoolSemesters,
    );

    final sortedSemesters = List<SchoolSemester>.from(semesters)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    final selectedSemester = createOnce(
      () => ValueNotifier<SchoolSemester?>(null),
    );
    final selectedDate = createOnce(
      () => ValueNotifier<DateTime>(DateTime.now()),
    );
    final achievementController = createOnce(
      () => TextEditingController(),
    );

    final semesterValue = watch(selectedSemester).value;
    final dateValue = watch(selectedDate).value;

    void submit() async {
      if (semesterValue == null) {
        informationDialog(
          context,
          'Halbjahr auswählen',
          'Bitte ein Schulhalbjahr auswählen!',
        );
        return;
      }
      if (achievementController.text.trim().isEmpty) {
        informationDialog(
          context,
          'Bezeichnung eingeben',
          'Bitte eine Bezeichnung eingeben!',
        );
        return;
      }
      Navigator.pop(context);
      await di<CompetenceReportManager>().postReport(
        pupilId: pupil.pupilId,
        schoolSemesterId: semesterValue.id!,
        achievement: achievementController.text.trim(),
        achievedAt: dateValue,
      );
    }

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppHeader(
        iconData: Icons.assignment_add,
        title: 'Neues Zeugnis - ${pupil.firstName} ${pupil.lastName}',
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Schulhalbjahr',
                  style: context.typography.title,
                ),
                Gap(Style.spacing.md),
                InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    labelText: 'Schulhalbjahr',
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<SchoolSemester>(
                      value: semesterValue,
                      isExpanded: true,
                      isDense: true,
                      hint: const Text('Halbjahr auswählen'),
                      items: sortedSemesters.map((semester) {
                        final label =
                            '${semester.schoolYear} ${semester.isFirst ? "1. Halbjahr" : "2. Halbjahr"}';
                        return DropdownMenuItem<SchoolSemester>(
                          value: semester,
                          child: Text(label),
                        );
                      }).toList(),
                      onChanged: (value) => selectedSemester.value = value,
                    ),
                  ),
                ),
                Gap(Style.spacing.xl),
                Text(
                  'Bezeichnung',
                  style: context.typography.title,
                ),
                Gap(Style.spacing.md),
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  controller: achievementController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    labelText: 'Bezeichnung des Zeugnisses',
                  ),
                ),
                Gap(Style.spacing.xl),
                Text(
                  'Datum',
                  style: context.typography.title,
                ),
                Gap(Style.spacing.md),
                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: dateValue,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) {
                      selectedDate.value = picked;
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Style.radii.small),
                      ),
                      labelText: 'Datum',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd.MM.yyyy').format(dateValue),
                          style: context.typography.subtitle,
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: style.colors.accent,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Button(
                  label: 'ERSTELLEN',
                  onPressed: submit,
                ),
                Gap(Style.spacing.lg),
                Button(
                  label: 'ABBRECHEN',
                  variant: ButtonVariant.secondary,
                  onPressed: () => Navigator.pop(context),
                ),
                Gap(Style.spacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
