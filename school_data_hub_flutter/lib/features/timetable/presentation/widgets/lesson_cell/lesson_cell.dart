import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/lesson_cell/widgets/lesson_cell_teacher_info.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:watch_it/watch_it.dart';

class LessonCell extends WatchingWidget {
  final ScheduledLesson? lesson;
  final TimetableSlot slot;
  final VoidCallback onTap;
  final Function(ScheduledLesson)? onLessonReorder;

  const LessonCell({
    super.key,
    this.lesson,
    required this.slot,
    required this.onTap,
    this.onLessonReorder,
  });

  @override
  Widget build(BuildContext context) {
    final _userManager = di<UserManager>();
    final _timetableManager = di<TimetableManager>();

    if (lesson != null) {
      return LongPressDraggable<ScheduledLesson>(
        data: lesson!,
        feedback: Material(
          elevation: 6.0,
          child: Container(
            width: 140,
            height: 80,
            child: _buildLessonContent(context, _userManager),
          ),
        ),
        childWhenDragging: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Icon(
              Icons.drag_indicator,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ),
        ),
        child: DragTarget<ScheduledLesson>(
          onWillAcceptWithDetails: (details) {
            // Accept any different lesson (can be from same or different time slot)
            return details.data.id != lesson!.id;
          },
          onAcceptWithDetails: (details) {
            _swapLessonOrder(context, details.data, lesson!, _timetableManager);
          },
          builder: (context, candidateData, rejectedData) {
            return Material(
              child: InkWell(
                onTap: () => _showTeacherSelection(context, _timetableManager),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(4.0),
                  decoration:
                      candidateData.isNotEmpty
                          ? BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(4),
                          )
                          : null,
                  child: _buildLessonContent(context, _userManager),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return DragTarget<ScheduledLesson>(
        onWillAcceptWithDetails: (details) {
          // Accept lessons that can be moved to this empty slot
          return details.data.scheduledAtId != slot.id;
        },
        onAcceptWithDetails: (details) {
          _moveLessonToSlot(context, details.data, slot, _timetableManager);
        },
        builder: (context, candidateData, rejectedData) {
          return Material(
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(4.0),
                decoration:
                    candidateData.isNotEmpty
                        ? BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(4),
                        )
                        : null,
                child: _buildEmptyContent(context),
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildLessonContent(BuildContext context, UserManager userManager) {
    final subjectName = lesson!.subject?.name ?? 'Unbekanntes Fach';
    final roomCode = lesson!.room?.roomCode ?? '???';
    final groupName = lesson!.lessonGroup?.name ?? 'Unbekannte Gruppe';
    final subjectColor = lesson!.subject?.color;

    return Container(
      decoration: BoxDecoration(
        color:
            _parseColor(subjectColor)?.withValues(alpha: 0.7) ??
            Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color:
              _parseColor(subjectColor) ??
              Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            subjectName,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            groupName,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            roomCode,
            style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          // Show teachers
          LessonCellTeacherInfo(lesson: lesson!),
        ],
      ),
    );
  }

  Widget _buildEmptyContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Icon(Icons.add, color: Colors.grey.shade400, size: 16),
      ),
    );
  }

  void _showTeacherSelection(
    BuildContext context,
    TimetableManager timetableManager,
  ) {
    if (lesson?.id == null) return;

    showDialog(
      context: context,
      builder:
          (context) => _TeacherSelectionDialog(
            lesson: lesson!,
            slot: slot,
            timetableManager: timetableManager,
          ),
    );
  }

  Color? _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;

    try {
      String hexColor = colorString;
      if (!hexColor.startsWith('#')) {
        hexColor = '#$hexColor';
      }

      if (hexColor.length == 7) {
        return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
      }
    } catch (e) {
      // Return null if color parsing fails
    }
    return null;
  }
}

class _TeacherSelectionDialog extends WatchingStatefulWidget {
  final ScheduledLesson lesson;
  final TimetableSlot slot;
  final TimetableManager timetableManager;

  const _TeacherSelectionDialog({
    required this.lesson,
    required this.slot,
    required this.timetableManager,
  });

  @override
  State<_TeacherSelectionDialog> createState() =>
      _TeacherSelectionDialogState();
}

class _TeacherSelectionDialogState extends State<_TeacherSelectionDialog> {
  late List<int> _selectedTeacherIds;
  late int _mainTeacherId;

  @override
  void initState() {
    super.initState();
    _mainTeacherId = widget.lesson.mainTeacherId;
    _selectedTeacherIds = [
      _mainTeacherId,
      ...(widget.lesson.lessonTeachers?.map((lt) => lt.userId) ?? []),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Watch the users list for changes
    final users = watchValue((UserManager m) => m.users);

    // Get all teachers (users with teacher role)
    final allTeachers =
        users.where((user) => user.role == Role.teacher).toList();

    // Get available teachers for this time slot (not busy with other lessons)
    final busyUserIds = widget.timetableManager.getBusyUserIdsForTimeSlot(
      widget.slot.day,
      widget.slot.startTime,
    );
    final availableTeachers =
        allTeachers.where((teacher) {
          // Include if not busy OR already assigned to this lesson
          return !busyUserIds.contains(teacher.id) ||
              _selectedTeacherIds.contains(teacher.id);
        }).toList();

    return AlertDialog(
      title: Text(
        'Lehrer für ${widget.lesson.subject?.name ?? "Stunde"} auswählen',
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${_getWeekdayName(widget.slot.day)} ${widget.slot.startTime} - ${widget.slot.endTime}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      availableTeachers.map((teacher) {
                        final isSelected = _selectedTeacherIds.contains(
                          teacher.id,
                        );
                        final isMainTeacher = teacher.id == _mainTeacherId;
                        final isBusy =
                            busyUserIds.contains(teacher.id) && !isSelected;

                        // Get remaining time units for this teacher
                        final remainingTimeUnits = widget.timetableManager
                            .getRemainingTimeUnitsForUser(
                              teacher.id!,
                              teacher.timeUnits,
                            );

                        return CheckboxListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  teacher.userInfo?.fullName ??
                                      'Unbekannter Lehrer',
                                  style: TextStyle(
                                    fontWeight:
                                        isMainTeacher
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color: isBusy ? Colors.grey : null,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      remainingTimeUnits > 0
                                          ? Colors.green
                                          : Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${remainingTimeUnits}h',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(teacher.userInfo?.email ?? ''),
                              if (isMainTeacher)
                                const Text(
                                  'Hauptlehrer',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              if (isBusy)
                                const Text(
                                  'Belegt zu dieser Zeit',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              if (remainingTimeUnits <= 0)
                                const Text(
                                  'Keine verfügbaren Stunden',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                          value: isSelected,
                          onChanged:
                              teacher.id == null
                                  ? null
                                  : (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        if (!_selectedTeacherIds.contains(
                                          teacher.id,
                                        )) {
                                          _selectedTeacherIds.add(teacher.id!);
                                        }
                                      } else {
                                        // Don't allow unchecking main teacher
                                        if (teacher.id != _mainTeacherId) {
                                          _selectedTeacherIds.remove(
                                            teacher.id,
                                          );
                                        }
                                      }
                                    });
                                  },
                          secondary:
                              isMainTeacher
                                  ? const Icon(Icons.star, color: Colors.orange)
                                  : IconButton(
                                    icon: const Icon(
                                      Icons.star_border,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _mainTeacherId = teacher.id!;
                                        // Ensure main teacher is selected
                                        if (!_selectedTeacherIds.contains(
                                          teacher.id,
                                        )) {
                                          _selectedTeacherIds.add(teacher.id!);
                                        }
                                      });
                                    },
                                    tooltip: 'Als Hauptlehrer setzen',
                                  ),
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Der Hauptlehrer kann nicht entfernt werden. Klicken Sie auf den Stern um einen anderen Hauptlehrer zu wählen.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        ElevatedButton(
          onPressed: _saveTeacherAssignments,
          child: const Text('Speichern'),
        ),
      ],
    );
  }

  void _saveTeacherAssignments() {
    // Update the lesson with new teacher assignments
    final updatedLessonTeachers =
        _selectedTeacherIds
            .where(
              (id) => id != _mainTeacherId,
            ) // Exclude main teacher from lessonTeachers list
            .map(
              (id) => ScheduledLessonTeacher(
                userId: id,
                scheduledLessonId: widget.lesson.id!,
              ),
            )
            .toList();

    final updatedLesson = widget.lesson.copyWith(
      mainTeacherId: _mainTeacherId,
      lessonTeachers: updatedLessonTeachers,
    );

    widget.timetableManager.updateScheduledLesson(updatedLesson);

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Lehrer erfolgreich aktualisiert (${_selectedTeacherIds.length} Lehrer)',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _getWeekdayName(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return 'Montag';
      case Weekday.tuesday:
        return 'Dienstag';
      case Weekday.wednesday:
        return 'Mittwoch';
      case Weekday.thursday:
        return 'Donnerstag';
      case Weekday.friday:
        return 'Freitag';
    }
  }
}

// Helper functions for drag and drop functionality
void _swapLessonOrder(
  BuildContext context,
  ScheduledLesson draggedLesson,
  ScheduledLesson targetLesson,
  TimetableManager timetableManager,
) {
  // Check if lessons are in the same time slot
  if (draggedLesson.scheduledAtId == targetLesson.scheduledAtId) {
    // Same slot: Insert at target position, shift others accordingly
    timetableManager.insertLessonAtPosition(
      draggedLesson,
      targetLesson.scheduledAtId,
      targetLesson.timetableSlotOrder,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Stunden-Reihenfolge erfolgreich geändert'),
        backgroundColor: Colors.green,
      ),
    );
  } else {
    // Different slots: Move to target slot and position
    timetableManager.insertLessonAtPosition(
      draggedLesson,
      targetLesson.scheduledAtId,
      targetLesson.timetableSlotOrder,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Stunde erfolgreich in anderen Zeitslot verschoben'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

void _moveLessonToSlot(
  BuildContext context,
  ScheduledLesson draggedLesson,
  TimetableSlot targetSlot,
  TimetableManager timetableManager,
) {
  // Move lesson to different time slot at the end of the list
  final nextAvailableOrder = timetableManager.getNextAvailableOrderForSlot(
    targetSlot.id!,
  );

  // Use insertLessonAtPosition to ensure proper handling
  timetableManager.insertLessonAtPosition(
    draggedLesson,
    targetSlot.id!,
    nextAvailableOrder,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Stunde erfolgreich verschoben'),
      backgroundColor: Colors.green,
    ),
  );
}
