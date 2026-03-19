import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_proxy_workbooks_ext.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_screen/widgets/pupil_workbook_card.dart';

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
        Row(
          children: [
            Text(
              'Arbeitshefte',
              style: context.typography.title,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Style.spacing.sm),
          child: Button(
            variant: ButtonVariant.primary,
            label: 'NEUES ARBEITSHEFT',
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
                  di<NotificationManager>().showInformationDialog(
                    NotificationType.error,
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
            di<NotificationManager>().showSnackBar(
              NotificationType.error,
              'Fehler beim Scannen',
            );
          },
          ),
        ),

        if (pupilWorkbooks.isNotEmpty) ...[
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupilWorkbooks.length,
            itemBuilder: (context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(Style.radii.large),
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
