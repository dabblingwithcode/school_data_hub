import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

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
        ElevatedButton(
          style: AppStyles.successButtonStyle,
          onPressed: onSave,
          child: Text(
            isEditing ? 'AKTUALISIEREN' : 'ERSTELLEN',
            style: AppStyles.buttonTextStyle,
          ),
        ),
        const Gap(15),
        ElevatedButton(
          style: AppStyles.cancelButtonStyle,
          onPressed: onCancel,
          child: const Text('ABBRECHEN', style: AppStyles.buttonTextStyle),
        ),
        if (isEditing && onDelete != null) ...[
          const Gap(15),
          ElevatedButton(
            style: AppStyles.cancelButtonStyle.copyWith(
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
            onPressed: onDelete,
            child: const Text('LÖSCHEN', style: AppStyles.buttonTextStyle),
          ),
        ],
      ],
    );
  }
}
