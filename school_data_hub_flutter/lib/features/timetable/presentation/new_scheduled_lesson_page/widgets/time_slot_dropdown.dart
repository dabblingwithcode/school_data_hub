import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_utils.dart';
import 'package:watch_it/watch_it.dart';

/// Dropdown widget for selecting a time slot
class TimeSlotDropdown extends WatchingWidget {
  final TimetableSlot? selectedSlot;
  final ValueChanged<TimetableSlot?> onSlotChanged;
  final Function(LessonGroup) hasLessonGroupConflict;
  final Function(Classroom) hasClassroomConflict;

  const TimeSlotDropdown({
    super.key,
    required this.selectedSlot,
    required this.onSlotChanged,
    required this.hasLessonGroupConflict,
    required this.hasClassroomConflict,
  });

  @override
  Widget build(BuildContext context) {
    final slots = watchValue((TimetableManager m) => m.timetableSlots);

    return DropdownButtonFormField<TimetableSlot>(
      value: selectedSlot,
      decoration: const InputDecoration(
        labelText: 'Zeitslot *',
        border: OutlineInputBorder(),
      ),
      items:
          slots.map((slot) {
            return DropdownMenuItem<TimetableSlot>(
              value: slot,
              child: Text(
                '${TimetableUtils.getWeekdayName(slot.day)} ${slot.startTime} - ${slot.endTime}',
              ),
            );
          }).toList(),
      onChanged: (slot) {
        // Reset lesson group if it conflicts with the new time slot
        if (slot != null) {
          // Note: The conflict checking and resetting logic should be handled
          // in the parent widget to maintain proper state management
          onSlotChanged(slot);
        }
      },
      validator: (value) {
        if (value == null) {
          return 'Bitte wählen Sie einen Zeitslot aus';
        }
        return null;
      },
    );
  }
}
