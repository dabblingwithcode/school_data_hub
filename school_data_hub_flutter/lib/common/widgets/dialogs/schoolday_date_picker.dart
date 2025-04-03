import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

import 'package:watch_it/watch_it.dart';

Future<DateTime?> selectSchooldayDate(
    BuildContext context, DateTime thisDate) async {
  List<DateTime> availableDates = di<SchooldayManager>().availableDates.value;

  bool isSelectableSchoolday(DateTime day) {
    final validDate = availableDates.contains(day);
    return validDate;
  }

  if (!availableDates.contains(thisDate)) {
    thisDate = availableDates.last;
  }
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: thisDate,
    selectableDayPredicate: isSelectableSchoolday,
    firstDate: DateTime.now().subtract(const Duration(days: 365)),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    builder: (context, child) {
      return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.backgroundColor,
              onPrimary: Color.fromARGB(255, 241, 241, 241),
              onSurface: Colors.deepPurple,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accentColor, // button text color
              ),
            ),
          ),
          child: child!);
    },
  );
  if (pickedDate != null) {
    return pickedDate;
  }
  return null;
}
