import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/new_lesson_group_page.dart';

/// Dropdown widget for selecting a lesson group
class LessonGroupDropdown extends WatchingWidget {
  final LessonGroup? selectedLessonGroup;
  final ValueChanged<LessonGroup?> onLessonGroupChanged;
  final bool Function(LessonGroup) hasLessonGroupConflict;

  const LessonGroupDropdown({
    super.key,
    required this.selectedLessonGroup,
    required this.onLessonGroupChanged,
    required this.hasLessonGroupConflict,
  });

  @override
  Widget build(BuildContext context) {
    final lessonGroups = watchValue((TimetableManager m) => m.lessonGroups);

    // Filter out lesson groups that already have a lesson at the selected time slot
    final availableLessonGroups = lessonGroups.where((group) {
      return !hasLessonGroupConflict(group);
    }).toList();

    // Map the selected lesson group (possibly from a different instance)
    // to the concrete instance used in the items list so DropdownButtonFormField
    // sees exactly one matching value. If the selected group isn't yet in the
    // available list (e.g. just created and data not refreshed), we pass null
    // so that no invalid initialValue is set.
    LessonGroup? selectedValue;
    if (selectedLessonGroup != null) {
      for (final group in availableLessonGroups) {
        if (group.id == selectedLessonGroup!.id) {
          selectedValue = group;
          break;
        }
      }
    }

    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<LessonGroup>(
            // Using initialValue keeps form semantics, while selectedValue
            // is guaranteed to be one of the items so that exactly one
            // match exists.
            initialValue: selectedValue,
            decoration: InputDecoration(
              labelText: 'Klasse *',
              border: const OutlineInputBorder(),
              helperText: 'Nur verfügbare Klassen',
            ),
            items: availableLessonGroups.map((group) {
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
