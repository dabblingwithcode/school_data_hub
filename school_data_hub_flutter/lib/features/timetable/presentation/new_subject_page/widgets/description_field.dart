import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Beschreibung',
        hintText: 'z.B. Grundlegende Mathematik',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      inputFormatters: [LengthLimitingTextInputFormatter(500)],
    );
  }
}
