import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_manager.dart';
import 'package:flutter_it/flutter_it.dart';

class CompetenceReportCheckCard extends StatelessWidget {
  final CompetenceReportCheck check;
  final int pupilId;

  const CompetenceReportCheckCard({
    required this.check,
    required this.pupilId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _achievementColor(check.achievement, style),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                '${check.achievement}',
                style: context.typography.body.bold.withColor(style.colors.background),
              ),
            ),
          ),
          Gap(Style.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  check.comment,
                  style: context.typography.body,
                ),
                Gap(Style.spacing.xs),
                Text(
                  '${check.createdBy} - ${DateFormat('dd.MM.yyyy').format(check.createdAt)}',
                  style: context.typography.bodySmall.withColor(style.colors.mutedForeground),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final confirm = await confirmationDialog(
                context: context,
                title: 'Eintrag löschen',
                message: 'Sind Sie sicher?',
              );
              if (confirm == true) {
                di<CompetenceReportManager>().deleteReportCheck(
                  pupilId: pupilId,
                  publicId: check.publicId,
                );
              }
            },
            child: Icon(
              Icons.delete,
              size: 20,
              color: style.colors.error,
            ),
          ),
        ],
      ),
    );
  }

  Color _achievementColor(int achievement, Style style) {
    switch (achievement) {
      case 1:
        return style.colors.error;
      case 2:
        return style.colors.warning;
      case 3:
        return style.colors.accent;
      case 4:
        return style.colors.success;
      default:
        return style.colors.mutedForeground;
    }
  }
}
