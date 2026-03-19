import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback? onDelete;
  final bool isEditing;

  const ActionButtons({
    super.key,
    required this.onSave,
    required this.onCancel,
    this.onDelete,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
          onPressed: onSave,
          label: isEditing ? 'Aktualisieren' : 'Erstellen',
        ),
        Gap(Style.spacing.lg),
        Button(
          onPressed: onCancel,
          label: 'Abbrechen',
          variant: ButtonVariant.secondary,
        ),
        if (isEditing && onDelete != null) ...[
          Gap(Style.spacing.lg),
          Button(
            onPressed: onDelete,
            label: 'Löschen',
            variant: ButtonVariant.destructive,
          ),
        ],
      ],
    );
  }
}
