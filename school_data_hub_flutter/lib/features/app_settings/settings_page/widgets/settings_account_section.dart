import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:watch_it/watch_it.dart';

class SettingsAccountSection extends AbstractSettingsSection with WatchItMixin {
  const SettingsAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    di.allReady();
    final serverName = watchPropertyValue((EnvManager x) => x.activeEnv);
    final _cacheManager = di<DefaultCacheManager>();

    final _notificationService = di<NotificationService>();

    final locale = AppLocalizations.of(context)!;

    final String username =
        watchPropertyValue(
          (HubSessionManager x) => x.user,
        )!.userInfo!.userName!;
    final isTester = di<HubSessionManager>().user!.userFlags.isTester;
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
        if (isTester)
          SettingsTile.navigation(
            // onPressed: (context) {
            //   Navigator.of(context).push(MaterialPageRoute(
            //     builder: (ctx) => const UserChangePasswordPage(),
            //   ));
            // },
            leading: const Icon(Icons.password_rounded),
            title: const Text('Passwort ändern (noch nicht freigeschaltet)'),
            trailing: null,
          ),

        SettingsTile.navigation(
          leading: GestureDetector(
            onTap: () async {
              bool? confirm = await confirmationDialog(
                context: context,
                title: 'Achtung!',
                message: 'Ausloggen und alle Daten löschen?',
              );
              if (confirm == true && context.mounted) {
                SessionHelper.logoutAndDeleteAllInstanceData();
              }
              return;
            },
            child: const Row(
              children: [
                Icon(Icons.logout),
                Gap(5),
                Icon(Icons.delete_forever_outlined),
              ],
            ),
          ),
          title: const Text('Ausloggen und Daten löschen'),
          value: const Text('App wird zurückgesetzt!'),
          //onPressed:
        ),
      ],
    );
  }
}
