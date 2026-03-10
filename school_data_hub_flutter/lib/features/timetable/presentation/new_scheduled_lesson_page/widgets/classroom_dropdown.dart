import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_overlap_helper.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom/new_classroom_page/new_classroom_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_utils.dart';

/// Dropdown widget for selecting a classroom.
/// Availability is based on overlap with the target slot (no synchronous callbacks).
/// When target slot is null, all classrooms are shown.
class ClassroomDropdown extends WatchingWidget {
  final Classroom? selectedClassroom;
  final ValueChanged<Classroom?> onClassroomChanged;
  final Weekday? targetWeekday;
  final String? targetStartTime;
  final String? targetEndTime;
  final int? excludeLessonId;

  const ClassroomDropdown({
    super.key,
    required this.selectedClassroom,
    required this.onClassroomChanged,
    this.targetWeekday,
    this.targetStartTime,
    this.targetEndTime,
    this.excludeLessonId,
  });

  static bool _hasConflict(
    Classroom classroom,
    List<ScheduledLesson> lessons,
    Weekday weekday,
    String startTime,
    String endTime,
    int? excludeId,
  ) {
    return TimetableOverlapHelper.classroomHasOverlappingLesson(
      lessons,
      excludeLessonId: excludeId,
      weekday: weekday,
      startTime: startTime,
      endTime: endTime,
      roomId: classroom.id!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final classrooms = watchValue((TimetableManager m) => m.classrooms);
    final scheduledLessons =
        watchValue((TimetableManager m) => m.scheduledLessons);
    final selectedSlot = watchValue((TimetableManager m) => m.selectedWeekday);

    final hasTargetSlot = targetWeekday != null &&
        targetStartTime != null &&
        targetEndTime != null;

    final availableClassrooms = classrooms.where((classroom) {
      if (!hasTargetSlot) return true;
      return !_hasConflict(
        classroom,
        scheduledLessons,
        targetWeekday!,
        targetStartTime!,
        targetEndTime!,
        excludeLessonId,
      );
    }).toList();

    Classroom? validInitialValue;
    if (selectedClassroom != null) {
      for (final c in availableClassrooms) {
        if (c.id == selectedClassroom!.id) {
          validInitialValue = c;
          break;
        }
      }
    }

    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<Classroom>(
            initialValue: validInitialValue,
            decoration: InputDecoration(
              labelText: 'Raum *',
              border: const OutlineInputBorder(),
              helperText:
                  'Nur verfügbare Räume für ${TimetableUtils.getWeekdayName(selectedSlot)}',
            ),
            items: availableClassrooms.map((classroom) {
              return DropdownMenuItem<Classroom>(
                value: classroom,
                child: Text('${classroom.roomCode} - ${classroom.roomName}'),
              );
            }).toList(),
            onChanged: onClassroomChanged,
            validator: (value) {
              if (value == null) {
                return 'Bitte wählen Sie einen Raum aus';
              }
              if (hasTargetSlot &&
                  _hasConflict(
                    value,
                    scheduledLessons,
                    targetWeekday!,
                    targetStartTime!,
                    targetEndTime!,
                    excludeLessonId,
                  )) {
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
