import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

Future<DateTime?> selectSchooldayDate(
  BuildContext context,
  DateTime thisDate,
) async {
  List<DateTime> availableDates =
      di<SchoolCalendarManager>().availableDates.value;

  bool isSelectableSchoolday(DateTime day) {
    final validDate = availableDates.any((date) => date.isSameDate(day));
    return validDate;
  }

  // If the provided date is not a valid school day, find the nearest one
  DateTime initialDate = thisDate;
  if (!isSelectableSchoolday(initialDate) && availableDates.isNotEmpty) {
    // Find the nearest available date
    availableDates.sort(
      (a, b) => (a.difference(thisDate).inDays.abs()).compareTo(
        b.difference(thisDate).inDays.abs(),
      ),
    );
    initialDate = availableDates.first;
  }

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    selectableDayPredicate: isSelectableSchoolday,
    firstDate: DateTime.now().toUtc().subtract(const Duration(days: 365)),
    lastDate: DateTime.now().toUtc().toUtc().add(const Duration(days: 365)),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.backgroundColor,
            onPrimary: const Color.fromARGB(255, 241, 241, 241),
            onSurface: Colors.deepPurple,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.accentColor, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  if (pickedDate != null) {
    return pickedDate;
  }
  return null;
}
