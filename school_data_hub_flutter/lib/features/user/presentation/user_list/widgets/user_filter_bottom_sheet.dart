import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Benutzer filtern',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(12),
          const Text('Rolle'),
          const Gap(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
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
              TextButton(onPressed: onReset, child: const Text('Zurücksetzen')),
              const Gap(8),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fertig'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
