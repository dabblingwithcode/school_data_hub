import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';
import 'package:school_data_hub_flutter/features/books/presentation/widgets/pupil_book_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class PupilLearningContentBooks extends WatchingWidget {
  final PupilProxy pupil;
  const PupilLearningContentBooks({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final pupilBookLendingManager = watch(di<PupilBookLendingManager>());
    final pupilBookLendings = pupilBookLendingManager.getPupilBookLendings(
      pupil.pupilId,
    );
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
              di<PupilBookLendingManager>().postPupilBookLending(
                pupilId: pupil.pupilId,
                libraryId: bookId,
              );
              return;
            }
          },
          child: const Text("BUCH AUSLEIHEN", style: AppStyles.buttonTextStyle),
        ),
        const Gap(5),
        if (pupilBookLendings.isNotEmpty) ...[
          const Gap(10),
          ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupilBookLendings.length,
            itemBuilder: (context, int index) {
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
        const Gap(5),
      ],
    );
  }
}
