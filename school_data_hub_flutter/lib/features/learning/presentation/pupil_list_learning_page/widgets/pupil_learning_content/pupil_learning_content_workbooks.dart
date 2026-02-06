import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_page/widgets/pupil_workbook_card.dart';
import 'package:watch_it/watch_it.dart';

class PupilLearningContentWorkbooks extends WatchingWidget {
  final PupilProxy pupil;
  const PupilLearningContentWorkbooks({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final hubSessionManager = di<HubSessionManager>();
    final pupilWorkbookManager = watch(di<PupilWorkbookManager>());
    final pupilWorkbooks = pupilWorkbookManager.getPupilWorkbooks(
      pupil.pupilId,
    );

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
            String? isbnString;
            if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
              isbnString = await shortTextfieldDialog(
                context: context,
                title: 'ISBN code eingeben',
                labelText: 'ISBN code',
                hintText: 'ISBN code',
              );
              if (isbnString != null) {
                isbnString = isbnString.trim();
              }
            } else {
              isbnString = await qrScanner(
                context: context,
                overlayText: 'ISBN code scannen',
              );
            }

            if (isbnString != null) {
              final isbn = int.parse(isbnString);

              if (pupil.pupilWorkbooks?.isNotEmpty ?? false) {
                if (pupil.pupilWorkbooks!.any(
                  (element) => element.isbn == isbn,
                )) {
                  di<NotificationService>().showInformationDialog(
                    'Dieses Arbeitsheft ist schon erfasst!',
                  );
                  return;
                }
              }
              di<PupilWorkbookManager>().postPupilWorkbook(
                pupil.pupilId,
                isbn,
                hubSessionManager.userName!,
              );
              return;
            }
            di<NotificationService>().showSnackBar(
              NotificationType.error,
              'Fehler beim Scannen',
            );
          },
          child: const Text(
            "NEUES ARBEITSHEFT",
            style: AppStyles.buttonTextStyle,
          ),
        ),
        const Gap(15),
        if (pupilWorkbooks.isNotEmpty) ...[
          ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupilWorkbooks.length,
            itemBuilder: (context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Column(
                  children: [
                    PupilWorkbookCard(
                      pupilWorkbook: pupilWorkbooks[index],
                      pupilId: pupil.pupilId,
                    ),
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
