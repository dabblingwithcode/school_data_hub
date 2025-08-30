import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:watch_it/watch_it.dart';

class WeekdaySelector extends WatchingWidget {
  final TimetableManager timetableManager;

  const WeekdaySelector({super.key, required this.timetableManager});

  @override
  Widget build(BuildContext context) {
    final selectedWeekday = watchValue(
      (TimetableManager x) => x.selectedWeekday,
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            Weekday.values.map((weekday) {
              final isSelected = selectedWeekday == weekday;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: FilterChip(
                  label: Text(_getWeekdayName(weekday)),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      timetableManager.selectWeekday(weekday);
                    }
                  },
                  selectedColor: Theme.of(context).colorScheme.primaryContainer,
                  checkmarkColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              );
            }).toList(),
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
