import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
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
    final controller = createOnce(() => ExpansionController());
    final style = Style.of(context);

    final checks = report.competenceReportChecks ?? [];

    return CardBox(
      padding: EdgeInsets.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: style.colors.accent,
          borderRadius: BorderRadius.circular(Style.radii.medium),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Style.spacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.achievement,
                          style: context.typography.subtitle.bold.withColor(style.colors.background),
                        ),
                        Gap(Style.spacing.xs),
                        Text(
                          '${DateFormat('dd.MM.yyyy').format(report.achievedAt)} - ${report.createdBy}',
                          style: context.typography.bodySmall.withColor(
                            style.colors.background.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (checks.isNotEmpty)
                    ExpansionHeader(expansionController: controller),
                  Gap(Style.spacing.sm),
                  GestureDetector(
                    onTap: () async {
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
                    child: Icon(
                      Icons.delete,
                      color: style.colors.background.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            ExpansionBody(
              tileController: controller,
              widgetList: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Style.spacing.sm,
                    vertical: Style.spacing.xs,
                  ),
                  child: Column(
                    children: [
                      for (final check in checks)
                        CompetenceReportCheckCard(check: check, pupilId: pupilId),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
