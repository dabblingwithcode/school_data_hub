import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:school_data_hub_flutter/app_utils/app_helpers.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/utils/book_ids_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/server_logs/presentation/server_logs_page.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';

class SettingsAdminSection extends AbstractSettingsSection with WatchItMixin {
  const SettingsAdminSection({super.key});

  @override
  Widget build(BuildContext context) {
    final envManager = di<EnvManager>();

    final notificationService = di<NotificationService>();

    final userManager = di<UserManager>();

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
            await userManager.increaseUsersCredit();
          },
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
