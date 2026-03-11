import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

class DatePickerButton extends StatelessWidget {
  final DateTime? dateToSelect;
  final void Function(DateTime? pickedDate) onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool Function(DateTime day)? selectableDayPredicate;
  const DatePickerButton({
    required this.dateToSelect,
    required this.onDateSelected,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    super.key,
  });

  DateTime? _findNearestSelectableDate({
    required DateTime preferred,
    required DateTime firstDate,
    required DateTime lastDate,
    required bool Function(DateTime day) predicate,
  }) {
    if (preferred.isBefore(firstDate)) preferred = firstDate;
    if (preferred.isAfter(lastDate)) preferred = lastDate;

    if (predicate(preferred)) return preferred;

    // Try scanning forward first.
    for (DateTime d = preferred.add(const Duration(days: 1));
        !d.isAfter(lastDate);
        d = d.add(const Duration(days: 1))) {
      if (predicate(d)) return d;
    }

    // Then scan backwards.
    for (DateTime d = preferred.subtract(const Duration(days: 1));
        !d.isBefore(firstDate);
        d = d.subtract(const Duration(days: 1))) {
      if (predicate(d)) return d;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveFirstDate = firstDate ?? DateTime(2000);
    final effectiveLastDate = lastDate ?? DateTime(2101);

    return GestureDetector(
      onTap: () async {
        DateTime preferredInitialDate = dateToSelect ?? DateTime.now();
        if (preferredInitialDate.isBefore(effectiveFirstDate)) {
          preferredInitialDate = effectiveFirstDate;
        }
        if (preferredInitialDate.isAfter(effectiveLastDate)) {
          preferredInitialDate = effectiveLastDate;
        }

        final initialDate = selectableDayPredicate == null
            ? preferredInitialDate
            : _findNearestSelectableDate(
                preferred: preferredInitialDate,
                firstDate: effectiveFirstDate,
                lastDate: effectiveLastDate,
                predicate: selectableDayPredicate!,
              );

        if (initialDate == null) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Keine auswählbaren Termine verfügbar'),
            ),
          );
          return;
        }

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: effectiveFirstDate,
          lastDate: effectiveLastDate,
          selectableDayPredicate: selectableDayPredicate,
        );
        if (selectedDate != null && selectedDate != dateToSelect) {
          onDateSelected(selectedDate);
        }
      },
      child: Text(
        dateToSelect != null
            ? dateToSelect!.formatDateForUser()
            : 'Bitte auswählen',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
