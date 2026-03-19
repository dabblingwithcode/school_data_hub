import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';

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
    final hubSessionManager = di<HubSessionManager>();
    final LibraryBookProxy bookProxy = di<BookManager>().getLibraryBookById(
      pupilBook.libraryBookId,
    )!;
    return CardBox(
      child: InkWell(
        // onTap: () {
        //   Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        //     builder: (ctx) => SchoolListPupils(
        //       workbook,
        //     ),
        //   ));
        // },
        onLongPress: () async {
          if (pupilBook.lentBy != hubSessionManager.userName ||
              !hubSessionManager.isAdmin) {
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
            di<PupilBookLendingManager>().deletePupilBookLending(
              lendingId: pupilBook.lendingId,
            );
          }
        },
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
                    di<PupilBookLendingManager>().addPupilBookLendingFile(
                      pupilBookLending: pupilBook,
                      file,
                    );
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
                  // TODO: The image should show here
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
                              style: context.typography.subtitle.bold,
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
                          style: context.typography.body,
                        ),
                        const Spacer(),
                        Text(
                          bookProxy.readingLevel ??
                              ReadingLevel.notSet.value,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: context.typography.body,
                        ),
                        const Gap(10),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Text(
                          'Ausgeliehen von:',
                          style: context.typography.body,
                        ),
                        const Gap(5),
                        Text(
                          pupilBook.lentBy,
                          style: context.typography.body.bold,
                        ),
                        const Gap(5),
                        Text(
                          'am',
                          style: context.typography.body,
                        ),
                        const Gap(5),
                        Text(
                          pupilBook.lentAt.formatDateForUser(),
                          style: context.typography.body.bold,
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
    );
  }
}
