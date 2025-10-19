import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class RolesDropdown extends StatelessWidget {
  final Role selectedRole;
  final Function changeRole;
  const RolesDropdown({
    required this.selectedRole,
    required this.changeRole,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<Role>(
        value: selectedRole,
        hint: Text(
          'Rolle auswählen',
          style: TextStyle(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
            fontSize: 16,
          ),
        ),
        dropdownColor: colorScheme.surface,
        icon: Icon(
          Icons.arrow_drop_down,
          color: colorScheme.onSurface,
          size: 24,
        ),
        elevation: 8,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        underline: const SizedBox.shrink(),
        onChanged: (Role? newValue) {
          changeRole(newValue);
        },
        items: Role.values.map<DropdownMenuItem<Role>>((Role role) {
          return DropdownMenuItem<Role>(
            value: role,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                role.name,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
