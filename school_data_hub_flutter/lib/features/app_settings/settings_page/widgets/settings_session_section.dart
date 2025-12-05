import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_page/dialogs/change_env_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('EnvManager');

class SettingsSessionSection extends AbstractSettingsSection with WatchItMixin {
  const SettingsSessionSection({super.key});

  @override
  Widget build(BuildContext context) {
    di.allReady();
    final serverName = watchPropertyValue((EnvManager x) => x.activeEnv);
    final _cacheManager = di<DefaultCacheManager>();

    final _notificationService = di<NotificationService>();

    final locale = AppLocalizations.of(context)!;
    final _hubSessionManager = di<HubSessionManager>();
    final int userCredit = _hubSessionManager.userCredit ?? 0;

    return SettingsSection(
      title: Text(
        locale.session,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      tiles: <SettingsTile>[
        SettingsTile.navigation(
          onPressed: (context) => changeEnvironmentDialog(context: context),
          leading: const Icon(Icons.home),
          title: const Text('Instanz:'),
          value: Text(serverName!.serverName),
          trailing: null,
        ),
        if (_hubSessionManager.isAdmin)
          SettingsTile.navigation(
            onPressed: (context) => changeEnvironmentDialog(context: context),
            leading: const Icon(Icons.http),
            title: const Text('URL:'),
            value: Text(serverName.serverUrl),
            trailing: null,
          ),

        SettingsTile.navigation(
          leading: const Icon(Icons.perm_identity_rounded),
          title: const Text('Lokale Daten vom:'),
          value: Text(
            '${di<EnvManager>().activeEnv?.lastIdentitiesUpdate?.formatDateAndTimeForUser()} ',
            style: TextStyle(
              color:
                  di<EnvManager>().activeEnv?.lastIdentitiesUpdate ==
                      di<PupilIdentityManager>()
                          .remoteLastIdentitiesUpdate
                          .value
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          trailing: null,
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.perm_identity_rounded),
          title: const Text('Aktuelleste Daten vom:'),
          value: Text(
            '${di<PupilIdentityManager>().remoteLastIdentitiesUpdate.value?.formatDateAndTimeForUser()}',
          ),
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

        SettingsTile.navigation(
          onPressed: (context) async {
            final confirm = await confirmationDialog(
              context: context,
              title: 'Ausloggen',
              message: 'Wirklich ausloggen?\n\nDaten bleiben erhalten!',
            );
            if (confirm == true && context.mounted) {
              di<HubSessionManager>().signOutDevice();

              _notificationService.showSnackBar(
                NotificationType.success,
                'Erfolgreich ausgeloggt!',
              );
            }
          },
          leading: const Icon(Icons.logout),
          title: const Text('Ausloggen'),
          description: const Text('Daten bleiben erhalten'),

          //onPressed:
        ),
        SettingsTile.navigation(
          leading: const Row(
            children: [
              Icon(Icons.perm_contact_cal_rounded),
              Icon(Icons.delete_forever_outlined),
            ],
          ),
          title: const Text('gespeicherte Identitäten löschen'),
          onPressed: (context) async {
            final confirm = await confirmationDialog(
              context: context,
              title: 'Lokale Kinder-Ids löschen',
              message: 'Kinder-Ids für diese Instanz löschen?',
            );
            if (confirm == true && context.mounted) {
              PupilIdentityHelper.deletePupilIdentitiesForEnv(
                di<EnvManager>().storageKeyForPupilIdentities,
              );
              _notificationService.showSnackBar(
                NotificationType.success,
                'Kinder-Ids gelöscht',
              );
            }
            return;
          },
        ),
        SettingsTile.navigation(
          leading: const Row(
            children: [Icon(Icons.key), Icon(Icons.delete_forever_outlined)],
          ),
          title: const Text('Schul-Schlüssel löschen'),
          onPressed: (context) async {
            final confirm = await confirmationDialog(
              context: context,
              title: 'Instanz-ID-Schlüssel löschen',
              message: 'Instanz-ID-Schlüssel löschen?',
            );
            if (confirm == true && context.mounted) {
              _log.warning('[DI] Hang on tight, signing out! ');
              await di<EnvManager>().deleteEnv();
              di<HubSessionManager>().signOutDevice();
              _log.warning(
                '[DI] Env deleted, calling [unregisterMaagersDependentOnEnv] from the settings section!',
              );
              InitManager.dropAllScopes();
              _notificationService.showSnackBar(
                NotificationType.success,
                'Instanz-ID-Schlüssel gelöscht',
              );

              await _cacheManager.emptyCache();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const Login()),
                  (route) => false,
                );
              }
            }
            return;

            //di<SessionManager>().logout();
          },
          value: const Text('Nur Instanz-ID löschen'),
          //onPressed:
        ),
        SettingsTile.navigation(
          leading: GestureDetector(
            onTap: () async {
              bool? confirm = await confirmationDialog(
                context: context,
                title: 'Bilder-Cache löschen',
                message: 'Cached Bilder löschen?',
              );
              if (confirm == true && context.mounted) {
                await _cacheManager.emptyCache();
                _notificationService.showSnackBar(
                  NotificationType.success,
                  'der Bilder-Cache wurde gelöscht',
                );
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
          title: const Text('Lokal gespeicherte Bilder löschen'),

          //onPressed:
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
