import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PublicIdField extends StatelessWidget {
  final TextEditingController controller;

  const PublicIdField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Öffentliche ID *',
        hintText: 'z.B. MATH001',
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          return TextEditingValue(
            text: newValue.text.toUpperCase(),
            selection: newValue.selection,
          );
        }),
      ],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie eine öffentliche ID ein';
        }
        return null;
      },
    );
  }
}
