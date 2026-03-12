import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/app_utils/app_helpers.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/books/utils/book_ids_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/batch_import_users/batch_import_users_page.dart';

class SettingsAdminSection extends WatchingWidget {
  const SettingsAdminSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userManager = di<UserManager>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Admin-Tools',
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
                leading: const Icon(Icons.qr_code_rounded),
                title: const Text('Buch IDs generieren'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  generateBookIdsPdf();
                },
              ),
              ListTile(
                leading: const Icon(Icons.qr_code_rounded),
                title: const Text('Zeugnis generieren'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  //    generateCompetenceReportPdf(reportLevel: ReportLevel.E1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.key_rounded),
                title: const Text('Neuen Schlüssel generieren'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  AppHelpers.generateSchoolKeys(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money_rounded),
                title: const Text('Guthaben überweisen'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
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
              ListTile(
                leading: const Icon(Icons.compare_arrows_rounded),
                title: const Text('Kompetenzen aus Datei importieren'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  await di<CompetenceManager>().importCompetencesFromFile();
                },
              ),
              ListTile(
                leading: const Icon(Icons.compare_arrows_rounded),
                title: const Text('Förderkategorien aus Datei importieren'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  await di<SupportCategoryManager>()
                      .importSupportCategoriesFromFile();
                },
              ),
              ListTile(
                leading: const Icon(Icons.compare_arrows_rounded),
                title: const Text('Förderstufen aus Datei importieren'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  await di<LearningSupportManager>()
                      .importSupportLevelsFromFile();
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text('Benutzer aus Excel importieren'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (ctx) => const BatchImportUsersPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
