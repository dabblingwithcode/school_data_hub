import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:school_data_hub_flutter/app_utils/app_helpers.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/qr/qr_utilites.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/utils/book_ids_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/set_matrix_environment_page/set_matrix_environment_controller.dart';
import 'package:school_data_hub_flutter/features/school/presentation/edit_school_data_page/edit_school_data_page.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/new_school_semester_page/new_school_semester_page.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/new_school_semester_page/schooldays_calendar_page/schooldays_calendar_page.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/create_user/create_user_page.dart';
import 'package:school_data_hub_flutter/features/user/presentation/reset_password/reset_user_password_page.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/user_list_page.dart';
import 'package:watch_it/watch_it.dart';

class SettingsAdminSection extends AbstractSettingsSection with WatchItMixin {
  const SettingsAdminSection({super.key});

  @override
  Widget build(BuildContext context) {
    final _envManager = di<EnvManager>();

    final _notificationService = di<NotificationService>();

    final _userManager = di<UserManager>();

    final bool matrixPolicyManagerIsRegistered = watchPropertyValue(
      (HubSessionManager x) => x.matrixPolicyManagerRegistrationStatus,
    );
    return SettingsSection(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Admin-Tools',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      tiles: <SettingsTile>[
        SettingsTile.navigation(
          title: const Text('Schuldaten eintragen'),
          leading: const Icon(Icons.account_circle_rounded),
          onPressed: (context) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const EditSchoolDataPage()),
            );
          },
        ),
        SettingsTile.navigation(
          title: const Text('Neuen User erstellen'),
          leading: const Icon(Icons.account_circle_rounded),
          onPressed: (context) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => const CreateUserPage()));
          },
        ),
        SettingsTile.navigation(
          title: const Text('User-Verwaltung'),
          leading: const Icon(Icons.account_circle_rounded),
          onPressed: (context) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => const UserListPage()));
          },
        ),
        SettingsTile.navigation(
          title: const Text('User-Passwort zurücksetzen'),
          leading: const Icon(Icons.lock_reset),
          onPressed: (context) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ResetUserPasswordPage(),
              ),
            );
          },
        ),
        SettingsTile.navigation(
          title: const Text('Buch IDs generieren'),
          leading: const Icon(Icons.qr_code_rounded),
          onPressed: (context) {
            generateBookIdsPdf();
          },
        ),
        SettingsTile.navigation(
          title: const Text('Zeugnis generieren'),
          leading: const Icon(Icons.qr_code_rounded),
          onPressed: (context) {
            //    generateCompetenceReportPdf(reportLevel: ReportLevel.E1);
          },
        ),
        SettingsTile.navigation(
          title: const Text('Neuen Schlüssel generieren'),
          leading: const Icon(Icons.key_rounded),
          onPressed: (context) async {
            AppHelpers.generateSchoolKeys(context);
          },
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.attach_money_rounded),
          title: const Text('Guthaben überweisen'),
          onPressed: (context) async {
            final bool? confirmed = await confirmationDialog(
              context: context,
              title: 'Guthaben überweisen',
              message: 'Sind Sie sicher?',
            );
            if (confirmed != true) {
              return;
            }
            await _userManager.increaseUsersCredit();
          },
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.qr_code_rounded),
          title: const Text('Schulschlüssel zeigen'),
          onPressed: (context) {
            final Map<String, dynamic> json = _envManager.activeEnv!.toJson();

            final String jsonString = jsonEncode(json);

            showQrCode(jsonString, context);
          },
        ),
        SettingsTile.navigation(
          leading: matrixPolicyManagerIsRegistered
              ? const Icon(Icons.check_circle_rounded, color: Colors.green)
              : const Icon(Icons.chat_rounded),
          title: matrixPolicyManagerIsRegistered
              ? const Text('Raumverwaltung initialisiert')
              : const Text('Raumverwaltung initialisieren'),
          onPressed: (context) async {
            if (matrixPolicyManagerIsRegistered) {
              _notificationService.showSnackBar(
                NotificationType.info,
                'Raumverwaltung ist bereits initialisiert',
              );
              return;
            }

            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const SetMatrixEnvironment(),
                ),
              );
            }
          },
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.chat_rounded),
          title: const Text('Raumverwaltung löschen'),
          onPressed: (context) async {
            await di<MatrixPolicyManager>()
                .deleteAndDeregisterMatrixPolicyManager();
          },
        ),

        SettingsTile.navigation(
          leading: const Icon(Icons.calendar_month_rounded),
          title: const Text('Schultage-Kalender'),
          onPressed: (context) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const SchooldaysCalendarPage(),
              ),
            );
          },
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.calendar_month_rounded),
          title: const Text('Schulsemester hinzufügen'),
          onPressed: (context) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const NewSchoolSemesterPage(),
              ),
            );
          },
        ),

        SettingsTile.navigation(
          onPressed: (context) async {
            final confirm = await confirmationDialog(
              context: context,
              title: 'Alles löschen',
              message:
                  'Wirklich alles löschen?\n\nAlle Informationen im Server werden gelöscht!',
            );
            if (confirm == true) {
              // TODO: Implement delete all functionality
            }
          },
          leading: const Icon(Icons.logout),
          title: const Text('Alles löschen und ausloggen'),
          description: const Text('Es wird alles gelöscht!'),

          //onPressed:
        ),
        SettingsTile.navigation(
          onPressed: (context) async {
            await di<CompetenceManager>().importCompetencesFromFile();
          },
          leading: const Icon(Icons.compare_arrows_rounded),
          title: const Text('Kompetenzen aus Datei importieren'),

          //onPressed:
        ),
        SettingsTile.navigation(
          onPressed: (context) async {
            await di<SupportCategoryManager>()
                .importSupportCategoriesFromFile();
          },
          leading: const Icon(Icons.compare_arrows_rounded),
          title: const Text('Förderkategorien aus Datei importieren'),

          //onPressed:
        ),
        SettingsTile.navigation(
          onPressed: (context) async {
            await di<LearningSupportManager>().importSupportLevelsFromFile();
          },
          leading: const Icon(Icons.compare_arrows_rounded),
          title: const Text('Förderstufen aus Datei importieren'),

          //onPressed:
        ),
      ],
    );
  }
}
