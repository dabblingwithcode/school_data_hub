import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/auth/auth_clearance_helper.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/core/updater/shorebird_update_manager.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_screen/widgets/settings_account_section.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_screen/widgets/settings_admin_section.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_screen/widgets/settings_session_section.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class SettingsScreen extends WatchingWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    watch(AppColors.paletteNotifier);
    final style = Style.of(context);
    final locale = AppLocalizations.of(context)!;

    final envManager = di<EnvManager>();

    final bool isAdmin = di<HubSessionManager>().isAdmin;
    final bool matrixPolicyManagerIsRegistered = watchPropertyValue(
      (HubSessionManager x) => x.matrixPolicyManagerRegistrationStatus,
    );
    final bool matrixSessionIsConfigured = watchPropertyValue(
      (HubSessionManager x) => x.isMatrixSessionConfigured,
    );
    final bool showMatrixLogs =
        isAdmin &&
        (matrixPolicyManagerIsRegistered || matrixSessionIsConfigured);

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppHeader(iconData: Icons.settings, title: locale.settings),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            children: [
              const SettingsAccountSection(),
              const SettingsSessionSection(),
              if (isAdmin) const SettingsAdminSection(),
              // Über die App
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Über die App',
                      style: context.typography.title,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Style.spacing.md,
                      vertical: Style.spacing.xs,
                    ),
                    child: CardBox(
                      padding: EdgeInsets.all(Style.spacing.sm),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.perm_device_info_rounded),
                            title: Text(
                              'Versionsnummer: ${envManager.packageInfo.version}',
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.build_rounded),
                            title: Text(
                              'Build: ${envManager.packageInfo.buildNumber}',
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.build_rounded),
                            title: Text(
                              'Patch level: ${di<ShorebirdUpdateManager>().currentPatch?.number.toString() ?? '0'}',
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.bug_report_rounded),
                            title: const Text('Logs'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push(RoutePaths.settingsLogs),
                          ),
                          if (AuthClearanceHelper.isAdmin())
                            ListTile(
                              leading: const Icon(Icons.dns_outlined),
                              title: const Text('Server-Logs'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () =>
                                  context.push(RoutePaths.settingsServerLogs),
                            ),
                          if (showMatrixLogs)
                            ListTile(
                              leading: const Icon(Icons.article_outlined),
                              title: const Text('Matrix-Corporal-Logs'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () async {
                                await di.getAsync<MatrixPolicyManager>();
                                if (!context.mounted) return;
                                context.push(
                                  RoutePaths.settingsMatrixCorporalLogs,
                                );
                              },
                            ),
                          ListTile(
                            leading: const Icon(Icons.account_tree_rounded),
                            title: const Text('Server-Datenmodell'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () =>
                                context.push(RoutePaths.settingsServerDiagram),
                          ),
                          ListTile(
                            leading: const Icon(Icons.info_rounded),
                            title: const Text('App Infos'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => showAboutDialog(
                              context: context,
                              applicationIcon: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Style.radii.medium,
                                ),
                                child: Image.asset(
                                  'assets/schuldaten_hub_logo.png',
                                  scale: 8,
                                ),
                              ),
                              applicationName: 'Schuldaten App',
                              applicationVersion:
                                  envManager.packageInfo.version,
                              applicationLegalese: '© 2025 Schuldaten Hub',
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.update_rounded),
                            title: const Text('App Updates überprüfen'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context
                                .push(RoutePaths.settingsShorebirdUpdate),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
