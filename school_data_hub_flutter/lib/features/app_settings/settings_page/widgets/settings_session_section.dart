import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_page/dialogs/change_env_dialog.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

final _log = Logger('EnvManager');

class SettingsSessionSection extends WatchingWidget {
  const SettingsSessionSection({super.key});

  @override
  Widget build(BuildContext context) {
    callOnce((BuildContext context) async {
      await di.allReady();
    });

    final serverName = watchPropertyValue((EnvManager x) => x.activeEnv);
    final cacheManager = di<DefaultCacheManager>();

    final pupilIdentityManager = di.isRegistered<PupilIdentityManager>()
        ? di<PupilIdentityManager>()
        : null;
    final remoteUpdate = pupilIdentityManager?.remoteLastIdentitiesUpdate.value;

    final notificationService = di<NotificationManager>();

    final locale = AppLocalizations.of(context)!;
    final hubSessionManager = di<HubSessionManager>();

    final activeEnv = serverName;
    final activeSchemeKey = appColorSchemeKeyFromString(
      activeEnv?.colorSchemeKey,
    );
    final palettes = AppColors.availablePalettes();
    final currentPalette = palettes.firstWhere(
      (palette) => palette.key == activeSchemeKey,
      orElse: () => palettes.first,
    );

    Future<void> openColorSchemePicker() async {
      var tempSelection = activeSchemeKey;
      final selected = await showDialog<AppColorSchemeKey>(
        context: context,
        builder: (ctx) => StatefulBuilder(
          builder: (ctx, setState) => AlertDialog(
            title: const Text(
              'Farbschema wählen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              width: 360,
              child: RadioGroup<AppColorSchemeKey>(
                groupValue: tempSelection,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    tempSelection = value;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: palettes
                      .map(
                        (palette) => RadioListTile<AppColorSchemeKey>(
                          value: palette.key,
                          title: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: palette.backgroundColor,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              const Gap(10),
                              Text(palette.displayName),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Abbrechen'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(tempSelection),
                child: const Text('Speichern'),
              ),
            ],
          ),
        ),
      );

      if (selected == null) {
        return;
      }

      await di<EnvManager>().updateActiveEnv(colorSchemeKey: selected.name);
      AppColors.setPalette(selected);
      notificationService.showSnackBar(
        NotificationType.success,
        'Farbschema aktualisiert',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            locale.session,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.backgroundColor,
            ),
          ),
        ),
        Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Instanz:'),
                subtitle: Text(serverName!.serverName),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => changeEnvironmentDialog(context: context),
              ),
              ListTile(
                leading: const Icon(Icons.color_lens_outlined),
                title: const Text('Farbschema'),
                subtitle: Text(currentPalette.displayName),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => openColorSchemePicker(),
              ),
              if (hubSessionManager.isAdmin)
                ListTile(
                  leading: const Icon(Icons.http),
                  title: const Text('URL:'),
                  subtitle: Text(serverName.serverUrl),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => changeEnvironmentDialog(context: context),
                ),
              ListTile(
                leading: const Icon(Icons.perm_identity_rounded),
                title: const Text('Lokale Daten vom:'),
                subtitle: Text(
                  '${di<EnvManager>().activeEnv?.lastIdentitiesUpdate?.formatDateAndTimeForUser() ?? 'Keine Daten'} ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        di<EnvManager>().activeEnv?.lastIdentitiesUpdate ==
                                remoteUpdate ||
                            remoteUpdate != null &&
                                di<EnvManager>()
                                        .activeEnv
                                        ?.lastIdentitiesUpdate !=
                                    null &&
                                (di<EnvManager>()
                                        .activeEnv
                                        ?.lastIdentitiesUpdate!
                                        .isAfter(remoteUpdate) ==
                                    true)
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.perm_identity_rounded),
                title: const Text('Aktuelleste Daten vom:'),
                subtitle: Text('${remoteUpdate?.formatDateAndTimeForUser()}'),
              ),
              ListTile(
                leading: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.perm_contact_cal_rounded),
                    Icon(Icons.delete_forever_outlined),
                  ],
                ),
                title: const Text('gespeicherte Identitäten löschen'),
                onTap: () async {
                  final confirm = await confirmationDialog(
                    context: context,
                    title: 'Lokale Kinder-Ids löschen',
                    message: 'Kinder-Ids für diese Instanz löschen?',
                  );
                  if (confirm == true && context.mounted) {
                    PupilIdentityHelper.deletePupilIdentitiesForEnv(
                      di<EnvManager>().storageKeyForPupilIdentities,
                    );
                    notificationService.showSnackBar(
                      NotificationType.success,
                      'Kinder-Ids gelöscht',
                    );
                  }
                },
              ),
              ListTile(
                leading: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.key),
                    Icon(Icons.delete_forever_outlined),
                  ],
                ),
                title: const Text('Schul-Schlüssel löschen'),
                subtitle: const Text('Nur Instanz-ID löschen'),
                onTap: () async {
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
                    notificationService.showSnackBar(
                      NotificationType.success,
                      'Instanz-ID-Schlüssel gelöscht',
                    );

                    await cacheManager.emptyCache();
                    if (context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute<void>(
                          builder: (ctx) => const Login(),
                        ),
                        (route) => false,
                      );
                    }
                  }
                },
              ),
              ListTile(
                leading: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image),
                    Gap(5),
                    Icon(Icons.delete_forever_outlined),
                  ],
                ),
                title: const Text('Bilder-Cache löschen'),
                onTap: () async {
                  bool? confirm = await confirmationDialog(
                    context: context,
                    title: 'Bilder-Cache löschen',
                    message: 'Cached Bilder löschen?',
                  );
                  if (confirm == true && context.mounted) {
                    await cacheManager.emptyCache();
                    notificationService.showSnackBar(
                      NotificationType.success,
                      'der Bilder-Cache wurde gelöscht',
                    );
                  }
                },
              ),
              ListTile(
                leading: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout),
                    Gap(5),
                    Icon(Icons.delete_forever_outlined),
                  ],
                ),
                title: const Text('Ausloggen und Daten löschen'),
                subtitle: const Text('App wird zurückgesetzt!'),
                onTap: () async {
                  bool? confirm = await confirmationDialog(
                    context: context,
                    title: 'Achtung!',
                    message: 'Ausloggen und alle Daten löschen?',
                  );
                  if (confirm == true && context.mounted) {
                    SessionHelper.logoutAndDeleteAllInstanceData();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Ausloggen'),
                subtitle: const Text('Daten bleiben erhalten'),
                onTap: () async {
                  final confirm = await confirmationDialog(
                    context: context,
                    title: 'Ausloggen',
                    message: 'Wirklich ausloggen?\n\nDaten bleiben erhalten!',
                  );
                  if (confirm == true && context.mounted) {
                    di<HubSessionManager>().signOutDevice();

                    notificationService.showSnackBar(
                      NotificationType.success,
                      'Erfolgreich ausgeloggt!',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
