import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_overlap_helper.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_utils.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/scheduled_lesson/new_scheduled_lesson_page/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/scheduled_lesson/new_scheduled_lesson_page/widgets/classroom_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/scheduled_lesson/new_scheduled_lesson_page/widgets/lesson_group_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/scheduled_lesson/new_scheduled_lesson_page/widgets/subject_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/scheduled_lesson/new_scheduled_lesson_page/widgets/teacher_selection.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';

class NewScheduledLessonScreen extends WatchingWidget {
  final TimetableManager timetableManager;
  final int? preselectedSlotId;
  final int? editingLessonId;
  final Weekday? initialWeekday;
  final String? initialStartTime; // "HH:MM"
  final Classroom? initialClassroom;

  const NewScheduledLessonScreen({
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
    final style = Style.of(context);
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
        final editingLesson = timetableManager.data.scheduledLessons.value
            .where((lesson) => lesson.id == editingLessonId)
            .firstOrNull;
        if (editingLesson != null) {
          return ValueNotifier<Subject?>(
            timetableManager.data.subjectIdMap[editingLesson.subjectId],
          );
        }
      }
      return ValueNotifier<Subject?>(null);
    });

    final selectedClassroom = createOnce<ValueNotifier<Classroom?>>(() {
      if (_isEditing) {
        final editingLesson = timetableManager.data.scheduledLessons.value
            .where((lesson) => lesson.id == editingLessonId)
            .firstOrNull;
        if (editingLesson != null) {
          return ValueNotifier<Classroom?>(
            timetableManager.data.classroomIdMap[editingLesson.roomId],
          );
        }
      } else if (initialClassroom != null) {
        return ValueNotifier<Classroom?>(initialClassroom);
      }
      return ValueNotifier<Classroom?>(null);
    });

    final selectedLessonGroup = createOnce<ValueNotifier<LessonGroup?>>(() {
      if (_isEditing) {
        final editingLesson = timetableManager.data.scheduledLessons.value
            .where((lesson) => lesson.id == editingLessonId)
            .firstOrNull;
        if (editingLesson != null) {
          return ValueNotifier<LessonGroup?>(
            timetableManager.data.lessonGroupIdMap[editingLesson.lessonGroupId],
          );
        }
      } else {
        return ValueNotifier<LessonGroup?>(
          timetableManager.ui.selectedLessonGroup.value,
        );
      }
      return ValueNotifier<LessonGroup?>(null);
    });

    final selectedTeachers = createOnce<ValueNotifier<List<User>>>(() {
      if (_isEditing) {
        final editingLesson = timetableManager.data.scheduledLessons.value
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
            final u = users.where((user) => user.id == lt.userId).firstOrNull;
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
    // Determine effective start time and initial duration for display
    String? effectiveStartTime = initialStartTime;
    Weekday? effectiveWeekday = initialWeekday;
    if (_isEditing || preselectedSlotId != null) {
      final editingLesson = _isEditing
          ? timetableManager.data.scheduledLessons.value
                .where((lesson) => lesson.id == editingLessonId)
                .firstOrNull
          : null;
      final slot = editingLesson != null
          ? timetableManager.data.slotIdMap[editingLesson.scheduledAtId]
          : preselectedSlotId != null
          ? timetableManager.data.slotIdMap[preselectedSlotId!]
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

    // Controller for duration so we read the actual field value at save time
    final durationController = createOnce<TextEditingController>(
      () => TextEditingController(text: durationMinutes.value.toString()),
    );

    // Watch the state values
    final selectedSubjectValue = watch(selectedSubject).value;
    final selectedClassroomValue = watch(selectedClassroom).value;
    final selectedLessonGroupValue = watch(selectedLessonGroup).value;
    watch(durationMinutes);

    // Target slot for overlap checks (used by classroom, group, teacher dropdowns)
    final targetWeekday = effectiveWeekday;
    final targetStartTime = effectiveStartTime;
    final targetEndTime = targetStartTime != null
        ? TimetableOverlapHelper.addMinutesToTime(
            targetStartTime,
            durationMinutes.value,
          )
        : null;

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: style.colors.accent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, size: 25, color: style.colors.background),
            Gap(Style.spacing.md),
            Text(
              _isEditing ? 'Stunde bearbeiten' : 'Neue Stunde',
              style: context.typography.title.withColor(style.colors.background),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Style.spacing.md, left: Style.spacing.md, right: Style.spacing.md),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Time info row: start — end — duration
                        if (effectiveStartTime != null) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                TimetableUtils.getWeekdayName(
                                  di<TimetableManager>().ui.selectedWeekday.value,
                                ),
                                style: context.typography.display.withColor(style.colors.foreground),
                              ),
                              Gap(Style.spacing.md),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'von: $effectiveStartTime',
                                    style: context.typography.body.bold,
                                  ),
                                  Gap(Style.spacing.md),
                                  if (targetEndTime != null) ...[
                                    Text(
                                      'bis: $targetEndTime',
                                      style: context.typography.body.bold,
                                    ),
                                  ],
                                ],
                              ),

                              Gap(Style.spacing.md),

                              const Text('Dauer (Min.):'),
                              Gap(Style.spacing.sm),
                              SizedBox(
                                width: 50,
                                child: TextFormField(
                                  controller: durationController,
                                  key: const ValueKey('duration_minutes'),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(Style.radii.small),
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: Style.spacing.sm,
                                      vertical: Style.spacing.sm,
                                    ),
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
                          Gap(Style.spacing.xl),
                        ],
                        // Subject selection
                        SubjectDropdown(
                          selectedSubject: selectedSubjectValue,
                          onSubjectChanged: (subject) {
                            selectedSubject.value = subject;
                          },
                        ),
                        Gap(Style.spacing.xl),

                        // Classroom selection (overlap-based availability when slot is known)
                        ClassroomDropdown(
                          selectedClassroom: selectedClassroomValue,
                          onClassroomChanged: (classroom) {
                            selectedClassroom.value = classroom;
                          },
                          targetWeekday: targetWeekday,
                          targetStartTime: targetStartTime,
                          targetEndTime: targetEndTime,
                          excludeLessonId: editingLessonId,
                        ),
                        Gap(Style.spacing.xl),

                        // Lesson group selection (overlap-based availability when slot is known)
                        LessonGroupDropdown(
                          selectedLessonGroup: selectedLessonGroupValue,
                          onLessonGroupChanged: (group) {
                            selectedLessonGroup.value = group;
                          },
                          targetWeekday: targetWeekday,
                          targetStartTime: targetStartTime,
                          targetEndTime: targetEndTime,
                          excludeLessonId: editingLessonId,
                        ),
                        Gap(Style.spacing.xl),

                        // Teacher selection (overlap-based filtering)
                        TeacherSelection(
                          selectedTeachersNotifier: selectedTeachers,
                          targetWeekday: targetWeekday,
                          targetStartTime: targetStartTime,
                          targetEndTime: targetEndTime,
                          scheduledLessons:
                              timetableManager.data.scheduledLessons.value,
                          excludeLessonId: editingLessonId,
                        ),
                        Gap(Style.spacing.xl),
                      ],
                    ),
                  ),
                ),
                // Action buttons — always visible at the bottom
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
                        selectedTeachers.value.isEmpty) {
                      di<NotificationManager>().showSnackBar(
                        NotificationType.error,
                        'Bitte füllen Sie alle Pflichtfelder aus',
                      );
                      return;
                    }

                    final now = DateTime.now().formatToUtcForServer();

                    // Compute or re-use timetable slot based on weekday, start time and duration.
                    final timetable = timetableManager.data.timetable.value;
                    if (timetable == null) {
                      di<NotificationManager>().showSnackBar(
                        NotificationType.error,
                        'Kein Stundenplan ausgewählt',
                      );
                      return;
                    }

                    // Read duration from the field at save time so the slot always reflects what the user entered
                    final durationText = durationController.text.trim();
                    final currentDurationMinutes = int.tryParse(durationText);
                    if (currentDurationMinutes == null ||
                        currentDurationMinutes <= 0) {
                      di<NotificationManager>().showSnackBar(
                        NotificationType.error,
                        'Bitte geben Sie eine gültige Dauer (Minuten) ein.',
                      );
                      return;
                    }
                    final computedSlot = await timetableManager
                        .findOrCreateSlotFor(
                          effectiveWeekday,
                          effectiveStartTime,
                          currentDurationMinutes,
                        );

                    if (_isEditing) {
                      final editingLesson = timetableManager
                          .data
                          .scheduledLessons
                          .value
                          .where((lesson) => lesson.id == editingLessonId)
                          .firstOrNull;

                      if (editingLesson != null) {
                        // Update existing lesson
                        final slot = computedSlot;
                        final teachers = selectedTeachers.value;
                        final updatedLesson = editingLesson.copyWith(
                          subjectId: selectedSubjectValue.id!,
                          subject: selectedSubjectValue,
                          scheduledAtId: slot.id!,
                          scheduledAt: slot,
                          roomId: selectedClassroomValue.id!,
                          room: selectedClassroomValue,
                          lessonGroupId: selectedLessonGroupValue.id!,
                          lessonGroup: selectedLessonGroupValue,
                          mainTeacherId: teachers.first.id!,
                          lessonTeachers: teachers
                              .map(
                                (t) => ScheduledLessonTeacher(
                                  userId: t.id!,
                                  scheduledLessonId: editingLesson.id!,
                                ),
                              )
                              .toList(),
                          modifiedBy: di<HubSessionManager>().userName!,
                          modifiedAt: now,
                        );

                        await timetableManager.updateScheduledLesson(
                          updatedLesson,
                        );

                        if (context.mounted) {
                          di<NotificationManager>().showSnackBar(
                            NotificationType.success,
                            'Stunde erfolgreich aktualisiert mit ${selectedTeachers.value.length} Lehrer(n)',
                          );

                          Navigator.of(context).pop();
                        }
                      }
                    } else {
                      // Create new lesson
                      final slot = computedSlot;
                      final nextAvailableOrder = timetableManager
                          .getNextAvailableOrderForSlot(slot.id!);

                      final generatedLessonId =
                          'L-${DateTime.now().millisecondsSinceEpoch}';

                      final teachers = selectedTeachers.value;
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
                        mainTeacherId: teachers.first.id!,
                        lessonTeachers: teachers
                            .map(
                              (t) => ScheduledLessonTeacher(
                                userId: t.id!,
                                scheduledLessonId:
                                    0, // set by server after insert
                              ),
                            )
                            .toList(),
                        createdBy: di<HubSessionManager>().userName!,
                        createdAt: now,
                      );

                      await timetableManager.addScheduledLesson(newLesson);

                      if (context.mounted) {
                        di<NotificationManager>().showSnackBar(
                          NotificationType.success,
                          'Stunde erfolgreich erstellt mit ${selectedTeachers.value.length} Lehrer(n)',
                        );
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  onCancel: () => Navigator.of(context).pop(),
                  onDelete: _isEditing
                      ? () {
                          final editingLesson = timetableManager
                              .data
                              .scheduledLessons
                              .value
                              .where((lesson) => lesson.id == editingLessonId)
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
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Abbrechen'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    timetableManager.removeScheduledLesson(
                                      editingLesson!.id!,
                                    );
                                    Navigator.of(context).pop(); // Close dialog
                                    Navigator.of(context).pop(); // Close page

                                    di<NotificationManager>().showSnackBar(
                                      NotificationType.success,
                                      'Stunde erfolgreich gelöscht',
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
    );
  }
}
