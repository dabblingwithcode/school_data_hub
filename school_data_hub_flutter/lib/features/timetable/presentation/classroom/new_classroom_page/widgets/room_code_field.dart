import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class RoomCodeField extends StatelessWidget {
  final TextEditingController controller;

  const RoomCodeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: AppStyles.textFieldDecoration(labelText: 'Raumcode'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie einen Raumcode ein';
        }
        return null;
      },
    );
  }
}
