import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/pupil_identity_file_import.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/qr/qr_utilites.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_identity_stream_page/pupil_identity_stream_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/matrix_tools_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/matrix_users_list_page.dart';
import 'package:school_data_hub_flutter/features/school/presentation/edit_school_data_page/edit_school_data_page.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/school_semester_list_page/school_semester_list.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/schooldays_calendar_page/schooldays_calendar_page.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/chart_page_controller.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/room_timetable_grid/room_timetable_grid_page.dart';
import 'package:school_data_hub_flutter/features/user/presentation/create_user/create_user_page.dart';
import 'package:school_data_hub_flutter/features/user/presentation/reset_password/reset_user_password_page.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/user_list_page.dart';

class ToolsPage extends WatchingWidget {
  const ToolsPage({super.key});

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
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.canvasColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 24, color: AppColors.backgroundColor),
                    const Gap(8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
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
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.build_rounded,
        title: 'Tools',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
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
                            di<NotificationService>().showSnackBar(
                              NotificationType.error,
                              'Kein gültiger Verbindungscode.',
                            );
                            return;
                          }
                          if (!context.mounted) return;
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => PupilIdentityStreamPage(
                                role: PupilIdentityStreamRole.receiver,
                                importedChannelName: channelName,
                              ),
                            ),
                          );
                        },
                        onLongPress: Platform.isAndroid || Platform.isIOS
                            ? () async {
                                Navigator.pop(context);
                                final channelName = await shortTextfieldDialog(
                                  context: context,
                                  title: 'Verbindungscode eingeben',
                                  hintText: 'z.B. 12345678',
                                  labelText: 'Verbindungscode',
                                );
                                if (channelName == null ||
                                    channelName.isEmpty) {
                                  di<NotificationService>().showSnackBar(
                                    NotificationType.error,
                                    'Kein gültiger Verbindungscode.',
                                  );
                                  return;
                                }
                                if (!context.mounted) return;
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) =>
                                        PupilIdentityStreamPage(
                                          role:
                                              PupilIdentityStreamRole.receiver,
                                          importedChannelName: channelName,
                                        ),
                                  ),
                                );
                              }
                            : null,
                        icon: Icons.qr_code_scanner_rounded,
                        label: 'Ids importieren',
                      ),
                      _ToolsMenuButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          final List<int>? pupilIds =
                              await Navigator.of(context).push(
                                MaterialPageRoute<List<int>>(
                                  builder: (ctx) => SelectPupilsListPage(
                                    selectablePupils: di<PupilProxyManager>()
                                        .getPupilsFromInternalIds(
                                          di<PupilIdentityManager>()
                                              .availablePupilIds,
                                        ),
                                  ),
                                ),
                              );
                          if (pupilIds == null || pupilIds.isEmpty) return;
                          final internalIds = di<PupilProxyManager>()
                              .getInternalIdsFromPupilIds(pupilIds);
                          final String
                          encryptedPupilIdentities = await PupilIdentityHelper()
                              .generateEncryptedPupilIdentitiesTransferString(
                                internalIds,
                              );
                          if (!context.mounted) return;
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => PupilIdentityStreamPage(
                                role: PupilIdentityStreamRole.sender,
                                encryptedData: encryptedPupilIdentities,
                                selectedPupilIds: pupilIds,
                              ),
                            ),
                          );
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
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const ChartPageController(),
                            ),
                          );
                        },
                        icon: Icons.bar_chart_rounded,
                        label: 'Diagramme',
                      ),
                      _ToolsMenuButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const Statistics(),
                            ),
                          );
                        },
                        icon: Icons.table_chart_rounded,
                        label: 'Statistik-Zahlen',
                      ),
                      // _ToolsMenuButton(
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute<void>(
                      //         builder: (_) => const RoomTimetableGridPage(),
                      //       ),
                      //     );
                      //   },
                      //   icon: Icons.dashboard_rounded,
                      //   label: 'Stundenplan',
                      // ),
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
                  destinationPage: const RoomTimetableGridPage(),
                  buttonIcon: Icon(
                    Icons.dashboard_rounded,
                    size: 50,
                    color: AppColors.gridViewColor,
                  ),
                  buttonText: 'Stundenplan',
                ),
                // --- Calendar section ---
                MainMenuButton(
                  destinationPage: const SchooldaysCalendarPage(),
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
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const CreateOrEditUserPage(),
                              ),
                            );
                          },
                          icon: Icons.person_add_rounded,
                          label: 'User erstellen',
                        ),
                        _ToolsMenuButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const UserListPage(),
                              ),
                            );
                          },
                          icon: Icons.people_rounded,
                          label: 'User-Verwaltung',
                        ),
                        _ToolsMenuButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const ResetUserPasswordPage(),
                              ),
                            );
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
                      destinationPage: const MatrixUsersListPage(),
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
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const EditSchoolDataPage(),
                              ),
                            );
                          },
                          icon: Icons.school_rounded,
                          label: 'Schuldaten',
                        ),
                        _ToolsMenuButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const RoomTimetableGridPage(),
                              ),
                            );
                          },
                          icon: Icons.schedule,
                          label: 'Stundenplan',
                        ),

                        _ToolsMenuButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const SchoolSemesterListPage(),
                              ),
                            );
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
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const MatrixToolsPage(),
                              ),
                            );
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
    const double buttonSize = 120;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Card(
            color: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 36, color: AppColors.gridViewColor),
                const Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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
