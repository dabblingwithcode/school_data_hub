import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_page/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_page/widgets/end_date_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_page/widgets/name_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_page/widgets/school_semester_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_page/widgets/start_date_field.dart';
import 'package:watch_it/watch_it.dart';

// Barrel exports
export 'widgets/action_buttons.dart';
export 'widgets/end_date_field.dart';
export 'widgets/name_field.dart';
export 'widgets/school_semester_dropdown.dart';
export 'widgets/start_date_field.dart';

class NewTimetablePage extends WatchingWidget {
  final Timetable? timetable;

  const NewTimetablePage({super.key, this.timetable});

  bool get _isEditing => timetable != null;

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();
    final schoolCalendarManager = di<SchoolCalendarManager>();

    // Create form key using createOnce
    final formKey = createOnce<GlobalKey<FormState>>(
      () => GlobalKey<FormState>(),
    );

    // Create text editing controllers using createOnce
    final nameController = createOnce<TextEditingController>(() {
      final controller = TextEditingController();
      if (_isEditing && timetable != null) {
        controller.text = timetable!.name;
      }
      return controller;
    });

    // Create date controllers using createOnce
    final startDateController = createOnce<TextEditingController>(() {
      final controller = TextEditingController();
      if (_isEditing && timetable != null) {
        controller.text = _formatDate(timetable!.startsAt);
      }
      return controller;
    });

    final endDateController = createOnce<TextEditingController>(() {
      final controller = TextEditingController();
      if (_isEditing && timetable != null && timetable!.endsAt != null) {
        controller.text = _formatDate(timetable!.endsAt!);
      }
      return controller;
    });

    // Create selected semester using createOnce
    final selectedSemester = createOnce<ValueNotifier<SchoolSemester?>>(() {
      if (_isEditing && timetable != null) {
        final semester = schoolCalendarManager.schoolSemesters.value
            .firstWhereOrNull(
              (semester) => semester.id == timetable!.schoolSemesterId,
            );
        return ValueNotifier<SchoolSemester?>(semester);
      }
      return ValueNotifier<SchoolSemester?>(
        schoolCalendarManager.currentSemester.value,
      );
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.schedule, size: 25, color: Colors.white),
            const Gap(10),
            Text(
              _isEditing ? 'Stundenplan bearbeiten' : 'Neuer Stundenplan',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Name field
                  NameField(controller: nameController),
                  const Gap(20),

                  // School semester dropdown
                  SchoolSemesterDropdown(
                    selectedSemester: selectedSemester,
                    schoolSemesters:
                        schoolCalendarManager.schoolSemesters.value,
                  ),
                  const Gap(20),

                  // Start date field
                  StartDateField(controller: startDateController),
                  const Gap(20),

                  // End date field (optional)
                  EndDateField(controller: endDateController),
                  const Gap(32),

                  // Action buttons
                  ActionButtons(
                    isEditing: _isEditing,
                    onSave: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      final name = nameController.text.trim();
                      final startDateText = startDateController.text.trim();
                      final endDateText = endDateController.text.trim();

                      if (name.isEmpty ||
                          startDateText.isEmpty ||
                          selectedSemester.value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Bitte füllen Sie alle Pflichtfelder aus',
                            ),
                          ),
                        );
                        return;
                      }

                      try {
                        final startDate = _parseDate(startDateText);
                        DateTime? endDate;
                        if (endDateText.isNotEmpty) {
                          endDate = _parseDate(endDateText);
                        }

                        final newTimetable = Timetable(
                          id: _isEditing ? timetable!.id : null,
                          active: _isEditing ? timetable!.active : true,
                          startsAt: startDate,
                          endsAt: endDate,
                          name: name,
                          schoolSemesterId: selectedSemester.value!.id!,
                          createdBy:
                              _isEditing
                                  ? timetable!.createdBy
                                  : 'current_user', // TODO: Get from session
                          createdAt:
                              _isEditing
                                  ? timetable!.createdAt
                                  : DateTime.now(),
                        );

                        if (_isEditing) {
                          await timetableManager.updateTimetable(newTimetable);
                        } else {
                          await timetableManager.createTimetable(newTimetable);
                        }

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Fehler beim ${_isEditing ? 'Aktualisieren' : 'Erstellen'} des Stundenplans: $e',
                              ),
                            ),
                          );
                        }
                      }
                    },
                    onCancel: () {
                      Navigator.of(context).pop();
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

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  DateTime _parseDate(String dateText) {
    final parts = dateText.split('.');
    if (parts.length != 3) {
      throw FormatException('Invalid date format. Use DD.MM.YYYY');
    }

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }
}
