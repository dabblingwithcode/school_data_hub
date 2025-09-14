import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/new_lesson_group_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_utils.dart';
import 'package:watch_it/watch_it.dart';

/// Dropdown widget for selecting a lesson group
class LessonGroupDropdown extends WatchingWidget {
  final LessonGroup? selectedLessonGroup;
  final ValueChanged<LessonGroup?> onLessonGroupChanged;
  final Function(LessonGroup) hasLessonGroupConflict;

  const LessonGroupDropdown({
    super.key,
    required this.selectedLessonGroup,
    required this.onLessonGroupChanged,
    required this.hasLessonGroupConflict,
  });

  @override
  Widget build(BuildContext context) {
    final lessonGroups = watchValue((TimetableManager m) => m.lessonGroups);
    final selectedSlot = watchValue((TimetableManager m) => m.selectedWeekday);

    // Filter out lesson groups that already have a lesson at the selected time slot
    final availableLessonGroups =
        lessonGroups.where((group) {
          return !hasLessonGroupConflict(group);
        }).toList();

    // Ensure the selected lesson group is available in the filtered list
    final validInitialValue =
        selectedLessonGroup != null &&
                availableLessonGroups.any(
                  (group) => group.id == selectedLessonGroup!.id,
                )
            ? selectedLessonGroup
            : null;

    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<LessonGroup>(
            initialValue: validInitialValue,
            decoration: InputDecoration(
              labelText: 'Klasse *',
              border: const OutlineInputBorder(),
              helperText:
                  'Nur verfügbare Klassen für ${TimetableUtils.getWeekdayName(selectedSlot)}',
            ),
            items:
                availableLessonGroups.map((group) {
                  return DropdownMenuItem<LessonGroup>(
                    value: group,
                    child: Text(group.name),
                  );
                }).toList(),
            onChanged: onLessonGroupChanged,
            validator: (value) {
              if (value == null) {
                return 'Bitte wählen Sie eine Klasse aus';
              }

              // Additional validation: check for conflicts
              if (hasLessonGroupConflict(value)) {
                return 'Diese Klasse hat bereits eine Stunde zu dieser Zeit';
              }

              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () async {
            final result = await Navigator.of(context).push<LessonGroup>(
              MaterialPageRoute(
                builder: (context) => const NewLessonGroupPage(),
              ),
            );

            if (result != null && context.mounted) {
              onLessonGroupChanged(result);
            }
          },
          child: const Icon(Icons.add, color: Colors.blue),
        ),
      ],
    );
  }
}
