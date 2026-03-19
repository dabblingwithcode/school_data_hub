import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback? onDelete;

  const ActionButtons({
    super.key,
    required this.onSave,
    required this.onCancel,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
          label: 'SPEICHERN',
          onPressed: onSave,
        ),
        Gap(Style.spacing.lg),
        Button(
          label: 'ABBRECHEN',
          variant: ButtonVariant.secondary,
          onPressed: onCancel,
        ),
        if (onDelete != null) ...[
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
