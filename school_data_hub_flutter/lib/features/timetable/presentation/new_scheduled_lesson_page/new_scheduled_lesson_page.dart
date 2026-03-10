import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/classroom_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/lesson_group_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/subject_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/teacher_selection.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';

class NewScheduledLessonPage extends WatchingWidget {
  final TimetableManager timetableManager;
  final int? preselectedSlotId;
  final int? editingLessonId;
  final Weekday? initialWeekday;
  final String? initialStartTime; // "HH:MM"
  final Classroom? initialClassroom;

  const NewScheduledLessonPage({
    super.key,
    required this.timetableManager,
    this.preselectedSlotId,
    this.editingLessonId,
    this.initialWeekday,
    this.initialStartTime,
    this.initialClassroom,
  });

  bool get _isEditing => editingLessonId != null;

  @override
  Widget build(BuildContext context) {
    // Create form key using createOnce
    final formKey = createOnce<GlobalKey<FormState>>(
      () => GlobalKey<FormState>(),
    );

    // Duration in minutes (used to compute endTime from startTime)
    final durationMinutes = createOnce<ValueNotifier<int>>(
      () => ValueNotifier<int>(45),
    );

    // Create ValueListenable for state management
    final selectedSubject = createOnce<ValueNotifier<Subject?>>(() {
      if (_isEditing) {
        final editingLesson = timetableManager.scheduledLessons.value
            .where((lesson) => lesson.id == editingLessonId)
            .firstOrNull;
        if (editingLesson != null) {
          return ValueNotifier<Subject?>(
            timetableManager.getSubjectById(editingLesson.subjectId),
          );
        }
      }
      return ValueNotifier<Subject?>(null);
    });

    final selectedClassroom = createOnce<ValueNotifier<Classroom?>>(() {
      if (_isEditing) {
        final editingLesson = timetableManager.scheduledLessons.value
            .where((lesson) => lesson.id == editingLessonId)
            .firstOrNull;
        if (editingLesson != null) {
          return ValueNotifier<Classroom?>(
            timetableManager.getClassroomById(editingLesson.roomId),
          );
        }
      } else if (initialClassroom != null) {
        return ValueNotifier<Classroom?>(initialClassroom);
      }
      return ValueNotifier<Classroom?>(null);
    });

    final selectedLessonGroup = createOnce<ValueNotifier<LessonGroup?>>(() {
      if (_isEditing) {
        final editingLesson = timetableManager.scheduledLessons.value
            .where((lesson) => lesson.id == editingLessonId)
            .firstOrNull;
        if (editingLesson != null) {
          return ValueNotifier<LessonGroup?>(
            timetableManager.getLessonGroupById(editingLesson.lessonGroupId),
          );
        }
      } else {
        return ValueNotifier<LessonGroup?>(
          timetableManager.selectedLessonGroup.value,
        );
      }
      return ValueNotifier<LessonGroup?>(null);
    });

    final selectedTeachers = createOnce<ValueNotifier<List<User>>>(() {
      if (_isEditing) {
        final editingLesson = timetableManager.scheduledLessons.value
            .where((lesson) => lesson.id == editingLessonId)
            .firstOrNull;
        if (editingLesson != null) {
          final users = di<UserManager>().users.value;
          final main = users
              .where((u) => u.id == editingLesson.mainTeacherId)
              .firstOrNull;
          final additional = <User>[];
          for (final lt
              in editingLesson.lessonTeachers ?? <ScheduledLessonTeacher>[]) {
            final u =
                users.where((user) => user.id == lt.userId).firstOrNull;
            if (u != null && u.id != main?.id) {
              additional.add(u);
            }
          }
          final initial = <User>[];
          if (main != null) {
            initial.add(main);
          }
          initial.addAll(additional);
          if (initial.isNotEmpty) {
            return ValueNotifier<List<User>>(initial);
          }
        }
      }
      return ValueNotifier<List<User>>([]);
    });
    final dropdownKey = createOnce<ValueNotifier<int>>(
      () => ValueNotifier<int>(0),
    );

    // Determine effective start time and initial duration for display
    String? effectiveStartTime = initialStartTime;
    Weekday? effectiveWeekday = initialWeekday;
    if (_isEditing || preselectedSlotId != null) {
      final editingLesson = _isEditing
          ? timetableManager.scheduledLessons.value
                .where((lesson) => lesson.id == editingLessonId)
                .firstOrNull
          : null;
      final slot = editingLesson != null
          ? timetableManager.getTimetableSlotById(editingLesson.scheduledAtId)
          : preselectedSlotId != null
          ? timetableManager.getTimetableSlotById(preselectedSlotId!)
          : null;
      if (slot != null) {
        effectiveStartTime ??= slot.startTime;
        effectiveWeekday ??= slot.day;
        // Try to infer duration from existing slot
        try {
          final startParts = slot.startTime.split(':');
          final endParts = slot.endTime.split(':');
          if (startParts.length == 2 && endParts.length == 2) {
            final startMinutes =
                int.parse(startParts[0]) * 60 + int.parse(startParts[1]);
            final endMinutes =
                int.parse(endParts[0]) * 60 + int.parse(endParts[1]);
            final diff = endMinutes - startMinutes;
            if (diff > 0) {
              durationMinutes.value = diff;
            }
          }
        } catch (_) {
          // Keep default duration on parse errors
        }
      }
    }

    // Watch the state values
    final selectedSubjectValue = watch(selectedSubject).value;
    final selectedClassroomValue = watch(selectedClassroom).value;
    final selectedLessonGroupValue = watch(selectedLessonGroup).value;
    final selectedTeachersValue = watch(selectedTeachers).value;
    final dropdownKeyValue = watch(dropdownKey).value;
    final durationMinutesValue = watch(durationMinutes).value;

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
              _isEditing ? 'Stunde bearbeiten' : 'Neue Stunde',
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Subject selection
                    SubjectDropdown(
                      selectedSubject: selectedSubjectValue,
                      onSubjectChanged: (subject) {
                        selectedSubject.value = subject;
                      },
                    ),
                    const Gap(20),

                    // Start time (read-only) and duration
                    if (effectiveStartTime != null) ...[
                      Text(
                        'Beginn: $effectiveStartTime',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Gap(8),
                    ],
                    Row(
                      children: [
                        const Text('Dauer (Minuten):'),
                        const Gap(8),
                        SizedBox(
                          width: 80,
                          child: TextFormField(
                            initialValue: durationMinutesValue.toString(),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              final parsed = int.tryParse(value);
                              if (parsed != null && parsed > 0) {
                                durationMinutes.value = parsed;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),

                    // Classroom selection
                    ClassroomDropdown(
                      selectedClassroom: selectedClassroomValue,
                      onClassroomChanged: (classroom) {
                        selectedClassroom.value = classroom;
                      },
                      hasClassroomConflict: (classroom) => false,
                    ),
                    const Gap(20),

                    // Lesson group selection
                    LessonGroupDropdown(
                      selectedLessonGroup: selectedLessonGroupValue,
                      onLessonGroupChanged: (group) {
                        selectedLessonGroup.value = group;
                      },
                      hasLessonGroupConflict: (group) => false,
                    ),
                    const Gap(20),

                    // Teacher selection
                    TeacherSelection(
                      selectedTeachers: selectedTeachersValue,
                      onTeachersChanged: (teachers) {
                        selectedTeachers.value = teachers;
                        dropdownKey.value++; // Force dropdown rebuild
                      },
                      dropdownKey: dropdownKeyValue,
                    ),
                    const Gap(20),

                    // Action buttons
                    ActionButtons(
                      isEditing: _isEditing,
                      onSave: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        if (selectedSubjectValue == null ||
                            effectiveStartTime == null ||
                            effectiveWeekday == null ||
                            selectedClassroomValue == null ||
                            selectedLessonGroupValue == null ||
                            selectedTeachersValue.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Bitte füllen Sie alle Pflichtfelder aus',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final now = DateTime.now().formatToUtcForServer();

                        // Compute or re-use timetable slot based on weekday, start time and duration.
                        final timetable = timetableManager.timetable.value;
                        if (timetable == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Kein Stundenplan ausgewählt'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final computedSlot = await _findOrCreateSlotFor(
                          effectiveWeekday,
                          effectiveStartTime,
                          durationMinutesValue,
                          timetable.id!,
                        );

                        if (_isEditing) {
                          final editingLesson = timetableManager
                              .scheduledLessons
                              .value
                              .where((lesson) => lesson.id == editingLessonId)
                              .firstOrNull;

                          if (editingLesson != null) {
                            // Update existing lesson
                            final slot = computedSlot;
                            final updatedLesson = editingLesson.copyWith(
                              subjectId: selectedSubjectValue.id!,
                              subject: selectedSubjectValue,
                              scheduledAtId: slot.id!,
                              scheduledAt: slot,
                              roomId: selectedClassroomValue.id!,
                              room: selectedClassroomValue,
                              lessonGroupId: selectedLessonGroupValue.id!,
                              lessonGroup: selectedLessonGroupValue,
                              mainTeacherId: selectedTeachersValue.first.id!,
                              modifiedBy: 'user', // TODO: Get actual user
                              modifiedAt: now,
                            );

                            timetableManager.updateScheduledLesson(
                              updatedLesson,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Stunde erfolgreich aktualisiert mit ${selectedTeachersValue.length} Lehrer(n)',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        } else {
                          // Create new lesson
                          final slot = computedSlot;
                          final nextAvailableOrder = timetableManager
                              .getNextAvailableOrderForSlot(slot.id!);

                          final generatedLessonId =
                              'L-${DateTime.now().millisecondsSinceEpoch}';

                          final newLesson = ScheduledLesson(
                            active: true,

                            subjectId: selectedSubjectValue.id!,
                            subject: selectedSubjectValue,
                            scheduledAtId: slot.id!,
                            scheduledAt: slot,
                            timetableId: timetable.id!,
                            lessonId: generatedLessonId,
                            roomId: selectedClassroomValue.id!,
                            room: selectedClassroomValue,
                            lessonGroupId: selectedLessonGroupValue.id!,
                            lessonGroup: selectedLessonGroupValue,
                            timetableSlotOrder: nextAvailableOrder,
                            mainTeacherId: selectedTeachersValue.first.id!,
                            createdBy: di<HubSessionManager>()
                                .userName!, // TODO: Get actual user
                            createdAt: now,
                          );

                          timetableManager.addScheduledLesson(newLesson);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Stunde erfolgreich erstellt mit ${selectedTeachersValue.length} Lehrer(n)',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }

                        Navigator.of(context).pop();
                      },
                      onCancel: () => Navigator.of(context).pop(),
                      onDelete: _isEditing
                          ? () {
                              final editingLesson = timetableManager
                                  .scheduledLessons
                                  .value
                                  .where(
                                    (lesson) => lesson.id == editingLessonId,
                                  )
                                  .firstOrNull;

                              if (editingLesson?.id == null) return;

                              showDialog<void>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Stunde löschen'),
                                  content: const Text(
                                    'Sind Sie sicher, dass Sie diese Stunde löschen möchten?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Abbrechen'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        timetableManager.removeScheduledLesson(
                                          editingLesson!.id!,
                                        );
                                        Navigator.of(
                                          context,
                                        ).pop(); // Close dialog
                                        Navigator.of(
                                          context,
                                        ).pop(); // Close page

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Stunde erfolgreich gelöscht',
                                            ),
                                            backgroundColor: Colors.orange,
                                          ),
                                        );
                                      },
                                      child: const Text('Löschen'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<TimetableSlot> _findOrCreateSlotFor(
  Weekday day,
  String startTime,
  int durationMinutes,
  int timetableId,
) async {
  final manager = di<TimetableManager>();
  // Compute endTime from startTime + duration
  final parts = startTime.split(':');
  final startHour = int.parse(parts[0]);
  final startMinute = int.parse(parts[1]);
  final startTotal = startHour * 60 + startMinute;
  final endTotal = startTotal + durationMinutes;
  final endHour = endTotal ~/ 60;
  final endMinute = endTotal % 60;
  final endTime =
      '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';

  final existing = manager.timetableSlots.value.where(
    (s) =>
        s.day == day &&
        s.startTime == startTime &&
        s.endTime == endTime &&
        s.timetableId == timetableId,
  );
  if (existing.isNotEmpty) {
    return existing.first;
  }

  final slot = TimetableSlot(
    day: day,
    startTime: startTime,
    endTime: endTime,
    timetableId: timetableId,
  );
  await manager.addTimetableSlot(slot);
  // Best effort: try to find it again after add; fall back to local slot.
  final refreshed = manager.timetableSlots.value.where(
    (s) =>
        s.day == day &&
        s.startTime == startTime &&
        s.endTime == endTime &&
        s.timetableId == timetableId,
  );
  return refreshed.isNotEmpty ? refreshed.first : slot;
}
