import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/widgets/timetable_utils.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: FilterChip(
                  label: Text(
                    TimetableUtils.getWeekdayName(weekday),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      timetableManager.selectWeekday(weekday);
                    }
                  },
                  selectedColor: AppColors.accentColor,
                  checkmarkColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor:
                      isSelected
                          ? Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1)
                          : null,
                  elevation: isSelected ? 4 : 1,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
