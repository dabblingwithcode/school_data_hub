import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

class StartDateField extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<DateTime?> selectedDate;

  const StartDateField({
    super.key,
    required this.controller,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final schoolCalendarManager = di<SchoolCalendarManager>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Startdatum *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await _showSchooldayDatePicker(
              context,
              _getInitialDate(),
              schoolCalendarManager,
            );
            if (pickedDate != null) {
              selectedDate.value = pickedDate;
              controller.text = pickedDate.formatDateForUser();
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.text.isNotEmpty
                        ? controller.text
                        : 'Bitte auswählen',
                    style: TextStyle(
                      color: controller.text.isNotEmpty
                          ? Colors.black
                          : Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: AppColors.accentColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (controller.text.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Bitte geben Sie ein Startdatum ein',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  DateTime _getInitialDate() {
    if (controller.text.isNotEmpty) {
      try {
        final parts = controller.text.split('.');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      } catch (e) {
        // If parsing fails, use current date
      }
    }
    return DateTime.now();
  }

  Future<DateTime?> _showSchooldayDatePicker(
    BuildContext context,
    DateTime initialDate,
    SchoolCalendarManager schoolCalendarManager,
  ) async {
    List<DateTime> availableDates = schoolCalendarManager.availableDates.value;

    bool isSelectableSchoolday(DateTime day) {
      final validDate = availableDates.any((date) => date.isSameDate(day));
      return validDate;
    }

    // Find a valid initial date that satisfies the predicate
    DateTime validInitialDate = initialDate;
    if (!isSelectableSchoolday(initialDate)) {
      // Try to find the closest valid schoolday
      if (availableDates.isNotEmpty) {
        // Find the closest date to the initial date
        availableDates.sort(
          (a, b) => (a.difference(initialDate).abs()).compareTo(
            b.difference(initialDate).abs(),
          ),
        );
        validInitialDate = availableDates.first;
      } else {
        // Fallback to today if no available dates
        validInitialDate = DateTime.now();
      }
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: validInitialDate,
      selectableDayPredicate: isSelectableSchoolday,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
                foregroundColor: AppColors.accentColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    return pickedDate;
  }
}
