import 'package:flutter/material.dart';

/// Text field widget for entering lesson ID
class LessonIdField extends StatelessWidget {
  final TextEditingController controller;

  const LessonIdField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Stunden-ID',
        border: OutlineInputBorder(),
        hintText: 'z.B. L1_MONDAY',
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie eine Stunden-ID ein';
        }
        return null;
      },
    );
  }
}
