import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

/// Action buttons widget for the lesson form
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
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onSave,
                style: AppStyles.successButtonStyle,

                child: Text(
                  isEditing ? 'SPEICHERN' : 'ERSTELLEN',
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: onCancel,
                style: AppStyles.cancelButtonStyle,

                child: const Text(
                  'ABBRECHEN',
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ),
          ],
        ),
        if (isEditing && onDelete != null) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onDelete,
              style: AppStyles.cancelButtonStyle,
              child: const Text('LÖSCHEN', style: AppStyles.buttonTextStyle),
            ),
          ),
        ],
      ],
    );
  }
}
