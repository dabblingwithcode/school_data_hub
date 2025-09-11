import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

/// Text field widget for entering lesson group name
class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: AppStyles.textFieldDecoration(labelText: 'Klassenname'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie einen Klassennamen ein';
        }
        return null;
      },
    );
  }
}
