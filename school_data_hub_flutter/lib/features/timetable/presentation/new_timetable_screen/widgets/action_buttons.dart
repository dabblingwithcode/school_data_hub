import 'package:flutter/widgets.dart';
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
          onPressed: onSave,
          label: isEditing ? 'AKTUALISIEREN' : 'ERSTELLEN',
        ),
        Gap(Style.spacing.lg),
        Button(
          onPressed: onCancel,
          label: 'ABBRECHEN',
          variant: ButtonVariant.secondary,
        ),
        if (isEditing && onDelete != null) ...[
          Gap(Style.spacing.lg),
          Button(
            onPressed: onDelete,
            label: 'LÖSCHEN',
            variant: ButtonVariant.destructive,
          ),
        ],
      ],
    );
  }
}
