import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_classroom_page/new_classroom_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_utils.dart';
import 'package:watch_it/watch_it.dart';

/// Dropdown widget for selecting a classroom
class ClassroomDropdown extends WatchingWidget {
  final Classroom? selectedClassroom;
  final ValueChanged<Classroom?> onClassroomChanged;
  final Function(Classroom) hasClassroomConflict;

  const ClassroomDropdown({
    super.key,
    required this.selectedClassroom,
    required this.onClassroomChanged,
    required this.hasClassroomConflict,
  });

  @override
  Widget build(BuildContext context) {
    final classrooms = watchValue((TimetableManager m) => m.classrooms);
    final selectedSlot = watchValue((TimetableManager m) => m.selectedWeekday);

    // Filter out classrooms that already have a lesson at the selected time slot
    final availableClassrooms =
        classrooms.where((classroom) {
          return !hasClassroomConflict(classroom);
        }).toList();

    // Ensure the selected classroom is available in the filtered list
    final validInitialValue =
        selectedClassroom != null &&
                availableClassrooms.any(
                  (classroom) => classroom.id == selectedClassroom!.id,
                )
            ? selectedClassroom
            : null;

    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<Classroom>(
            value: validInitialValue,
            decoration: InputDecoration(
              labelText: 'Raum *',
              border: const OutlineInputBorder(),
              helperText:
                  'Nur verfügbare Räume für ${TimetableUtils.getWeekdayName(selectedSlot)}',
            ),
            items:
                availableClassrooms.map((classroom) {
                  return DropdownMenuItem<Classroom>(
                    value: classroom,
                    child: Text(
                      '${classroom.roomCode} - ${classroom.roomName}',
                    ),
                  );
                }).toList(),
            onChanged: onClassroomChanged,
            validator: (value) {
              if (value == null) {
                return 'Bitte wählen Sie einen Raum aus';
              }

              // Additional validation: check for conflicts
              if (hasClassroomConflict(value)) {
                return 'Dieser Raum ist bereits zu dieser Zeit belegt';
              }

              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () async {
            final result = await Navigator.of(context).push<Classroom>(
              MaterialPageRoute(builder: (context) => const NewClassroomPage()),
            );

            if (result != null && context.mounted) {
              onClassroomChanged(result);
            }
          },
          child: const Icon(Icons.add, color: Colors.blue),
        ),
      ],
    );
  }
}
