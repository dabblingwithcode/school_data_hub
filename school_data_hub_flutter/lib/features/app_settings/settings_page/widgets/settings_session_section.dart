import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_page/dialogs/change_env_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper_functions.dart';
import 'package:watch_it/watch_it.dart';

final _sessionManager = di<ServerpodSessionManager>();
final _envManager = di<EnvManager>();
final _cacheManager = di<DefaultCacheManager>();
final _notificationService = di<NotificationService>();

class SettingsSessionSection extends AbstractSettingsSection with WatchItMixin {
  const SettingsSessionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    //final int credit = session.credit!;
    final String username = _sessionManager.signedInUser!.userName!;

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
          value: Text(
            _envManager.activeEnv!.serverName,
          ),
          trailing: null,
        ),
        SettingsTile.navigation(
          // onPressed: (context) =>
          //     di<PupilManager>().cleanPupilsAvatarIds(),
          leading: const Icon(
            Icons.account_circle_rounded,
          ),
          title: const Text('Angemeldet als'),
          value: Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: null,
        ),
        SettingsTile.navigation(
          // onPressed: (context) {
          //   Navigator.of(context).push(MaterialPageRoute(
          //     builder: (ctx) => const UserChangePasswordPage(),
          //   ));
          // },
          leading: const Icon(
            Icons.text_fields_rounded,
          ),
          title: const Text('Passwort ändern'),
          trailing: null,
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.attach_money_rounded),
          title: const Text('Guthaben'),
          value: Text(
            'nicht implementiert', // credit.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SettingsTile.navigation(
        //   leading: const Icon(Icons.punch_clock_rounded),
        //   title: const Text('Token gültig noch:'),
        //   value: Text(
        //     SessionHelper.tokenLifetimeLeft(session.jwt!).toString(),
        //     style: const TextStyle(
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        SettingsTile.navigation(
          onPressed: (context) async {
            // try {
            //   final String? password = await shortTextfieldDialog(
            //       context: context,
            //       title: 'Token erneuern',
            //       labelText: 'Passwort eingeben',
            //       hintText: 'Ihr Passwort hier eingeben',
            //       obscureText: true);
            //   if (password == null) {
            //     return;
            //   }
            //   await sessionManager.refreshToken(password);
            // } catch (e) {
            //   notificationService.showSnackBar(
            //       NotificationType.error, 'Unbekannter Fehler: $e');
            // }
          },
          leading: const Icon(Icons.password_rounded),
          title: const Text('Token erneuern'),
        ),
        SettingsTile.navigation(
          onPressed: (context) async {
            final confirm = await confirmationDialog(
                context: context,
                title: 'Ausloggen',
                message: 'Wirklich ausloggen?\n\nDaten bleiben erhalten!');
            if (confirm == true && context.mounted) {
              _sessionManager.signOutDevice();

              _notificationService.showSnackBar(
                  NotificationType.success, 'Erfolgreich ausgeloggt!');
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
                message: 'Kinder-Ids für diese Instanz löschen?');
            if (confirm == true && context.mounted) {
              PupilIdentityHelper.deletePupilIdentitiesForEnv(
                  _envManager.activeEnv!.serverName);
              _notificationService.showSnackBar(
                  NotificationType.success, 'ID-Schlüssel gelöscht');
            }
            return;
          },
        ),
        SettingsTile.navigation(
          leading: const Row(
            children: [
              Icon(Icons.key),
              Icon(Icons.delete_forever_outlined),
            ],
          ),
          title: const Text('Schul-Schlüssel löschen'),
          onPressed: (context) async {
            final confirm = await confirmationDialog(
                context: context,
                title: 'Instanz-ID-Schlüssel löschen',
                message: 'Instanz-ID-Schlüssel löschen?');
            if (confirm == true && context.mounted) {
              await _envManager.deleteEnv();
              _notificationService.showSnackBar(
                  NotificationType.success, 'Instanz-ID-Schlüssel gelöscht');

              await _cacheManager.emptyCache();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (ctx) => const Login(),
                  ),
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
                    message: 'Cached Bilder löschen?');
                if (confirm == true && context.mounted) {
                  await _cacheManager.emptyCache();
                  _notificationService.showSnackBar(NotificationType.success,
                      'der Bilder-Cache wurde gelöscht');
                }
                return;
              },
              child: const Row(
                children: [
                  Icon(Icons.logout),
                  Gap(5),
                  Icon(Icons.delete_forever_outlined)
                ],
              )),
          title: const Text('Cache löschen'),
          value: const Text('Lokal gespeicherte Bilder löschen'),
          //onPressed:
        ),
        SettingsTile.navigation(
          leading: GestureDetector(
              onTap: () async {
                bool? confirm = await confirmationDialog(
                    context: context,
                    title: 'Achtung!',
                    message: 'Ausloggen und alle Daten löschen?');
                if (confirm == true && context.mounted) {
                  SessionHelper.logoutAndDeleteAllInstanceData();
                }
                return;
              },
              child: const Row(
                children: [
                  Icon(Icons.logout),
                  Gap(5),
                  Icon(Icons.delete_forever_outlined)
                ],
              )),
          title: const Text('Ausloggen und Daten löschen'),
          value: const Text('App wird zurückgesetzt!'),
          //onPressed:
        ),
      ],
    );
  }
}
