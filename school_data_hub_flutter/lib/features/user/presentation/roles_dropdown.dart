import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class RolesDropdown extends StatelessWidget {
  final Role selectedRole;
  final Function changeRole;
  const RolesDropdown(
      {required this.selectedRole, required this.changeRole, super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Role>(
      value: selectedRole,
      hint: const Text(
        'Rolle auswählen',
        style: TextStyle(color: Colors.white),
      ),
      dropdownColor: Colors.grey[800],
      icon: const Icon(Icons.arrow_downward, color: Colors.white),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: const SizedBox.shrink(),
      onChanged: (Role? newValue) {
        changeRole(newValue);
      },
      items: Role.values.map<DropdownMenuItem<Role>>((Role role) {
        return DropdownMenuItem<Role>(
          value: role,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              role.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
