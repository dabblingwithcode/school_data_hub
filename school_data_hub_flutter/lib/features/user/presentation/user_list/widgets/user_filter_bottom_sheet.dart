import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class UserFilterBottomSheet extends StatelessWidget {
  final Role? selectedRole;
  final ValueChanged<Role?> onRoleChanged;
  final VoidCallback onReset;

  const UserFilterBottomSheet({
    required this.selectedRole,
    required this.onRoleChanged,
    required this.onReset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Padding(
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Benutzer filtern',
            style: context.typography.title,
          ),
          const Gap(12),
          Text('Rolle', style: context.typography.body),
          const Gap(8),
          Wrap(
            spacing: Style.spacing.sm,
            runSpacing: Style.spacing.sm,
            children: [
              ChoiceChip(
                label: const Text('Alle'),
                selected: selectedRole == null,
                onSelected: (_) => onRoleChanged(null),
              ),
              for (final role in Role.values)
                ChoiceChip(
                  label: Text(role.name),
                  selected: selectedRole == role,
                  onSelected: (_) => onRoleChanged(role),
                ),
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onReset,
                child: Text(
                  'Zurücksetzen',
                  style: context.typography.body
                      .withColor(style.colors.button.link),
                ),
              ),
              const Gap(8),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  'Fertig',
                  style: context.typography.body.bold
                      .withColor(style.colors.accent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
