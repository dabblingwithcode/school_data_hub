import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom_list_page/classroom_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/new_lesson_group_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/lesson_cell/lesson_cell.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:watch_it/watch_it.dart';

class TimetableGrid extends WatchingWidget {
  final TimetableManager timetableManager;
  final Function(int lessonId) onLessonTap;
  final Function(int slotId) onEmptySlotTap;

  const TimetableGrid({
    super.key,
    required this.timetableManager,
    required this.onLessonTap,
    required this.onEmptySlotTap,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalScrollController = createOnce(() => ScrollController());

    // Watch all necessary state using watch_it
    final selectedWeekday = watchValue(
      (TimetableManager x) => x.selectedWeekday,
    );
    // Watch scheduled lessons to trigger rebuilds when lesson order changes
    final scheduledLessons = watchValue(
      (TimetableManager x) => x.scheduledLessons,
    );
    // Watch selected lesson group IDs to trigger rebuilds when filter changes
    final selectedLessonGroupIds = watchValue(
      (TimetableManager x) => x.selectedLessonGroupIds,
    );

    // Watch lesson groups and scheduled lessons to trigger rebuilds when lessons are added/removed
    final lessonGroupsForWeekday = watchValue(
      (TimetableManager x) => x.lessonGroups,
    );
    final classrooms = watchValue((TimetableManager x) => x.classrooms);
    final allLessonGroupsForWeekday = timetableManager
        .getLessonGroupsForWeekday(selectedWeekday);
    final timeSlotPeriods = timetableManager.getTimeSlotPeriods();

    // Debug logging
    print('TimetableGrid - timeSlotPeriods: ${timeSlotPeriods.length}');
    print(
      'TimetableGrid - allLessonGroupsForWeekday: ${allLessonGroupsForWeekday.length}',
    );
    print('TimetableGrid - selectedWeekday: $selectedWeekday');
    print(
      'TimetableGrid - total lesson groups: ${lessonGroupsForWeekday.length}',
    );
    print(
      'TimetableGrid - selected lesson group IDs: ${selectedLessonGroupIds}',
    );
    print(
      'TimetableGrid - scheduled lessons count: ${scheduledLessons.length}',
    );
    print('TimetableGrid - classrooms count: ${classrooms.length}');

    // Handle empty states
    if (timeSlotPeriods.isEmpty) {
      return const Center(child: Text('Keine Stunden verfügbar'));
    }

    // Check if there are no classrooms defined
    if (classrooms.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.door_front_door, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Keine Räume verfügbar',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Erstellen Sie Räume um Stunden zu planen',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClassroomListPage(),
                  ),
                );
                // Refresh data when returning from ClassroomListPage
                // Note: This will trigger a rebuild of the TimetableGrid
                // since it's watching the TimetableManager state
              },
              child: const Text('Raum erstellen'),
            ),
          ],
        ),
      );
    }

    if (allLessonGroupsForWeekday.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.group, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Keine Klassen verfügbar',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Erstellen Sie Klassen um Stunden zu planen',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewLessonGroupPage(),
                  ),
                );
                // Refresh data when returning from NewLessonGroupPage
                // Note: This will trigger a rebuild of the TimetableGrid
                // since it's watching the TimetableManager state
              },
              child: const Text('Klasse erstellen'),
            ),
          ],
        ),
      );
    }

    return Scrollbar(
      controller: horizontalScrollController,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Data rows for each time period
                ...timeSlotPeriods.map((period) {
                  return _TimetableRow(
                    context: context,
                    weekday: selectedWeekday,
                    period: period,
                    lessonGroups: allLessonGroupsForWeekday,
                    timetableManager: timetableManager,
                    onLessonTap: onLessonTap,
                    onEmptySlotTap: onEmptySlotTap,
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Individual row for a time period in the timetable
class _TimetableRow extends StatelessWidget {
  final BuildContext context;
  final Weekday weekday;
  final String period;
  final List<LessonGroup> lessonGroups;
  final TimetableManager timetableManager;
  final Function(int lessonId) onLessonTap;
  final Function(int slotId) onEmptySlotTap;

  const _TimetableRow({
    required this.context,
    required this.weekday,
    required this.period,
    required this.lessonGroups,
    required this.timetableManager,
    required this.onLessonTap,
    required this.onEmptySlotTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get the slot for this weekday and period
    final slotsForPeriod = timetableManager.getSlotsByTimePeriod(period);
    final slotForWeekday =
        slotsForPeriod.where((slot) => slot.day == weekday).firstOrNull;

    return Row(
      children: [
        // Time period cell
        Center(
          child: Text(
            period,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        // Lesson cells for each group
        ...lessonGroups.map((group) {
          ScheduledLesson? lessonForGroup;

          if (slotForWeekday != null) {
            // Find lesson for this group in this time slot
            final allLessons = timetableManager.getAllLessonsForSlot(
              slotForWeekday.id!,
            );
            lessonForGroup =
                allLessons
                    .where((lesson) => lesson.lessonGroupId == group.id)
                    .firstOrNull;
          }

          return Container(
            width: 140,
            constraints: const BoxConstraints(minHeight: 80),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child:
                slotForWeekday != null
                    ? LessonCell(
                      lesson: lessonForGroup,
                      slot: slotForWeekday,
                      onTap: () {
                        if (lessonForGroup != null) {
                          onLessonTap(lessonForGroup.id!);
                        } else {
                          // Create lesson for this specific group and slot
                          onEmptySlotTap(slotForWeekday.id!);
                        }
                      },
                    )
                    : const SizedBox.shrink(),
          );
        }).toList(),
        // Add new lesson button
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.green.shade50,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:
                  slotForWeekday != null
                      ? () => onEmptySlotTap(slotForWeekday.id!)
                      : null,
              child: const Center(
                child: Icon(Icons.add, color: Colors.green, size: 24),
              ),
            ),
          ),
        ),
        // Available users column
        _AvailableUsersCell(
          context: context,
          weekday: weekday,
          period: period,
          timetableManager: timetableManager,
        ),
      ],
    );
  }
}

/// Cell showing available teachers for a time slot
class _AvailableUsersCell extends WatchingWidget {
  final BuildContext context;
  final Weekday weekday;
  final String period;
  final TimetableManager timetableManager;

  const _AvailableUsersCell({
    required this.context,
    required this.weekday,
    required this.period,
    required this.timetableManager,
  });

  @override
  Widget build(BuildContext context) {
    final users = watchValue((UserManager m) => di<UserManager>().users);

    // Get busy user IDs for this time slot
    final busyUserIds = timetableManager.getBusyUserIdsForTimeSlot(
      weekday,
      period,
    );

    // Filter available users
    final availableUsers =
        users
            .where(
              (user) =>
                  user.role == Role.teacher && // Only teachers
                  user.id != null &&
                  !busyUserIds.contains(user.id) && // Not currently teaching
                  _hasAvailableTimeUnits(user), // Has time units left
            )
            .toList();

    return Container(
      width: 200,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.blue.shade50,
      ),
      child:
          availableUsers.isEmpty
              ? const Center(
                child: Text(
                  'Keine Lehrer\nverfügbar',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(4.0),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 2,
                    runSpacing: 2,
                    children:
                        availableUsers.map((user) {
                          final timeUnitsUsed =
                              _getScheduledLessonsCountForUser(user.id!);
                          final availableUnits = user.timeUnits - timeUnitsUsed;

                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${user.userInfo?.fullName ?? 'unbekannt'} ($availableUnits)',
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
    );
  }

  bool _hasAvailableTimeUnits(User user) {
    if (user.id == null) return false;
    final scheduledLessonsCount = timetableManager
        .getScheduledLessonsCountForUser(user.id!);
    return user.timeUnits - scheduledLessonsCount > 1;
  }

  int _getScheduledLessonsCountForUser(int userId) {
    return timetableManager.getScheduledLessonsCountForUser(userId);
  }
}
