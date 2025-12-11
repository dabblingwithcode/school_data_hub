import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/change_password/change_password_page.dart';
import 'package:watch_it/watch_it.dart';

class SettingsAccountSection extends AbstractSettingsSection with WatchItMixin {
  const SettingsAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    di.allReady();

    final String username = watchPropertyValue(
      (HubSessionManager x) => x.user,
    )!.userInfo!.userName!;
    final isTester = di<HubSessionManager>().user!.userFlags.isTester;
    final isAdmin = di<HubSessionManager>().isAdmin;
    final int userCredit = di<HubSessionManager>().userCredit ?? 0;
    return SettingsSection(
      title: const Text(
        'Konto',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      tiles: <SettingsTile>[
        SettingsTile.navigation(
          // onPressed: (context) =>
          //     di<PupilManager>().cleanPupilsAvatarIds(),
          leading: const Icon(Icons.account_circle_rounded),
          title: const Text('Benutzername'),
          value: Text(
            username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: null,
        ),
        SettingsTile(
          leading: const Icon(Icons.build_rounded),
          title: Text(
            'Tester: ${isTester ? "Ja" : "Nein"}  |  Admin: ${isAdmin ? "Ja" : "Nein"}',
          ),
        ),

        SettingsTile.navigation(
          onPressed: (context) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const UserChangePasswordPage(),
              ),
            );
          },
          leading: const Icon(Icons.password_rounded),
          title: const Text('Passwort ändern'),
          trailing: null,
        ),

        SettingsTile.navigation(
          leading: const Icon(Icons.attach_money_rounded),
          title: const Text('Guthaben'),
          value: Text(
            userCredit.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
