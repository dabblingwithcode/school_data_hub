import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Name *',
        hintText: 'z.B. 1. Stunde, Frühstückspause',
        border: OutlineInputBorder(),
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(50)],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie einen Namen ein.';
        }
        return null;
      },
    );
  }
}
