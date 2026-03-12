import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_overlap_helper.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:flutter_it/flutter_it.dart';

/// Widget for selecting teachers for a lesson.
/// Accepts a [ValueNotifier<List<User>>] and watches it directly so the chip
/// list stays in sync without depending on the parent to pass updated props.
class TeacherSelection extends WatchingWidget {
  final ValueNotifier<List<User>> selectedTeachersNotifier;
  final Weekday? targetWeekday;
  final String? targetStartTime;
  final String? targetEndTime;
  final List<ScheduledLesson>? scheduledLessons;
  final int? excludeLessonId;

  const TeacherSelection({
    super.key,
    required this.selectedTeachersNotifier,
    this.targetWeekday,
    this.targetStartTime,
    this.targetEndTime,
    this.scheduledLessons,
    this.excludeLessonId,
  });

  bool _teacherHasOverlap(User user) {
    if (targetWeekday == null ||
        targetStartTime == null ||
        targetEndTime == null ||
        scheduledLessons == null ||
        user.id == null) {
      return false;
    }
    return TimetableOverlapHelper.teacherHasOverlappingLesson(
      scheduledLessons!,
      excludeLessonId: excludeLessonId,
      weekday: targetWeekday!,
      startTime: targetStartTime!,
      endTime: targetEndTime!,
      userId: user.id!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = watchValue((UserManager m) => m.users);
    final selectedTeachers = watch(selectedTeachersNotifier).value;

    // Internal key to reset the dropdown after each selection.
    final dropdownKeyVn = createOnce<ValueNotifier<int>>(
      () => ValueNotifier<int>(0),
    );
    final dropdownKeyValue = watch(dropdownKeyVn).value;

    final availableToAdd = users.where((user) {
      if (user.role != Role.teacher || user.id == null) return false;
      if (selectedTeachers.any((t) => t.id == user.id)) return false;
      if (_teacherHasOverlap(user)) return false;
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lehrer *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              // Selected teachers
              if (selectedTeachers.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ausgewählte Lehrer:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedTeachers.asMap().entries.map((entry) {
                          final index = entry.key;
                          final teacher = entry.value;
                          final isMainTeacher = index == 0;

                          return _TeacherChip(
                            teacher: teacher,
                            isMainTeacher: isMainTeacher,
                            index: index,
                            totalTeachers: selectedTeachers.length,
                            onMoveUp: index > 0
                                ? () => _moveTeacher(
                                      selectedTeachers,
                                      index,
                                      -1,
                                    )
                                : null,
                            onMoveDown: index < selectedTeachers.length - 1
                                ? () => _moveTeacher(
                                      selectedTeachers,
                                      index,
                                      1,
                                    )
                                : null,
                            onRemove: () =>
                                _removeTeacher(selectedTeachers, teacher),
                          );
                        }).toList(),
                      ),
                      if (selectedTeachers.length > 1)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Tipp: Der erste Lehrer wird als Hauptlehrer gesetzt. Verwenden Sie ↑↓ um die Reihenfolge zu ändern.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              // Teacher dropdown — hidden once the 3-teacher cap is reached.
              if (selectedTeachers.length < 3)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: DropdownButtonFormField<int>(
                    key: Key('teacher_dropdown_$dropdownKeyValue'),
                    initialValue: null,
                    decoration: const InputDecoration(
                      labelText: 'Lehrer hinzufügen',
                      border: OutlineInputBorder(),
                    ),
                    items: availableToAdd
                        .map(
                          (user) => DropdownMenuItem<int>(
                            value: user.id,
                            child: Text(
                              user.userInfo?.fullName ?? 'Unbekannter Lehrer',
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (userId) {
                      if (userId != null) {
                        final user = users.firstWhere((u) => u.id == userId);
                        selectedTeachersNotifier.value = [
                          ...selectedTeachers,
                          user,
                        ];
                        dropdownKeyVn.value++;
                      }
                    },
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Maximale Anzahl von 3 Lehrern erreicht.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _moveTeacher(List<User> current, int index, int direction) {
    final newTeachers = List<User>.from(current);
    final newIndex = index + direction;
    final temp = newTeachers[index];
    newTeachers[index] = newTeachers[newIndex];
    newTeachers[newIndex] = temp;
    selectedTeachersNotifier.value = newTeachers;
  }

  void _removeTeacher(List<User> current, User teacher) {
    selectedTeachersNotifier.value =
        List<User>.from(current)..remove(teacher);
  }
}

/// Individual teacher chip widget
class _TeacherChip extends StatelessWidget {
  final User teacher;
  final bool isMainTeacher;
  final int index;
  final int totalTeachers;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;
  final VoidCallback onRemove;

  const _TeacherChip({
    required this.teacher,
    required this.isMainTeacher,
    required this.index,
    required this.totalTeachers,
    this.onMoveUp,
    this.onMoveDown,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isMainTeacher
            ? Colors.orange.withValues(alpha: 0.1)
            : Theme.of(context).chipTheme.backgroundColor,
        border: Border.all(
          color: isMainTeacher
              ? Colors.orange
              : Colors.grey.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isMainTeacher)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(Icons.star, size: 16, color: Colors.orange),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: isMainTeacher ? 4.0 : 12.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teacher.userInfo?.fullName ?? 'Unbekannter Lehrer',
                  style: TextStyle(
                    fontWeight:
                        isMainTeacher ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (isMainTeacher)
                  const Text(
                    'Hauptlehrer',
                    style: TextStyle(fontSize: 10, color: Colors.orange),
                  ),
              ],
            ),
          ),
          // Reorder buttons (only show if more than 1 teacher)
          if (totalTeachers > 1) ...[
            if (onMoveUp != null)
              InkWell(
                onTap: onMoveUp,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.keyboard_arrow_up, size: 16),
                ),
              ),
            if (onMoveDown != null)
              InkWell(
                onTap: onMoveDown,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.keyboard_arrow_down, size: 16),
                ),
              ),
          ],
          // Delete button
          InkWell(
            onTap: onRemove,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.close, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
