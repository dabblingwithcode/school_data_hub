import 'package:flutter/widgets.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/picker.dart';

class UserSelectionDropdown extends StatelessWidget {
  final User? selectedUser;
  final List<User> users;
  final void Function(User?) onUserChanged;

  const UserSelectionDropdown({
    super.key,
    required this.selectedUser,
    required this.users,
    required this.onUserChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Picker<User>(
      label: 'Benutzer auswählen',
      value: selectedUser,
      items: users,
      itemLabel: (user) =>
          '${user.userInfo?.fullName ?? 'Unbekannt'} (${user.userInfo?.userName ?? 'N/A'})',
      onChanged: (user) => onUserChanged(user),
    );
  }
}
