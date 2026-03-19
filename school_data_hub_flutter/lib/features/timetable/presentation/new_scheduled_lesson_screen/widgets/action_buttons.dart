import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

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
              child: Button(
                label: isEditing ? 'SPEICHERN' : 'ERSTELLEN',
                onPressed: onSave,
              ),
            ),
            Gap(Style.spacing.lg),
            Expanded(
              child: Button(
                label: 'ABBRECHEN',
                variant: ButtonVariant.secondary,
                onPressed: onCancel,
              ),
            ),
          ],
        ),
        if (isEditing && onDelete != null) ...[
          Gap(Style.spacing.lg),
          SizedBox(
            width: double.infinity,
            child: Button(
              label: 'LÖSCHEN',
              variant: ButtonVariant.destructive,
              onPressed: onDelete,
            ),
          ),
        ],
        Gap(Style.spacing.xl),
      ],
    );
  }
}
