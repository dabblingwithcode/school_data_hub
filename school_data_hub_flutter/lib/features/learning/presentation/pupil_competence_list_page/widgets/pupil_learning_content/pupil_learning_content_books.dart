import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/books/presentation/widgets/pupil_book_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilLearningContentBooks extends StatelessWidget {
  final PupilProxy pupil;
  const PupilLearningContentBooks({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Bücher',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Gap(10),
        ElevatedButton(
          style: AppStyles.actionButtonStyle,
          onPressed: () async {
            String? bookId;
            if (Platform.isIOS || Platform.isAndroid) {
              final scannedBookId = await qrScanner(
                context: context,
                overlayText: 'Buch-ID scannen',
              );
              if (!(scannedBookId != null)) {
                di<NotificationService>().showSnackBar(
                  NotificationType.error,
                  'Buch-ID konnte nicht gescannt werden',
                );
                return;
              }
              bookId = scannedBookId.replaceFirst('Buch ID: ', '');
            } else {
              bookId = await shortTextfieldDialog(
                context: context,
                title: 'Bibliotheks-Id',
                labelText: 'Buch-Id eingeben',
                hintText: 'Buch-Id',
                obscureText: false,
              );
            }
            if (bookId != null) {
              di<PupilManager>().postPupilBookLending(
                pupilId: pupil.pupilId,
                libraryId: bookId,
              );
              return;
            }
          },
          child: const Text("BUCH AUSLEIHEN", style: AppStyles.buttonTextStyle),
        ),
        const Gap(5),
        if (pupil.pupilBookLendings!.isNotEmpty) ...[
          const Gap(10),
          ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupil.pupilBookLendings!.length,
            itemBuilder: (context, int index) {
              List<PupilBookLending> pupilBookLendings =
                  pupil.pupilBookLendings!;

              return ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Column(
                  children: [
                    PupilBookLendingCard(
                      pupilBookLending: pupilBookLendings[index],
                      pupilId: pupil.pupilId,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        const Gap(10),
      ],
    );
  }
}
