import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class NewCompetenceReportPage extends WatchingWidget {
  final PupilProxy pupil;

  const NewCompetenceReportPage({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
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
      appBar: GenericAppBar(
        iconData: Icons.assignment_add,
        title: 'Neues Zeugnis - ${pupil.firstName} ${pupil.lastName}',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Schulhalbjahr',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                InputDecorator(
                  decoration: AppStyles.textFieldDecoration(
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
                const Gap(20),
                const Text(
                  'Bezeichnung',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  controller: achievementController,
                  decoration: AppStyles.textFieldDecoration(
                    labelText: 'Bezeichnung des Zeugnisses',
                  ),
                ),
                const Gap(20),
                const Text(
                  'Datum',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                InkWell(
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
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Datum',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd.MM.yyyy').format(dateValue),
                          style: const TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: AppColors.backgroundColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: AppStyles.actionButtonStyle,
                  onPressed: submit,
                  child:
                      const Text('ERSTELLEN', style: AppStyles.buttonTextStyle),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'ABBRECHEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
