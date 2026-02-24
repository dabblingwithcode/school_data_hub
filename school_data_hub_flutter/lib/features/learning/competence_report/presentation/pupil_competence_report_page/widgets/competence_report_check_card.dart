import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: _achievementColor(check.achievement),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  '${check.achievement}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    check.comment,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Gap(4),
                  Text(
                    '${check.createdBy} - ${DateFormat('dd.MM.yyyy').format(check.createdAt)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              color: Colors.red,
              onPressed: () async {
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
            ),
          ],
        ),
      ),
    );
  }

  Color _achievementColor(int achievement) {
    switch (achievement) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return AppColors.accentColor;
      case 4:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
