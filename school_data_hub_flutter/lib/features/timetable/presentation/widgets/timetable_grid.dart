import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
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
    final selectedWeekday = watchValue(
      (TimetableManager x) => x.selectedWeekday,
    );

    return ValueListenableBuilder<List<TimetableSlot>>(
      valueListenable: timetableManager.timetableSlots,
      builder: (context, slots, child) {
        return ValueListenableBuilder<List<LessonGroup>>(
          valueListenable: timetableManager.lessonGroups,
          builder: (context, allLessonGroups, child) {
            // Get only lesson groups that have lessons on the selected weekday
            final lessonGroupsForWeekday = timetableManager
                .getLessonGroupsForWeekday(selectedWeekday);
            final timeSlotPeriods = timetableManager.getTimeSlotPeriods();

            if (timeSlotPeriods.isEmpty) {
              return const Center(child: Text('Keine Stunden verfügbar'));
            }

            if (lessonGroupsForWeekday.isEmpty) {
              return const Center(
                child: Text('Keine Stunden für diesen Wochentag'),
              );
            }

            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Scrollbar(
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
                          // Header row with weekday and lesson groups
                          Row(
                            children: [
                              // Weekday + Time column header
                              Container(
                                width: 120,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _getWeekdayName(selectedWeekday),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                      Text(
                                        'Zeit',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Lesson group headers
                              ...lessonGroupsForWeekday.map((group) {
                                return Container(
                                  width: 140,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    color:
                                        group.color != null
                                            ? _parseColor(
                                                  group.color!,
                                                )?.withValues(alpha: 0.2) ??
                                                Colors.grey.shade100
                                            : Colors.grey.shade100,
                                  ),
                                  child: Center(
                                    child: Text(
                                      group.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }).toList(),
                              // Add new lesson column header
                              Container(
                                width: 100,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  color: Colors.green.shade100,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Hinzufügen',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              // Available users column header
                              Container(
                                width: 200,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  color: Colors.blue.shade100,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Verfügbare Lehrer',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Data rows for each time period
                          ...timeSlotPeriods.map((period) {
                            return _buildTimeSlotRow(
                              context,
                              selectedWeekday,
                              period,
                              lessonGroupsForWeekday,
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimeSlotRow(
    BuildContext context,
    Weekday weekday,
    String period,
    List<LessonGroup> lessonGroups,
  ) {
    // Get the slot for this weekday and period
    final slotsForPeriod = timetableManager.getSlotsByTimePeriod(period);
    final slotForWeekday =
        slotsForPeriod.where((slot) => slot.day == weekday).firstOrNull;

    return Row(
      children: [
        // Time period cell
        Container(
          width: 120,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.grey.shade50,
          ),
          child: Center(
            child: Text(
              period,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
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
            height: 80,
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
        _buildAvailableUsersCell(context, weekday, period),
      ],
    );
  }

  Widget _buildAvailableUsersCell(
    BuildContext context,
    Weekday weekday,
    String period,
  ) {
    final userManager = di<UserManager>();

    return ValueListenableBuilder<List<User>>(
      valueListenable: userManager.users,
      builder: (context, users, child) {
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
                      !busyUserIds.contains(
                        user.id,
                      ) && // Not currently teaching
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
                              final availableUnits =
                                  user.timeUnits - timeUnitsUsed;

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${user.userInfo?.fullName ?? 'unbekannt'} ($availableUnits)',
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
        );
      },
    );
  }

  bool _hasAvailableTimeUnits(User user) {
    if (user.id == null) return false;
    final scheduledLessonsCount = timetableManager
        .getScheduledLessonsCountForUser(user.id!);
    return user.timeUnits - scheduledLessonsCount > 1;
  }

  int _getScheduledLessonsCountForUser(int userId) {
    // Use the TimetableManager method instead of local implementation
    return timetableManager.getScheduledLessonsCountForUser(userId);
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

  Color? _parseColor(String colorString) {
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
