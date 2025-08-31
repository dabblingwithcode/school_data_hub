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

    // Limit to 3 teachers maximum
    final displayTeachers = allLessonTeachers.take(3).toList();

    // Return row of teacher containers - always show 3 containers
    return Row(
      children: List.generate(3, (index) {
        if (index < displayTeachers.length) {
          final teacher = displayTeachers[index];
          final isMainTeacher = teacher.id == lesson.mainTeacherId;
          final userName =
              teacher.userInfo?.userName?.isNotEmpty == true
                  ? teacher.userInfo!.userName!.length >= 3
                      ? teacher.userInfo!.userName!
                          .substring(0, 3)
                          .toUpperCase()
                      : teacher.userInfo!.userName!.toUpperCase()
                  : 'TEA';

          return Expanded(
            child: SizedBox(
              height: 20,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: isMainTeacher ? Colors.orange : Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color:
                        isMainTeacher
                            ? Colors.orange.shade700
                            : Colors.blue.shade700,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        } else {
          // Empty container to maintain equal spacing
          return Expanded(
            child: SizedBox(
              height: 20, // Fixed height to match teacher containers
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
