import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class ActionButtons extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback? onDelete;

  const ActionButtons({
    super.key,
    required this.isEditing,
    required this.onSave,
    required this.onCancel,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
          label: isEditing ? 'AKTUALISIEREN' : 'ERSTELLEN',
          onPressed: onSave,
        ),
        Gap(Style.spacing.lg),
        Button(
          label: 'ABBRECHEN',
          variant: ButtonVariant.secondary,
          onPressed: onCancel,
        ),
        if (isEditing && onDelete != null) ...[
          Gap(Style.spacing.lg),
          Button(
            label: 'LÖSCHEN',
            variant: ButtonVariant.destructive,
            onPressed: onDelete,
          ),
        ],
      ],
    );
  }
}
