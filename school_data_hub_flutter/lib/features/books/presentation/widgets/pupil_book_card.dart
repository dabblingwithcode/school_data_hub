import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilBookLendingCard extends StatelessWidget {
  const PupilBookLendingCard({
    required this.pupilBookLending,
    required this.pupilId,
    super.key,
  });
  final PupilBookLending pupilBookLending;
  final int pupilId;

  @override
  Widget build(BuildContext context) {
    final LibraryBookProxy book = di<BookManager>().getLibraryBookById(
      pupilBookLending.libraryBookId,
    )!;
    void updatepupilBookRating(int rating) {
      di<PupilProxyManager>().updatePupilBookLending(
        pupilBookLending: pupilBookLending,
        score: (value: rating),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: AppColors.cardInCardColor,
        child: InkWell(
          onLongPress: () async {
            final isAuthorized =
                di<HubSessionManager>().isAdmin ||
                di<HubSessionManager>().userName == pupilBookLending.lentBy;

            if (!isAuthorized) {
              informationDialog(
                context,
                'Keine Berechtigung',
                'Ausleihen können nur von der eintragenden Person bearbeitet werden!',
              );
              return;
            }
            final bool? result = await confirmationDialog(
              context: context,
              title: 'Ausleihe löschen',
              message: 'Ausleihe von "${book.title}" wirklich löschen?',
            );
            if (result == true) {
              di<PupilProxyManager>().deletePupilBook(
                lendingId: pupilBookLending.lendingId,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
                const Gap(10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UnencryptedImageInCard(
                          cacheKey: book.isbn.toString(),
                          path: book.imagePath,
                          size: 80,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(5),
                            Text('Bucherei-Id: ${book.libraryId}'),
                            const Gap(5),
                            Row(
                              children: [
                                Text(
                                  pupilBookLending.lentBy,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(2),
                                const Icon(
                                  Icons.arrow_circle_right_rounded,
                                  color: Colors.orange,
                                ),
                                const Gap(2),
                                Text(
                                  pupilBookLending.lentAt
                                      .toLocal()
                                      .formatDateForUser(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (pupilBookLending.returnedAt != null)
                              Row(
                                children: [
                                  Text(
                                    pupilBookLending.receivedBy!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(2),
                                  const Icon(
                                    Icons.arrow_circle_left_rounded,
                                    color: Colors.green,
                                  ),
                                  const Gap(2),
                                  Text(
                                    pupilBookLending.returnedAt!
                                        .formatDateForUser(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GrowthDropdown(
                          dropdownValue: pupilBookLending.score,
                          onChangedFunction: updatepupilBookRating,
                        ),
                      ],
                    ),
                  ],
                ),
                const Text(
                  'Beobachtungen:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    final status = await longTextFieldDialog(
                      title: 'Status',
                      labelText: 'Status',
                      initialValue: pupilBookLending.status ?? '',
                      parentContext: context,
                    );
                    if (status == null) return;
                    await di<PupilProxyManager>().updatePupilBookLending(
                      pupilBookLending: pupilBookLending,
                      status: (value: status),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.interactiveColor.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      (pupilBookLending.status == null ||
                              pupilBookLending.status == '')
                          ? 'Kein Eintrag - Tippen zum Bearbeiten'
                          : pupilBookLending.status!,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.interactiveColor,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                if (pupilBookLending.returnedAt == null) ...[
                  const Gap(5),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom: 8,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await confirmationDialog(
                                context: context,
                                title: 'Buch zurückgeben',
                                message:
                                    'Buch "${book.title}" wirklich zurückgeben?',
                              );
                              if (result!) {
                                di<PupilProxyManager>().returnLibraryBook(
                                  pupilBookLending: pupilBookLending,
                                );
                              }
                            },
                            style: AppStyles.successButtonStyle,
                            child: const Text(
                              'BUCH ZURÜCKGEBEN',
                              style: AppStyles.buttonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
