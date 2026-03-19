import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(Style.spacing.sm),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Style.radii.small),
        ),
        labelText: 'Stundenplan Name',
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie einen Namen für den Stundenplan ein';
        }
        return null;
      },
    );
  }
}
