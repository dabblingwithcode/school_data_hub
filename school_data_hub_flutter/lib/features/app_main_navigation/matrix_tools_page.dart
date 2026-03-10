import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/qr/qr_utilites.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/room_timetable_grid/room_timetable_grid_page.dart';
import 'package:school_data_hub_flutter/features/matrix/logs/presentation/matrix_corporal_logs_page.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/set_matrix_environment_page/set_matrix_environment_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/matrix_users_list_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/controller/select_matrix_users_list_controller.dart';

class MatrixToolsPage extends WatchingWidget {
  const MatrixToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final matrixPolicyManagerIsRegistered = watchPropertyValue(
      (HubSessionManager x) => x.matrixPolicyManagerRegistrationStatus,
    );
    final matrixSessionIsConfigured = watchPropertyValue(
      (HubSessionManager x) => x.isMatrixSessionConfigured,
    );
    final isConfigured =
        matrixPolicyManagerIsRegistered || matrixSessionIsConfigured;

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.chat_rounded,
        title: 'Matrix',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  MainMenuButton(
                    buttonSize: 120,
                    onTap: () async {
                      if (matrixPolicyManagerIsRegistered) {
                        final matrixPolicyManager = di<MatrixPolicyManager>();
                        final qrString = matrixPolicyManager
                            .exportMatrixCredentialsJsonForTransfer();
                        await showQrCode(qrString, context);
                        return;
                      }
                      if (matrixSessionIsConfigured) {
                        final matrixPolicyManager = await di
                            .getAsync<MatrixPolicyManager>();
                        final qrString = matrixPolicyManager
                            .exportMatrixCredentialsJsonForTransfer();
                        if (!context.mounted) return;
                        await showQrCode(qrString, context);
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SetMatrixEnvironmentPage(),
                        ),
                      );
                    },
                    buttonIcon: Icon(
                      isConfigured
                          ? Icons.qr_code_2_rounded
                          : Icons.chat_rounded,
                      size: 36,
                      color: AppColors.gridViewColor,
                    ),
                    buttonText: isConfigured
                        ? 'Zugangsdaten\nQR anzeigen'
                        : 'Matrix\ninitialisieren',
                  ),
                  if (isConfigured) ...[
                    MainMenuButton(
                      buttonSize: 120,
                      destinationPage: const MatrixUsersListPage(),
                      buttonIcon: Icon(
                        Icons.people_rounded,
                        size: 36,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Matrix-\nKontakte',
                    ),
                    MainMenuButton(
                      buttonSize: 120,
                      destinationPage: const SetMatrixEnvironmentPage(),
                      buttonIcon: Icon(
                        Icons.settings_rounded,
                        size: 36,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Matrix-\nUmgebung',
                    ),
                    MainMenuButton(
                      buttonSize: 120,
                      destinationPage: const RoomTimetableGridPage(),
                      buttonIcon: Icon(
                        Icons.grid_on,
                        size: 36,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Raum-\nRaster (Test)',
                    ),
                    MainMenuButton(
                      buttonSize: 120,
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        await di.getAsync<MatrixPolicyManager>();
                        if (!context.mounted) return;
                        navigator.push(
                          MaterialPageRoute<void>(
                            builder: (_) => const MatrixCorporalLogsPage(),
                          ),
                        );
                      },
                      buttonIcon: Icon(
                        Icons.article_outlined,
                        size: 36,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Matrix-\nCorporal-Logs',
                    ),
                    MainMenuButton(
                      buttonSize: 120,
                      onTap: () async {
                        final confirm = await confirmationDialog(
                          context: context,
                          title: 'Matrix-Konten für SuS ohne Kontakt erstellen',
                          message:
                              'Möchten Sie die Matrix-Konten für SuS ohne Kontakt wirklich erstellen?',
                        );
                        if (confirm != true) return;
                        final file = await di<MatrixPolicyManager>().users
                            .createMatrixCredentialsForPupilsWithoutContactInfo();
                        if (!context.mounted) return;
                        if (file != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => PdfViewerPage(pdfFile: file),
                            ),
                          );
                        }
                      },
                      buttonIcon: Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 36,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Matrix-Konten\nErstellen',
                    ),
                    MainMenuButton(
                      buttonSize: 120,
                      onTap: () async {
                        final matrixUsersList =
                            di<MatrixPolicyManager>().matrixUsers.value;
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) =>
                                SelectMatrixUsersList(matrixUsersList),
                          ),
                        );
                      },
                      buttonIcon: Icon(
                        Icons.print,
                        size: 36,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Mehrere neue Benutzer-Codes generieren',
                    ),
                    MainMenuButton(
                      buttonSize: 120,
                      onTap: () async {
                        await di<MatrixPolicyManager>()
                            .deleteAndDeregisterMatrixPolicyManager();
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      },
                      buttonIcon: Icon(
                        Icons.delete_rounded,
                        size: 36,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Matrix\nlöschen',
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const GenericBottomNavBar(),
    );
  }
}
