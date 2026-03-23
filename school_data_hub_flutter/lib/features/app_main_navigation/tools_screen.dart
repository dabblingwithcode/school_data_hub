import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/pupil_identity_file_import.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/qr/qr_utilites.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';

class ToolsScreen extends WatchingWidget {
  const ToolsScreen({super.key});

  PupilIdentityManager get _pupilIdentityManager => di<PupilIdentityManager>();
  HubSessionManager get _hubSessionManager => di<HubSessionManager>();

  void _importUnencryptedPupilIdentitySourceFile(String function) async {
    final fileContent = await pickPupilIdentityFileContent();
    if (fileContent == null) return;

    if (function == 'update_backend') {
      _pupilIdentityManager.updateServerFromPupilIdentityExternalSource(
        fileContent,
      );
    } else if (function == 'pupil_identities') {
      _pupilIdentityManager.updatePupilIdentitiesFromUnencryptedSource(
        updateTimestamp: null,
        pupilIdentityTextLines: fileContent,
      );
    }
  }

  void _showSectionOverlay({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final style = Style.of(context);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: style.colors.canvas,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Style.radii.large),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Style.spacing.lg,
              Style.spacing.sm,
              Style.spacing.lg,
              Style.spacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  margin: EdgeInsets.only(bottom: Style.spacing.lg),
                  decoration: BoxDecoration(
                    color: style.colors.mutedForeground,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 24, color: style.colors.accent),
                    const Gap(8),
                    Text(title, style: context.typography.title),
                  ],
                ),
                const Gap(16),
                // Sub-buttons grid
                Wrap(alignment: WrapAlignment.center, children: children),
                const Gap(8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final matrixSessionConfigured = watchPropertyValue(
      (HubSessionManager x) => x.isMatrixSessionConfigured,
    );

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      appBar: const AppHeader(iconData: Icons.build_rounded, title: 'Tools'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = Platform.isWindows
              ? 700.0
              : math.min(600.0, constraints.maxWidth);
          final height = Platform.isWindows
              ? 600.0
              : constraints.maxHeight * 0.9;
          return Center(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    // --- Schüler-Ids ---
                    MainMenuButton(
                      onTap: () => _showSectionOverlay(
                        context: context,
                        title: 'Schüler-Ids',
                        icon: Icons.badge_outlined,
                        children: [
                          _ToolsMenuButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              String? channelName;
                              if (!Platform.isWindows && !Platform.isMacOS) {
                                channelName = await qrScanner(
                                  context: context,
                                  overlayText: "Bitte Verbindungscode scannen",
                                );
                              } else {
                                channelName = await shortTextfieldDialog(
                                  context: context,
                                  title: 'Verbindungscode eingeben',
                                  hintText: 'z.B. 12345678',
                                  labelText: 'Verbindungscode',
                                );
                              }
                              if (channelName == null || channelName.isEmpty) {
                                di<NotificationManager>().showSnackBar(
                                  NotificationType.error,
                                  'Kein gültiger Verbindungscode.',
                                );
                                return;
                              }
                              if (!context.mounted) return;
                              context.push(RoutePaths.pupilIdentityStream, extra: {
                                'role': PupilIdentityStreamRole.receiver,
                                'importedChannelName': channelName,
                              });
                            },
                            onLongPress: Platform.isAndroid || Platform.isIOS
                                ? () async {
                                    Navigator.pop(context);
                                    final channelName =
                                        await shortTextfieldDialog(
                                          context: context,
                                          title: 'Verbindungscode eingeben',
                                          hintText: 'z.B. 12345678',
                                          labelText: 'Verbindungscode',
                                        );
                                    if (channelName == null ||
                                        channelName.isEmpty) {
                                      di<NotificationManager>().showSnackBar(
                                        NotificationType.error,
                                        'Kein gültiger Verbindungscode.',
                                      );
                                      return;
                                    }
                                    if (!context.mounted) return;
                                    context.push(RoutePaths.pupilIdentityStream, extra: {
                                      'role': PupilIdentityStreamRole.receiver,
                                      'importedChannelName': channelName,
                                    });
                                  }
                                : null,
                            icon: Icons.qr_code_scanner_rounded,
                            label: 'Ids importieren',
                          ),
                          _ToolsMenuButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              final selectablePupils =
                                  di<PupilProxyManager>()
                                      .getPupilsFromInternalIds(
                                        di<PupilIdentityManager>()
                                            .availablePupilIds,
                                      );
                              if (!context.mounted) return;
                              final List<int>? pupilIds =
                                  await context.push<List<int>>(
                                    RoutePaths.utilSelectPupils,
                                    extra: selectablePupils,
                                  );
                              if (pupilIds == null || pupilIds.isEmpty) return;
                              final internalIds = di<PupilProxyManager>()
                                  .getInternalIdsFromPupilIds(pupilIds);
                              final String encryptedPupilIdentities =
                                  await PupilIdentityHelper()
                                      .generateEncryptedPupilIdentitiesTransferString(
                                        internalIds,
                                      );
                              if (!context.mounted) return;
                              context.push(RoutePaths.pupilIdentityStream, extra: {
                                'role': PupilIdentityStreamRole.sender,
                                'encryptedData': encryptedPupilIdentities,
                                'selectedPupilIds': pupilIds,
                              });
                            },
                            icon: Icons.mobile_screen_share,
                            label: 'Ids teilen',
                          ),
                          _ToolsMenuButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _importUnencryptedPupilIdentitySourceFile(
                                'pupil_identities',
                              );
                            },
                            icon: Icons.file_open_rounded,
                            label: 'aus Datei',
                          ),
                          // Desktop-only admin tools for pupil identity import
                          if (_hubSessionManager.isAdmin &&
                              (Platform.isWindows || Platform.isMacOS)) ...[
                            _ToolsMenuButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                final bool? confirm = await confirmationDialog(
                                  context: context,
                                  title: 'Datenbank aus SchiLD importieren',
                                  message:
                                      'Achtung! Nicht mehr vorhandene SchülerInnen auf dem Server werden deaktiviert. Fortfahren?',
                                );
                                if (confirm == true) {
                                  _importUnencryptedPupilIdentitySourceFile(
                                    'update_backend',
                                  );
                                }
                              },
                              icon: Icons.school,
                              label: 'SchiLD Import',
                            ),
                          ],
                        ],
                      ),
                      buttonIcon: Icon(
                        Icons.badge_outlined,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Schüler-Ids',
                    ),

                    // --- Statistik ---
                    MainMenuButton(
                      onTap: () => _showSectionOverlay(
                        context: context,
                        title: 'Daten',
                        icon: Icons.insights_rounded,
                        children: [
                          _ToolsMenuButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.push(RoutePaths.toolsCharts);
                            },
                            icon: Icons.bar_chart_rounded,
                            label: 'Diagramme',
                          ),
                          _ToolsMenuButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.push(RoutePaths.toolsStatistics);
                            },
                            icon: Icons.table_chart_rounded,
                            label: 'Statistik-Zahlen',
                          ),
                        ],
                      ),
                      buttonIcon: Icon(
                        Icons.insights_rounded,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Daten',
                    ),
                    MainMenuButton(
                      routePath: RoutePaths.toolsTimetable,
                      buttonIcon: Icon(
                        Icons.dashboard_rounded,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Stundenplan',
                    ),
                    // --- Calendar section ---
                    MainMenuButton(
                      routePath: RoutePaths.schoolCalendar,
                      buttonIcon: Icon(
                        Icons.calendar_month_rounded,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Schultage-\nKalender',
                    ),

                    // --- Admin sections ---
                    if (_hubSessionManager.isAdmin) ...[
                      // User-Verwaltung
                      MainMenuButton(
                        onTap: () => _showSectionOverlay(
                          context: context,
                          title: 'User-Verwaltung',
                          icon: Icons.people_rounded,
                          children: [
                            _ToolsMenuButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.push(RoutePaths.adminUsersNew);
                              },
                              icon: Icons.person_add_rounded,
                              label: 'User erstellen',
                            ),
                            _ToolsMenuButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.push(RoutePaths.adminUsers);
                              },
                              icon: Icons.people_rounded,
                              label: 'User-Verwaltung',
                            ),
                            _ToolsMenuButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.push(RoutePaths.adminUsersResetPassword);
                              },
                              icon: Icons.lock_reset_rounded,
                              label: 'Passwort\nzurücksetzen',
                            ),
                          ],
                        ),
                        buttonIcon: Icon(
                          Icons.people_rounded,
                          size: 50,
                          color: AppColors.gridViewColor,
                        ),
                        buttonText: 'Personal',
                      ),
                      // Matrix Kontakte (when configured)
                      if (matrixSessionConfigured) ...[
                        MainMenuButton(
                          routePath: RoutePaths.adminMatrixUsers,
                          buttonIcon: Image.asset(
                            'assets/schulpost_logo_200px_white.png',
                            width: 50,
                            height: 50,
                            color: AppColors.gridViewColor,
                          ),
                          buttonText: 'Matrix Kontakte',
                        ),
                      ],
                      // Admin (Schuldaten + Kalender + Stundenplan + Matrix)
                      MainMenuButton(
                        onTap: () => _showSectionOverlay(
                          context: context,
                          title: 'Administration',
                          icon: Icons.admin_panel_settings_rounded,
                          children: [
                            _ToolsMenuButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.push(RoutePaths.schoolEdit);
                              },
                              icon: Icons.school_rounded,
                              label: 'Schuldaten',
                            ),
                            _ToolsMenuButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.push(RoutePaths.toolsTimetable);
                              },
                              icon: Icons.schedule,
                              label: 'Stundenplan',
                            ),

                            _ToolsMenuButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.push(RoutePaths.schoolSemesters);
                              },
                              icon: Icons.calendar_view_month_rounded,
                              label: 'Schulhalbjahre\nverwalten',
                            ),
                            _ToolsMenuButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                final envJson = di<EnvManager>().activeEnv!
                                    .toJson();
                                final jsonString = jsonEncode(envJson);
                                await showQrCode(jsonString, context);
                              },
                              icon: Icons.key_rounded,
                              label: 'Schulschlüssel\nzeigen',
                            ),
                            _ToolsMenuButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.push(RoutePaths.adminMatrix);
                              },
                              icon: Icons.chat_rounded,
                              label: 'Matrix',
                            ),
                          ],
                        ),
                        buttonIcon: Icon(
                          Icons.admin_panel_settings_rounded,
                          size: 50,
                          color: AppColors.gridViewColor,
                        ),
                        buttonText: 'Admin',
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MatrixManager {}

/// Sub-button shown inside the bottom sheet overlay (120x120).
class _ToolsMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final IconData icon;
  final String label;

  const _ToolsMenuButton({
    required this.onPressed,
    this.onLongPress,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    const double buttonSize = 120;
    return Padding(
      padding: EdgeInsets.all(Style.spacing.xs),
      child: GestureDetector(
        onTap: onPressed,
        onLongPress: onLongPress,
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: CardBox(
            padding: EdgeInsets.all(Style.spacing.sm),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 36, color: AppColors.gridViewColor),
                const Gap(8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Style.spacing.xs),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.typography.bodySmall.bold.withColor(
                      style.colors.foreground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
