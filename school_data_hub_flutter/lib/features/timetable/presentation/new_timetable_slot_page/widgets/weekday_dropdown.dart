import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class WeekdayDropdown extends StatelessWidget {
  final ValueNotifier<Weekday?> selectedWeekday;

  const WeekdayDropdown({super.key, required this.selectedWeekday});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Weekday?>(
      valueListenable: selectedWeekday,
      builder: (context, value, child) {
        return DropdownButtonFormField<Weekday>(
          value: value,
          decoration: const InputDecoration(
            labelText: 'Wochentag *',
            border: OutlineInputBorder(),
          ),
          items:
              Weekday.values.map((weekday) {
                return DropdownMenuItem<Weekday>(
                  value: weekday,
                  child: Text(_getWeekdayName(weekday)),
                );
              }).toList(),
          onChanged: (Weekday? newValue) {
            selectedWeekday.value = newValue;
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
