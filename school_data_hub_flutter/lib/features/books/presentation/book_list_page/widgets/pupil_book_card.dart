import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:watch_it/watch_it.dart';

class PupilBookCard extends WatchingWidget {
  const PupilBookCard({
    required this.pupilBook,
    required this.pupilId,
    super.key,
  });
  final PupilBookLending pupilBook;
  final int pupilId;

  @override
  Widget build(BuildContext context) {
    final _hubSessionManager = di<HubSessionManager>();
    final LibraryBookProxy bookProxy = di<BookManager>().getLibraryBookById(
      pupilBook.libraryBookId,
    )!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        child: InkWell(
          // onTap: () {
          //   Navigator.of(context).push(MaterialPageRoute(
          //     builder: (ctx) => SchoolListPupils(
          //       workbook,
          //     ),
          //   ));
          // },
          onLongPress: () async {
            if (pupilBook.lentBy != _hubSessionManager.userName ||
                !_hubSessionManager.isAdmin) {
              informationDialog(
                context,
                'Keine Berechtigung',
                'Arbeitshefte können nur von der eintragenden Person bearbeitet werden!',
              );
              return;
            }
            final bool? result = await confirmationDialog(
              context: context,
              title: 'Ausleihe löschen',
              message:
                  'Ausleihe des Buches "${bookProxy.title}" wirklich löschen?',
            );
            if (result == true) {
              // TODO: Uncomment this when the API is ready
              // di<PupilManager>().deletePupilBook(
              //     lendingId: pupilBook.lendingId);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        final File? file = await createAndCropImageFile(
                          context,
                        );
                        if (file == null) return;
                        // TODO: Uncomment this when the API is ready ?
                        // await di<WorkbookManager>()
                        //     .postWorkbookFile(file, book.isbn);
                      },
                      // Todo: Uncomment this when the API is ready
                      // onLongPress: (bookProxy.book.imagePath == null)
                      //     ? () {}
                      //     : () async {
                      //         if (bookProxy.imageId == null) {
                      //           return;
                      //         }
                      //         final bool? result = await confirmationDialog(
                      //             context: context,
                      //             title: 'Bild löschen',
                      //             message: 'Bild löschen?');
                      //         if (result != true) return;
                      //         // await di<WorkbookManager>()
                      //         //     .deleteAuthorizationFile(
                      //         //   pupil.internalId,
                      //         //   authorizationId,
                      //         //   pupilAuthorization.fileId!,
                      //         // );
                      //       },
                      child: Container(),
                      // Provider<DocumentImageData>.value(
                      //   updateShouldNotify: (oldValue, newValue) =>
                      //       oldValue.documentUrl != newValue.documentUrl,
                      //   value: DocumentImageData(
                      //       documentTag: book.imageId,
                      //       documentUrl:
                      //           '${di<EnvManager>().env!.serverUrl}${WorkbookApiService().getWorkbookImage(book.isbn)}',
                      //       size: 100),
                      //   child: const DocumentImage(),
                      // ),
                    ),
                    const Gap(10),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  bookProxy.title,
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
                        const Gap(5),
                        // Row(
                        //   children: [
                        //     const Text('ISBN:'),
                        //     const Gap(10),
                        //     Text(
                        //       workbook.isbn.toString(),
                        //       style: const TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Gap(5),
                        Row(
                          children: [
                            Text(
                              bookProxy.author,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Spacer(),
                            Text(
                              bookProxy.readingLevel ??
                                  ReadingLevel.notSet.value,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Gap(10),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            const Text('Ausgeliehen von:'),
                            const Gap(5),
                            Text(
                              pupilBook.lentBy,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(5),
                            const Text('am'),
                            const Gap(5),
                            Text(
                              pupilBook.lentAt.formatDateForUser(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
