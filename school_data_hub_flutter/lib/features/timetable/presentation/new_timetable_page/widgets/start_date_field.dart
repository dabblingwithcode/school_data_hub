import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class StartDateField extends StatelessWidget {
  final TextEditingController controller;

  const StartDateField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: AppStyles.textFieldDecoration(labelText: 'Startdatum (DD.MM.YYYY)'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie ein Startdatum ein';
        }
        
        // Validate date format
        final parts = value.split('.');
        if (parts.length != 3) {
          return 'Bitte verwenden Sie das Format DD.MM.YYYY';
        }
        
        try {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          
          if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1900 || year > 2100) {
            return 'Bitte geben Sie ein gültiges Datum ein';
          }
        } catch (e) {
          return 'Bitte geben Sie ein gültiges Datum ein';
        }
        
        return null;
      },
    );
  }
}
