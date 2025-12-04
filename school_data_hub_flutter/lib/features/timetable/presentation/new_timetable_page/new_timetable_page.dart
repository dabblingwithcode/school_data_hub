import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
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

final _log = Logger('NewTimetablePage');

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
        controller.text = timetable!.startsAt.formatDateForUser();
      }
      return controller;
    });

    final endDateController = createOnce<TextEditingController>(() {
      final controller = TextEditingController();
      if (_isEditing && timetable != null && timetable!.endsAt != null) {
        controller.text = timetable!.endsAt!.formatDateForUser();
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

      // For new timetables, try to get current semester, fallback to first available
      final currentSemester = schoolCalendarManager.currentSemester.value;
      final availableSemesters = schoolCalendarManager.schoolSemesters.value;

      if (currentSemester != null) {
        return ValueNotifier<SchoolSemester?>(currentSemester);
      } else if (availableSemesters.isNotEmpty) {
        // Fallback to the first available semester
        return ValueNotifier<SchoolSemester?>(availableSemesters.first);
      } else {
        // No semesters available
        return ValueNotifier<SchoolSemester?>(null);
      }
    });

    // Create selected dates using createOnce
    final selectedStartDate = createOnce<ValueNotifier<DateTime?>>(() {
      if (_isEditing && timetable != null) {
        return ValueNotifier<DateTime?>(timetable!.startsAt);
      }
      return ValueNotifier<DateTime?>(null);
    });

    final selectedEndDate = createOnce<ValueNotifier<DateTime?>>(() {
      if (_isEditing && timetable != null && timetable!.endsAt != null) {
        return ValueNotifier<DateTime?>(timetable!.endsAt);
      }
      return ValueNotifier<DateTime?>(null);
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
                  StartDateField(
                    controller: startDateController,
                    selectedDate: selectedStartDate,
                  ),
                  const Gap(20),

                  // End date field (optional)
                  EndDateField(
                    controller: endDateController,
                    selectedDate: selectedEndDate,
                  ),
                  const Gap(32),

                  // Action buttons
                  ActionButtons(
                    isEditing: _isEditing,
                    onSave: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      final name = nameController.text.trim();

                      if (name.isEmpty || selectedSemester.value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              selectedSemester.value == null
                                  ? 'Bitte wählen Sie ein gültiges Schulsemester aus. Falls keine Semester verfügbar sind, erstellen Sie zuerst ein Schulhalbjahr.'
                                  : 'Bitte füllen Sie alle Pflichtfelder aus',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      try {
                        final startDate = selectedStartDate.value;
                        final endDate = selectedEndDate.value;

                        if (startDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Bitte wählen Sie ein Startdatum aus',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final sessionManager = di<HubSessionManager>();
                        final userName =
                            sessionManager.userName ?? 'unknown_user';

                        _log.info('Creating timetable with:');
                        _log.info('- Name: $name');
                        _log.info('- Start Date: $startDate');
                        _log.info('- End Date: $endDate');
                        _log.info(
                          '- School Semester ID: ${selectedSemester.value!.id}',
                        );
                        _log.info('- Created By: $userName');
                        _log.info(
                          '- Is Signed In: ${sessionManager.isSignedIn}',
                        );

                        final newTimetable = Timetable(
                          id: _isEditing ? timetable!.id : null,
                          active: _isEditing ? timetable!.active : true,
                          startsAt: startDate.formatToUtcForServer(),
                          endsAt: endDate?.formatToUtcForServer(),
                          name: name,
                          schoolSemesterId: selectedSemester.value!.id!,
                          createdBy: _isEditing
                              ? timetable!.createdBy
                              : userName,
                          createdAt: _isEditing
                              ? timetable!.createdAt
                              : DateTime.now().formatToUtcForServer(),
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
}
