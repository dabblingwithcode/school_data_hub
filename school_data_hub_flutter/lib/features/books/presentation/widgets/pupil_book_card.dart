import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/book_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilBookCard extends StatelessWidget {
  const PupilBookCard(
      {required this.pupilBook, required this.pupilId, super.key});
  final PupilBookLending pupilBook;
  final int pupilId;

  @override
  Widget build(BuildContext context) {
    final BookProxy book =
        di<BookManager>().getLibraryBookByBookId(pupilBook.id!)!;
    updatepupilBookRating(int rating) {
      di<PupilManager>()
          .patchPupilBook(lendingId: pupilBook.lendingId, rating: rating);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
          child: InkWell(
        onLongPress: () async {
          if (pupilBook.lentBy != di<ServerpodSessionManager>().userName ||
              !di<ServerpodSessionManager>().isAdmin) {
            informationDialog(context, 'Keine Berechtigung',
                'Ausleihen können nur von der eintragenden Person bearbeitet werden!');
            return;
          }
          final bool? result = await confirmationDialog(
              context: context,
              title: 'Ausleihe löschen',
              message: 'Ausleihe von "${book.title}" wirklich löschen?');
          if (result == true) {
            di<PupilManager>().deletePupilBook(lendingId: pupilBook.lendingId);
          }
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 5, left: 10, right: 10),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TODO: Uncomment this when image loading is implemented
                      const SizedBox(
                        height: 140,
                      ),
                      // UnencryptedImageInCard(
                      //   documentImageData: DocumentImageData(
                      //       documentTag: book.imageId,
                      //       documentUrl:
                      //           '${di<EnvManager>().env!.serverUrl}${BookApiService.getBookImageUrl(book.isbn)}',
                      //       size: 140),
                      // ),
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
                          Row(
                            children: [
                              Text(
                                pupilBook.lentBy,
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
                                pupilBook.lentAt.toLocal().formatForUser(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          if (pupilBook.returnedAt != null)
                            Row(
                              children: [
                                Text(
                                  pupilBook.receivedBy!,
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
                                  pupilBook.returnedAt!.formatForUser(),
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
                          dropdownValue: pupilBook.score ?? 0,
                          onChangedFunction: updatepupilBookRating),
                    ],
                  ),
                ],
              ),
              const Text(
                'Beobachtungen:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onLongPress: () async {
                  final status = await longTextFieldDialog(
                      title: 'Status',
                      labelText: 'Status',
                      initialValue: pupilBook.status ?? '',
                      parentContext: context);
                  if (status == null) return;
                  await di<PupilManager>().patchPupilBook(
                      lendingId: pupilBook.lendingId, comment: status);
                },
                child: Text(
                  (pupilBook.status == null || pupilBook.status == '')
                      ? 'Kein Eintrag'
                      : pupilBook.status!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.interactiveColor,
                  ),
                ),
              ),
              const Gap(10),
              if (pupilBook.returnedAt == null) ...[
                const Gap(5),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await confirmationDialog(
                                context: context,
                                title: 'Buch zurückgeben',
                                message:
                                    'Buch "${book.title}" wirklich zurückgeben?');
                            if (result!) {
                              di<PupilManager>().returnBook(
                                lendingId: pupilBook.lendingId,
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
                )
              ]
            ],
          ),
        ),
      )),
    );
  }
}
