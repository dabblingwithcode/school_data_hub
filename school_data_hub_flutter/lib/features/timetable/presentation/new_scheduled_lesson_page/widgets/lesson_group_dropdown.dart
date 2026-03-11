import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_overlap_helper.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/new_lesson_group_page.dart';

/// Dropdown widget for selecting a lesson group.
/// Availability is based on overlap with the target slot (no synchronous callbacks).
/// When target slot is null, all groups are shown.
class LessonGroupDropdown extends WatchingWidget {
  final LessonGroup? selectedLessonGroup;
  final ValueChanged<LessonGroup?> onLessonGroupChanged;
  final Weekday? targetWeekday;
  final String? targetStartTime;
  final String? targetEndTime;
  final int? excludeLessonId;

  const LessonGroupDropdown({
    super.key,
    required this.selectedLessonGroup,
    required this.onLessonGroupChanged,
    this.targetWeekday,
    this.targetStartTime,
    this.targetEndTime,
    this.excludeLessonId,
  });

  static bool _hasConflict(
    LessonGroup group,
    List<ScheduledLesson> lessons,
    Weekday weekday,
    String startTime,
    String endTime,
    int? excludeId,
  ) {
    return TimetableOverlapHelper.lessonGroupHasOverlappingLesson(
      lessons,
      excludeLessonId: excludeId,
      weekday: weekday,
      startTime: startTime,
      endTime: endTime,
      lessonGroupId: group.id!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lessonGroups = watchValue((TimetableManager m) => m.lessonGroups);
    final scheduledLessons = watchValue(
      (TimetableManager m) => m.scheduledLessons,
    );

    final hasTargetSlot =
        targetWeekday != null &&
        targetStartTime != null &&
        targetEndTime != null;

    final availableLessonGroups = lessonGroups.where((group) {
      if (!hasTargetSlot) return true;
      return !_hasConflict(
        group,
        scheduledLessons,
        targetWeekday!,
        targetStartTime!,
        targetEndTime!,
        excludeLessonId,
      );
    }).toList();

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
            initialValue: selectedValue,
            decoration: const InputDecoration(
              labelText: 'Lerngruppen *',
              border: OutlineInputBorder(),
              helperText: 'Nur verfügbare Gruppen in diesem Zeitslot',
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
              if (hasTargetSlot &&
                  _hasConflict(
                    value,
                    scheduledLessons,
                    targetWeekday!,
                    targetStartTime!,
                    targetEndTime!,
                    excludeLessonId,
                  )) {
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
              MaterialPageRoute<LessonGroup>(
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
