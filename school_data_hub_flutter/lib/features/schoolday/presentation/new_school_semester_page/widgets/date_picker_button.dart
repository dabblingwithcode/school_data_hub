import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';

class DatePickerButton extends StatelessWidget {
  final DateTime? dateToSelect;
  final Function(DateTime? pickedDate) onDateSelected;
  const DatePickerButton({
    required this.dateToSelect,
    required this.onDateSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: dateToSelect ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (selectedDate != null && selectedDate != dateToSelect) {
          onDateSelected(selectedDate);
        }
      },
      child: Text(
        dateToSelect != null
            ? dateToSelect!.formatForUser()
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
