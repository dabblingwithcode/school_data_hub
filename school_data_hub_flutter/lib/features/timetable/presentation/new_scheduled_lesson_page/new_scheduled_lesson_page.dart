import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/classroom_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/lesson_group_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/lesson_id_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/subject_dropdown.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/teacher_selection.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/widgets/time_slot_dropdown.dart';
import 'package:watch_it/watch_it.dart';

class NewScheduledLessonPage extends WatchingWidget {
  final TimetableManager timetableManager;
  final int? preselectedSlotId;
  final int? editingLessonId;

  const NewScheduledLessonPage({
    super.key,
    required this.timetableManager,
    this.preselectedSlotId,
    this.editingLessonId,
  });

  bool get _isEditing => editingLessonId != null;

  @override
  Widget build(BuildContext context) {
    // Create form key using createOnce
    final formKey = createOnce<GlobalKey<FormState>>(
      () => GlobalKey<FormState>(),
    );

    // Create text editing controller using createOnce
    final lessonIdController = createOnce<TextEditingController>(
      () => TextEditingController(),
    );

    // Create ValueListenable for state management
    final selectedSubject = createOnce<ValueNotifier<Subject?>>(() {
      if (_isEditing) {
        final editingLesson =
            timetableManager.scheduledLessons.value
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

    final selectedSlot = createOnce<ValueNotifier<TimetableSlot?>>(() {
      if (_isEditing) {
        final editingLesson =
            timetableManager.scheduledLessons.value
                .where((lesson) => lesson.id == editingLessonId)
                .firstOrNull;
        if (editingLesson != null) {
          return ValueNotifier<TimetableSlot?>(
            timetableManager.getTimetableSlotById(editingLesson.scheduledAtId),
          );
        }
      } else if (preselectedSlotId != null) {
        return ValueNotifier<TimetableSlot?>(
          timetableManager.getTimetableSlotById(preselectedSlotId!),
        );
      }
      return ValueNotifier<TimetableSlot?>(null);
    });

    final selectedClassroom = createOnce<ValueNotifier<Classroom?>>(() {
      if (_isEditing) {
        final editingLesson =
            timetableManager.scheduledLessons.value
                .where((lesson) => lesson.id == editingLessonId)
                .firstOrNull;
        if (editingLesson != null) {
          return ValueNotifier<Classroom?>(
            timetableManager.getClassroomById(editingLesson.roomId),
          );
        }
      }
      return ValueNotifier<Classroom?>(null);
    });

    final selectedLessonGroup = createOnce<ValueNotifier<LessonGroup?>>(() {
      if (_isEditing) {
        final editingLesson =
            timetableManager.scheduledLessons.value
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

    final selectedTeachers = createOnce<ValueNotifier<List<User>>>(
      () => ValueNotifier<List<User>>([]),
    );
    final dropdownKey = createOnce<ValueNotifier<int>>(
      () => ValueNotifier<int>(0),
    );

    // Initialize lesson ID controller if editing
    if (_isEditing) {
      final editingLesson =
          timetableManager.scheduledLessons.value
              .where((lesson) => lesson.id == editingLessonId)
              .firstOrNull;
      if (editingLesson != null) {
        lessonIdController.text = editingLesson.lessonId;
      }
    }

    // Watch the state values
    final selectedSubjectValue = watch(selectedSubject).value;
    final selectedSlotValue = watch(selectedSlot).value;
    final selectedClassroomValue = watch(selectedClassroom).value;
    final selectedLessonGroupValue = watch(selectedLessonGroup).value;
    final selectedTeachersValue = watch(selectedTeachers).value;
    final dropdownKeyValue = watch(dropdownKey).value;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, size: 25, color: Colors.white),
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

                    // Time slot selection
                    TimeSlotDropdown(
                      selectedSlot: selectedSlotValue,
                      onSlotChanged: (slot) {
                        selectedSlot.value = slot;

                        // Reset lesson group if it conflicts with the new time slot
                        if (selectedLessonGroupValue != null &&
                            _hasLessonGroupConflict(
                              selectedLessonGroupValue,
                              selectedSlotValue,
                            )) {
                          selectedLessonGroup.value = null;
                        }

                        // Reset classroom if it conflicts with the new time slot
                        if (selectedClassroomValue != null &&
                            _hasClassroomConflict(
                              selectedClassroomValue,
                              selectedSlotValue,
                            )) {
                          selectedClassroom.value = null;
                        }
                      },
                      hasLessonGroupConflict:
                          (group) =>
                              _hasLessonGroupConflict(group, selectedSlotValue),
                      hasClassroomConflict:
                          (classroom) => _hasClassroomConflict(
                            classroom,
                            selectedSlotValue,
                          ),
                    ),
                    const Gap(20),

                    // Classroom selection
                    ClassroomDropdown(
                      selectedClassroom: selectedClassroomValue,
                      onClassroomChanged: (classroom) {
                        selectedClassroom.value = classroom;
                      },
                      hasClassroomConflict:
                          (classroom) => _hasClassroomConflict(
                            classroom,
                            selectedSlotValue,
                          ),
                    ),
                    const Gap(20),

                    // Lesson group selection
                    LessonGroupDropdown(
                      selectedLessonGroup: selectedLessonGroupValue,
                      onLessonGroupChanged: (group) {
                        selectedLessonGroup.value = group;
                      },
                      hasLessonGroupConflict:
                          (group) =>
                              _hasLessonGroupConflict(group, selectedSlotValue),
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

                    // Lesson ID field
                    LessonIdField(controller: lessonIdController),
                    const Gap(32),

                    // Action buttons
                    ActionButtons(
                      isEditing: _isEditing,
                      onSave: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        if (selectedSubjectValue == null ||
                            selectedSlotValue == null ||
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

                        final now = DateTime.now().toUtcForServer();

                        if (_isEditing) {
                          final editingLesson =
                              timetableManager.scheduledLessons.value
                                  .where(
                                    (lesson) => lesson.id == editingLessonId,
                                  )
                                  .firstOrNull;

                          if (editingLesson != null) {
                            // Update existing lesson
                            final updatedLesson = editingLesson.copyWith(
                              subjectId: selectedSubjectValue.id!,
                              subject: selectedSubjectValue,
                              scheduledAtId: selectedSlotValue.id!,
                              scheduledAt: selectedSlotValue,
                              lessonId: lessonIdController.text.trim(),
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
                          final nextAvailableOrder = timetableManager
                              .getNextAvailableOrderForSlot(
                                selectedSlotValue.id!,
                              );

                          final newLesson = ScheduledLesson(
                            active: true,

                            subjectId: selectedSubjectValue.id!,
                            subject: selectedSubjectValue,
                            scheduledAtId: selectedSlotValue.id!,
                            scheduledAt: selectedSlotValue,
                            timetableId:
                                timetableManager.timetable.value?.id ??
                                1, // Get from current timetable
                            lessonId: lessonIdController.text.trim(),
                            roomId: selectedClassroomValue.id!,
                            room: selectedClassroomValue,
                            lessonGroupId: selectedLessonGroupValue.id!,
                            lessonGroup: selectedLessonGroupValue,
                            timetableSlotOrder: nextAvailableOrder,
                            mainTeacherId: selectedTeachersValue.first.id!,
                            createdBy:
                                di<HubSessionManager>()
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
                      onDelete:
                          _isEditing
                              ? () {
                                final editingLesson =
                                    timetableManager.scheduledLessons.value
                                        .where(
                                          (lesson) =>
                                              lesson.id == editingLessonId,
                                        )
                                        .firstOrNull;

                                if (editingLesson?.id == null) return;

                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: const Text('Stunde löschen'),
                                        content: const Text(
                                          'Sind Sie sicher, dass Sie diese Stunde löschen möchten?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () =>
                                                    Navigator.of(context).pop(),
                                            child: const Text('Abbrechen'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              timetableManager
                                                  .removeScheduledLesson(
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
                                                  backgroundColor:
                                                      Colors.orange,
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

  bool _hasClassroomConflict(Classroom classroom, TimetableSlot? selectedSlot) {
    if (selectedSlot == null || classroom.id == null) return false;

    final currentLessonId = _isEditing ? editingLessonId : null;

    final lessonsInSlot = timetableManager.getAllLessonsForSlot(
      selectedSlot.id!,
    );

    return lessonsInSlot.any(
      (lesson) => lesson.roomId == classroom.id && lesson.id != currentLessonId,
    );
  }

  bool _hasLessonGroupConflict(
    LessonGroup lessonGroup,
    TimetableSlot? selectedSlot,
  ) {
    if (selectedSlot == null || lessonGroup.id == null) return false;

    final currentLessonId = _isEditing ? editingLessonId : null;

    final lessonsInSlot = timetableManager.getAllLessonsForSlot(
      selectedSlot.id!,
    );

    return lessonsInSlot.any(
      (lesson) =>
          lesson.lessonGroupId == lessonGroup.id &&
          lesson.id != currentLessonId,
    );
  }
}
