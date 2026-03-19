import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(Style.spacing.sm),
        labelText: 'Beschreibung',
        hintText: 'z.B. Grundlegende Mathematik',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Style.radii.small),
        ),
      ),
      maxLines: 3,
      inputFormatters: [LengthLimitingTextInputFormatter(500)],
    );
  }
}
