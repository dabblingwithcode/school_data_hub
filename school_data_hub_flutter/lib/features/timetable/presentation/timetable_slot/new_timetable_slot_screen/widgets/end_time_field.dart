import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EndTimeField extends StatelessWidget {
  final TextEditingController controller;

  const EndTimeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Endzeit *',
        hintText: 'HH:MM (z.B. 08:45)',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.access_time),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9:]')),
        LengthLimitingTextInputFormatter(5),
      ],
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie eine Endzeit ein.';
        }
        if (!RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$').hasMatch(value)) {
          return 'Bitte geben Sie eine gültige Zeit im Format HH:MM ein.';
        }
        return null;
      },
    );
  }
}
