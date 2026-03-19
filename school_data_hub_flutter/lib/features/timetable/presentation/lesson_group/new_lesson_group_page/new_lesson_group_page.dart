import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/lesson_group/new_lesson_group_page/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/lesson_group/new_lesson_group_page/widgets/color_picker_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/lesson_group/new_lesson_group_page/widgets/name_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/lesson_group/new_lesson_group_page/widgets/pupil_management_section.dart';
import 'package:flutter_it/flutter_it.dart';

// Barrel exports
export 'widgets/action_buttons.dart';
export 'widgets/color_picker_field.dart';
export 'widgets/name_field.dart';
export 'widgets/pupil_management_section.dart';

class NewLessonGroupScreen extends WatchingWidget {
  final LessonGroup? lessonGroup;

  const NewLessonGroupScreen({super.key, this.lessonGroup});

  bool get _isEditing => lessonGroup != null;

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();
    final style = Style.of(context);

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
      backgroundColor: style.colors.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: style.colors.accent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.group, size: 25, color: style.colors.background),
            Gap(Style.spacing.md),
            Text(
              _isEditing ? 'Lerngruppe bearbeiten' : 'Neue Lerngruppe',
              style: context.typography.title.withColor(style.colors.background),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
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
                    Gap(Style.spacing.xl),

                    // Color picker field
                    ColorPickerField(
                      selectedColor: watch(selectedColor).value,
                      onColorChanged: (newColor) {
                        selectedColor.value = newColor;
                      },
                    ),
                    Gap(Style.spacing.xl),

                    // Pupil Management Section
                    PupilManagementSection(
                      timetableManager: timetableManager,
                      lessonGroupId: lessonGroup?.id,
                      selectedPupilIds: watch(selectedPupilIds).value,
                      onPupilIdsChanged: (newPupilIds) {
                        selectedPupilIds.value = newPupilIds;
                      },
                    ),
                    Gap(Style.spacing.xxl),

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
                            timetableManager.data.timetable.value;
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

                        Future<void> doSave() async {
                          try {
                            if (_isEditing) {
                              await timetableManager.updateLessonGroup(
                                lessonGroupData,
                              );

                              if (lessonGroup?.id != null) {
                                await timetableManager
                                    .updatePupilMembershipsForLessonGroup(
                                      lessonGroup!.id!,
                                      selectedPupilIds.value,
                                    );
                              }

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Klasse erfolgreich aktualisiert',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.of(context).pop();
                              }
                            } else {
                              final created = await timetableManager
                                  .addLessonGroup(lessonGroupData);

                              if (created?.id != null &&
                                  selectedPupilIds.value.isNotEmpty) {
                                await timetableManager
                                    .updatePupilMembershipsForLessonGroup(
                                      created!.id!,
                                      selectedPupilIds.value,
                                    );
                              }

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Klasse erfolgreich erstellt',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.of(
                                  context,
                                ).pop(created ?? lessonGroupData);
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Fehler: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }

                        doSave();
                      },
                      onCancel: () => Navigator.of(context).pop(),
                      onDelete: _isEditing
                          ? () {
                              if (lessonGroup?.id == null) return;

                              // Check if the lesson group is used in any scheduled lessons
                              final scheduledLessons = timetableManager
                                  .data
                                  .scheduledLessons
                                  .value
                                  .where(
                                    (lesson) =>
                                        lesson.lessonGroupId == lessonGroup!.id,
                                  )
                                  .toList();

                              if (scheduledLessons.isNotEmpty) {
                                showDialog<void>(
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

                              showDialog<void>(
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
