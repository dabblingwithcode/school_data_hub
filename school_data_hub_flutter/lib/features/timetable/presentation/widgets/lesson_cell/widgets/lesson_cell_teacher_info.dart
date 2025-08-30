import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:watch_it/watch_it.dart';

class LessonCellTeacherInfo extends WatchingWidget {
  final ScheduledLesson lesson;

  const LessonCellTeacherInfo({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    // Watch the users list for changes
    final users = watchValue((UserManager m) => m.users);

    // Get main teacher
    final mainTeacher =
        users.where((user) => user.id == lesson.mainTeacherId).firstOrNull;

    // Get lesson teachers (excluding main teacher)
    final additionalTeachers =
        lesson.lessonTeachers
            ?.where((lt) => lt.userId != lesson.mainTeacherId)
            .toList() ??
        [];

    // Create list of all teachers for this lesson
    final allLessonTeachers = <User>[];

    // Add main teacher first
    if (mainTeacher != null) {
      allLessonTeachers.add(mainTeacher);
    }

    // Add additional teachers
    for (final lessonTeacher in additionalTeachers) {
      final teacher =
          users.where((user) => user.id == lessonTeacher.userId).firstOrNull;
      if (teacher != null) {
        allLessonTeachers.add(teacher);
      }
    }

    // Return wrap of teacher chips
    return Wrap(
      spacing: 1,
      runSpacing: 0,
      children:
          allLessonTeachers.map((teacher) {
            final isMainTeacher = teacher.id == lesson.mainTeacherId;
            final userName =
                teacher.userInfo?.userName?.isNotEmpty == true
                    ? teacher.userInfo!.userName!.length >= 3
                        ? teacher.userInfo!.userName!
                            .substring(0, 3)
                            .toUpperCase()
                        : teacher.userInfo!.userName!.toUpperCase()
                    : 'TEA';

            return Chip(
              label: Text(
                userName,
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: isMainTeacher ? Colors.orange : Colors.blue,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 0,
              ),
            );
          }).toList(),
    );
  }
}
