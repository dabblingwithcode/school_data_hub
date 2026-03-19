import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        labelText: 'Name *',
        hintText: 'z.B. Mathematik',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Style.radii.small),
        ),
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(100)],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie einen Namen ein';
        }
        return null;
      },
    );
  }
}
