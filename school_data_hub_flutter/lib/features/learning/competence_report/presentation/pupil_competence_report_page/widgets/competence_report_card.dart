import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/pupil_competence_report_page/widgets/competence_report_check_card.dart';
import 'package:flutter_it/flutter_it.dart';

class CompetenceReportCard extends WatchingWidget {
  final CompetenceReport report;
  final int pupilId;

  const CompetenceReportCard({
    required this.report,
    required this.pupilId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = createOnce(() => CustomExpansionTileController());

    final checks = report.competenceReportChecks ?? [];

    return Card(
      color: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.achievement,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '${DateFormat('dd.MM.yyyy').format(report.achievedAt)} - ${report.createdBy}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (checks.isNotEmpty)
                  CustomExpansionTileSwitch(
                    customExpansionTileController: controller,
                  ),
                const Gap(8),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white70),
                  onPressed: () async {
                    final confirm = await confirmationDialog(
                      context: context,
                      title: 'Zeugnis löschen',
                      message:
                          'Alle zugehörigen Einträge werden ebenfalls gelöscht. Sind Sie sicher?',
                    );
                    if (confirm == true) {
                      di<CompetenceReportManager>().deleteReport(
                        pupilId: pupilId,
                        reportId: report.reportId,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          CustomExpansionTileContent(
            tileController: controller,
            widgetList: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Column(
                  children: [
                    for (final check in checks)
                      CompetenceReportCheckCard(
                        check: check,
                        pupilId: pupilId,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
