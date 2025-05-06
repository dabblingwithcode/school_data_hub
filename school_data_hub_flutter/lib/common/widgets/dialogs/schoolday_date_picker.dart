import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schooldayManager = di<SchooldayManager>();

Future<DateTime?> selectSchooldayDate(
    BuildContext context, DateTime thisDate) async {
  List<DateTime> availableDates = _schooldayManager.availableDates.value;

  bool isSelectableSchoolday(DateTime day) {
    final validDate = availableDates.any((date) => date.isSameDate(day));
    return validDate;
  }

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: thisDate,
    selectableDayPredicate: isSelectableSchoolday,
    firstDate: DateTime.now().toUtc().subtract(const Duration(days: 365)),
    lastDate: DateTime.now().toUtc().toUtc().add(const Duration(days: 365)),
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
