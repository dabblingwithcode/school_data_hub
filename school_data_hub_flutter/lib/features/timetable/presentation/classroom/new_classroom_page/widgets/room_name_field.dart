import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class RoomNameField extends StatelessWidget {
  final TextEditingController controller;

  const RoomNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: AppStyles.textFieldDecoration(labelText: 'Raumname'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie einen Raumnamen ein';
        }
        return null;
      },
    );
  }
}
