import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_page/new_workbook_page.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_page/widgets/pupil_workbook_card.dart';
import 'package:watch_it/watch_it.dart';

class PupilLearningContentWorkbooks extends StatelessWidget {
  final PupilProxy pupil;
  const PupilLearningContentWorkbooks({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final _hubSessionManager = di<HubSessionManager>();
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Arbeitshefte',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Gap(10),
        ElevatedButton(
          style: AppStyles.actionButtonStyle,
          //- TODO: strip this logic and use a controller instead ?
          onPressed: () async {
            final scanResult = await qrScanner(
                context: context, overlayText: 'ISBN code scannen');
            if (scanResult != null) {
              final scannedIsbn = int.parse(scanResult);
              if (!di<WorkbookManager>()
                  .workbooks
                  .value
                  .any((element) => element.isbn == scannedIsbn)) {
                if (context.mounted) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => NewWorkbookPage(
                            isEdit: false,
                            isbn: scannedIsbn,
                          )));
                }
                di<NotificationService>().showInformationDialog(
                    'Das Arbeitsheft wurde noch nicht erfasst. Bitte hinzufügen!');
                return;
              }
              if (pupil.pupilWorkbooks!.isNotEmpty) {
                if (pupil.pupilWorkbooks!
                    .any((element) => element.isbn == int.parse(scanResult))) {
                  di<NotificationService>().showSnackBar(NotificationType.error,
                      'Dieses Arbeitsheft ist schon erfasst!');
                  return;
                }
              }
              di<PupilWorkbookManager>().postPupilWorkbook(pupil.internalId,
                  int.parse(scanResult), _hubSessionManager.userName!);
              return;
            }
            di<NotificationService>()
                .showSnackBar(NotificationType.error, 'Fehler beim Scannen');
          },
          child: const Text(
            "NEUES ARBEITSHEFT",
            style: AppStyles.buttonTextStyle,
          ),
        ),
        const Gap(15),
        if (pupil.pupilWorkbooks != null &&
            pupil.pupilWorkbooks!.isNotEmpty) ...[
          ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupil.pupilWorkbooks!.length,
            itemBuilder: (context, int index) {
              List<PupilWorkbook> pupilWorkbooks = pupil.pupilWorkbooks!;

              return ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Column(
                  children: [
                    PupilWorkbookCard(
                        pupilWorkbook: pupilWorkbooks[index],
                        pupilId: pupil.internalId),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
