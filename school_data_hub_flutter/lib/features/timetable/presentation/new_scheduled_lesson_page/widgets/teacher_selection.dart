import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:watch_it/watch_it.dart';

/// Widget for selecting teachers for a lesson
class TeacherSelection extends WatchingWidget {
  final List<User> selectedTeachers;
  final ValueChanged<List<User>> onTeachersChanged;
  final int dropdownKey;

  const TeacherSelection({
    super.key,
    required this.selectedTeachers,
    required this.onTeachersChanged,
    required this.dropdownKey,
  });

  @override
  Widget build(BuildContext context) {
    final users = watchValue((UserManager m) => m.users);

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
                        children:
                            selectedTeachers.asMap().entries.map((entry) {
                              final index = entry.key;
                              final teacher = entry.value;
                              final isMainTeacher = index == 0;

                              return _TeacherChip(
                                teacher: teacher,
                                isMainTeacher: isMainTeacher,
                                index: index,
                                totalTeachers: selectedTeachers.length,
                                onMoveUp:
                                    index > 0
                                        ? () => _moveTeacher(index, -1)
                                        : null,
                                onMoveDown:
                                    index < selectedTeachers.length - 1
                                        ? () => _moveTeacher(index, 1)
                                        : null,
                                onRemove: () => _removeTeacher(teacher),
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
              // Teacher dropdown
              Padding(
                padding: const EdgeInsets.all(12),
                child: DropdownButtonFormField<int>(
                  key: Key('teacher_dropdown_$dropdownKey'),
                  value:
                      null, // Always null since this is for adding new teachers
                  decoration: const InputDecoration(
                    labelText: 'Lehrer hinzufügen',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      users
                          .where(
                            (user) =>
                                user.role == Role.teacher &&
                                user.id != null &&
                                !selectedTeachers.any((t) => t.id == user.id),
                          )
                          .map((user) {
                            return DropdownMenuItem<int>(
                              value: user.id,
                              child: Text(
                                user.userInfo?.fullName ?? 'Unbekannter Lehrer',
                              ),
                            );
                          })
                          .toList(),
                  onChanged: (userId) {
                    if (userId != null) {
                      final user = users.firstWhere((u) => u.id == userId);
                      final newTeachers = List<User>.from(selectedTeachers)
                        ..add(user);
                      onTeachersChanged(newTeachers);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _moveTeacher(int index, int direction) {
    final newTeachers = List<User>.from(selectedTeachers);
    final newIndex = index + direction;
    final temp = newTeachers[index];
    newTeachers[index] = newTeachers[newIndex];
    newTeachers[newIndex] = temp;
    onTeachersChanged(newTeachers);
  }

  void _removeTeacher(User teacher) {
    final newTeachers = List<User>.from(selectedTeachers)..remove(teacher);
    onTeachersChanged(newTeachers);
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
        color:
            isMainTeacher
                ? Colors.orange.withValues(alpha: 0.1)
                : Theme.of(context).chipTheme.backgroundColor,
        border: Border.all(
          color:
              isMainTeacher
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
