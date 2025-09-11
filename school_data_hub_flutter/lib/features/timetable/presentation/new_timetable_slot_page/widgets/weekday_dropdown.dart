import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

// Custom enum for bulk selection
enum WeekdaySelection {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  allWeekdays,
}

class WeekdayDropdown extends StatelessWidget {
  final ValueNotifier<Weekday?> selectedWeekday;
  final ValueNotifier<WeekdaySelection?> selectedWeekdayOption;

  const WeekdayDropdown({
    super.key, 
    required this.selectedWeekday,
    required this.selectedWeekdayOption,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<WeekdaySelection?>(
      valueListenable: selectedWeekdayOption,
      builder: (context, value, child) {
        return DropdownButtonFormField<WeekdaySelection>(
          value: value,
          decoration: const InputDecoration(
            labelText: 'Wochentag *',
            border: OutlineInputBorder(),
          ),
          items: [
            // Individual weekdays
            ...Weekday.values.map((weekday) {
              return DropdownMenuItem<WeekdaySelection>(
                value: _weekdayToSelection(weekday),
                child: Text(_getWeekdayName(weekday)),
              );
            }),
            // Bulk option
            const DropdownMenuItem<WeekdaySelection>(
              value: WeekdaySelection.allWeekdays,
              child: Text('Alle Wochentage (Bulk-Erstellung)'),
            ),
          ],
          onChanged: (WeekdaySelection? newValue) {
            selectedWeekdayOption.value = newValue;
            if (newValue != null && newValue != WeekdaySelection.allWeekdays) {
              selectedWeekday.value = _selectionToWeekday(newValue);
            } else {
              selectedWeekday.value = null;
            }
          },
          validator: (value) {
            if (value == null) {
              return 'Bitte wählen Sie einen Wochentag aus.';
            }
            return null;
          },
        );
      },
    );
  }

  WeekdaySelection _weekdayToSelection(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return WeekdaySelection.monday;
      case Weekday.tuesday:
        return WeekdaySelection.tuesday;
      case Weekday.wednesday:
        return WeekdaySelection.wednesday;
      case Weekday.thursday:
        return WeekdaySelection.thursday;
      case Weekday.friday:
        return WeekdaySelection.friday;
    }
  }

  Weekday _selectionToWeekday(WeekdaySelection selection) {
    switch (selection) {
      case WeekdaySelection.monday:
        return Weekday.monday;
      case WeekdaySelection.tuesday:
        return Weekday.tuesday;
      case WeekdaySelection.wednesday:
        return Weekday.wednesday;
      case WeekdaySelection.thursday:
        return Weekday.thursday;
      case WeekdaySelection.friday:
        return Weekday.friday;
      case WeekdaySelection.allWeekdays:
        return Weekday.monday; // Default, won't be used for bulk
    }
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
