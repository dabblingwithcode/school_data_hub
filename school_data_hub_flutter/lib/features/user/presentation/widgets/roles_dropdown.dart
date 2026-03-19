import 'package:flutter/widgets.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/picker.dart';

/// Display labels for [Role] in the UI (German).
const Map<Role, String> _roleLabels = {
  Role.admin: 'Admin',
  Role.teacher: 'Lehrkraft',
  Role.specialEducator: 'SoPäd.',
  Role.specialEducatorE: 'SoFa',
  Role.specialEducatorK: 'MPT',
  Role.educator: 'Päd. Personal',
  Role.trainee: 'Praktikant*in',
  Role.afterSchoolCare: 'OGS-Personal',
  Role.socialWorker: 'Schulsozialarbeit',
  Role.notAssigned: 'Nicht zugewiesen',
};

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
    return Picker<Role>(
      label: 'Rolle auswählen',
      value: selectedRole,
      items: Role.values,
      itemLabel: (role) => _roleLabels[role] ?? role.name,
      onChanged: (Role newValue) {
        changeRole(newValue);
      },
    );
  }
}
