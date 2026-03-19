import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:flutter_it/flutter_it.dart';

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
    final style = Style.of(context);
    final schoolCalendarManager = di<SchoolCalendarManager>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Startdatum *',
          style: context.typography.subtitle,
        ),
        Gap(Style.spacing.sm),
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
            padding: EdgeInsets.symmetric(
              horizontal: Style.spacing.md,
              vertical: Style.spacing.lg,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: style.colors.border),
              borderRadius: BorderRadius.circular(Style.radii.small),
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
                          ? style.colors.foreground
                          : style.colors.mutedForeground,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: style.colors.accent,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (controller.text.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: Style.spacing.xs),
            child: Text(
              'Bitte geben Sie ein Startdatum ein',
              style: context.typography.bodySmall
                  .withColor(style.colors.error),
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
    final style = Style.of(context);
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
              primary: style.colors.accent,
              onPrimary: style.colors.background,
              onSurface: Colors.deepPurple,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: style.colors.accent,
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
