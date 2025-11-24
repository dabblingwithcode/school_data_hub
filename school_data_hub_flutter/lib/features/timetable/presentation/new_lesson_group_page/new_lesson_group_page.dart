import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/widgets/color_picker_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/widgets/name_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/widgets/pupil_management_section.dart';
import 'package:watch_it/watch_it.dart';

// Barrel exports
export 'widgets/action_buttons.dart';
export 'widgets/color_picker_field.dart';
export 'widgets/name_field.dart';
export 'widgets/pupil_management_section.dart';

class NewLessonGroupPage extends WatchingWidget {
  final LessonGroup? lessonGroup;

  const NewLessonGroupPage({super.key, this.lessonGroup});

  bool get _isEditing => lessonGroup != null;

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();

    // Create form key using createOnce
    final formKey = createOnce<GlobalKey<FormState>>(
      () => GlobalKey<FormState>(),
    );

    // Create text editing controller using createOnce
    final nameController = createOnce<TextEditingController>(() {
      final controller = TextEditingController();
      if (_isEditing && lessonGroup != null) {
        controller.text = lessonGroup!.name;
      }
      return controller;
    });

    // Create color picker state using createOnce
    final selectedColor = createOnce<ValueNotifier<String>>(() {
      final notifier = ValueNotifier<String>('#2196F3');
      if (_isEditing && lessonGroup != null) {
        notifier.value = lessonGroup!.color ?? '#2196F3';
      }
      return notifier;
    });

    // Create pupil IDs state using createOnce
    final selectedPupilIds = createOnce<ValueNotifier<List<int>>>(() {
      final notifier = ValueNotifier<List<int>>([]);
      if (_isEditing && lessonGroup?.id != null) {
        notifier.value = timetableManager.getPupilIdsForLessonGroup(
          lessonGroup!.id!,
        );
      }
      return notifier;
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.group, size: 25, color: Colors.white),
            const Gap(10),
            Text(
              _isEditing ? 'Lerngruppe bearbeiten' : 'Neue Lerngruppe',
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
                    // Name field
                    NameField(controller: nameController),
                    const Gap(20),

                    // Color picker field
                    ValueListenableBuilder<String>(
                      valueListenable: selectedColor,
                      builder: (context, color, child) {
                        return ColorPickerField(
                          selectedColor: color,
                          onColorChanged: (newColor) {
                            selectedColor.value = newColor;
                          },
                        );
                      },
                    ),
                    const Gap(20),

                    // Pupil Management Section
                    ValueListenableBuilder<List<int>>(
                      valueListenable: selectedPupilIds,
                      builder: (context, pupilIds, child) {
                        return PupilManagementSection(
                          timetableManager: timetableManager,
                          lessonGroupId: lessonGroup?.id,
                          selectedPupilIds: pupilIds,
                          onPupilIdsChanged: (newPupilIds) {
                            selectedPupilIds.value = newPupilIds;
                          },
                        );
                      },
                    ),
                    const Gap(32),

                    // Action buttons
                    ActionButtons(
                      isEditing: _isEditing,
                      onSave: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        final name = nameController.text.trim();
                        final color = selectedColor.value;

                        if (name.isEmpty) {
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

                        final currentTimetable =
                            timetableManager.timetable.value;
                        if (currentTimetable?.id == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Fehler: Kein Stundenplan ausgewählt',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final now = DateTime.now().formatToUtcForServer();
                        final lessonGroupData = LessonGroup(
                          id: lessonGroup?.id,
                          publicId:
                              lessonGroup?.publicId ??
                              'GROUP_${now.millisecondsSinceEpoch}',
                          name: name,
                          color: color,
                          timetableId: currentTimetable!.id!,
                          createdBy: lessonGroup?.createdBy ?? 'user',
                          createdAt: lessonGroup?.createdAt ?? now,
                          modifiedBy: 'user',
                          modifiedAt: now,
                        );

                        if (_isEditing) {
                          // Update existing lesson group
                          timetableManager.updateLessonGroup(lessonGroupData);

                          // Update pupil memberships for existing lesson group
                          if (lessonGroup?.id != null) {
                            timetableManager
                                .updatePupilMembershipsForLessonGroup(
                                  lessonGroup!.id!,
                                  selectedPupilIds.value,
                                );
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Klasse erfolgreich aktualisiert'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          Navigator.of(context).pop();
                        } else {
                          // Create new lesson group
                          timetableManager.addLessonGroup(lessonGroupData);

                          // Add pupil memberships for new lesson group
                          if (lessonGroupData.id != null &&
                              selectedPupilIds.value.isNotEmpty) {
                            timetableManager
                                .updatePupilMembershipsForLessonGroup(
                                  lessonGroupData.id!,
                                  selectedPupilIds.value,
                                );
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Klasse erfolgreich erstellt'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          Navigator.of(context).pop(lessonGroupData);
                        }
                      },
                      onCancel: () => Navigator.of(context).pop(),
                      onDelete: _isEditing
                          ? () {
                              if (lessonGroup?.id == null) return;

                              // Check if the lesson group is used in any scheduled lessons
                              final scheduledLessons = timetableManager
                                  .scheduledLessons
                                  .value
                                  .where(
                                    (lesson) =>
                                        lesson.lessonGroupId == lessonGroup!.id,
                                  )
                                  .toList();

                              if (scheduledLessons.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Klasse kann nicht gelöscht werden',
                                    ),
                                    content: Text(
                                      'Diese Klasse wird in ${scheduledLessons.length} geplanten Stunden verwendet und kann nicht gelöscht werden.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Klasse löschen'),
                                  content: Text(
                                    'Sind Sie sicher, dass Sie die Klasse "${lessonGroup!.name}" löschen möchten?\n\n'
                                    'Diese Aktion kann nicht rückgängig gemacht werden.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Abbrechen'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        timetableManager.removeLessonGroup(
                                          lessonGroup!.id!,
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
                                          SnackBar(
                                            content: Text(
                                              'Klasse "${lessonGroup!.name}" wurde gelöscht',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                      ),
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
