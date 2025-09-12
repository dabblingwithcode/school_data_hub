import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class UserSelectionDropdown extends StatelessWidget {
  final User? selectedUser;
  final List<User> users;
  final Function(User?) onUserChanged;

  const UserSelectionDropdown({
    super.key,
    required this.selectedUser,
    required this.users,
    required this.onUserChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.backgroundColor, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<User>(
          value: selectedUser,
          hint: const Text('Benutzer auswählen...'),
          isExpanded: true,
          items:
              users.map((User user) {
                return DropdownMenuItem<User>(
                  value: user,
                  child: Text(
                    '${user.userInfo?.fullName ?? 'Unbekannt'} (${user.userInfo?.userName ?? 'N/A'})',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
          onChanged: onUserChanged,
        ),
      ),
    );
  }
}
