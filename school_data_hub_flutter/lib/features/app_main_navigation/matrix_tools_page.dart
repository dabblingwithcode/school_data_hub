import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/qr/qr_utilites.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/logs/presentation/matrix_corporal_logs_page.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/set_matrix_environment_page/set_matrix_environment_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/matrix_users_list_page.dart';
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
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                _MatrixToolButton(
                  onPressed: () async {
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
                  icon: isConfigured
                      ? Icons.qr_code_2_rounded
                      : Icons.chat_rounded,
                  label: isConfigured
                      ? 'Zugangsdaten\nQR anzeigen'
                      : 'Matrix\ninitialisieren',
                ),
                if (isConfigured) ...[
                  _MatrixToolButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const MatrixUsersListPage(),
                        ),
                      );
                    },
                    icon: Icons.people_rounded,
                    label: 'Matrix-\nKontakte',
                  ),
                  _MatrixToolButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SetMatrixEnvironmentPage(),
                        ),
                      );
                    },
                    icon: Icons.settings_rounded,
                    label: 'Matrix-\nUmgebung',
                  ),
                  _MatrixToolButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await di.getAsync<MatrixPolicyManager>();
                      if (!context.mounted) return;
                      navigator.push(
                        MaterialPageRoute<void>(
                          builder: (_) => const MatrixCorporalLogsPage(),
                        ),
                      );
                    },
                    icon: Icons.article_outlined,
                    label: 'Matrix-\nCorporal-Logs',
                  ),

                  _MatrixToolButton(
                    onPressed: () async {
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
                    icon: Icons.person_add_alt_1_rounded,
                    label: 'Matrix-Konten\nErstellen',
                  ),

                  _MatrixToolButton(
                    onPressed: () async {
                      final matrixUsersList =
                          di<MatrixPolicyManager>().matrixUsers.value;
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              SelectMatrixUsersList(matrixUsersList),
                        ),
                      );
                    },
                    icon: Icons.print,
                    label: 'Mehrere neue Benutzer-Codes generieren',
                  ),
                  _MatrixToolButton(
                    onPressed: () async {
                      await di<MatrixPolicyManager>()
                          .deleteAndDeregisterMatrixPolicyManager();
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    },
                    icon: Icons.delete_rounded,
                    label: 'Matrix\nlöschen',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const GenericBottomNavBar(),
    );
  }
}

class _MatrixToolButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const _MatrixToolButton({
    required this.onPressed,
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
