import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/isbn_extensions.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tag.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_helper.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_screen/widgets/library_book_card.dart';

class BookCard extends WatchingWidget {
  const BookCard({required this.isbn, super.key});
  final int isbn;

  List<PupilBookLending> libraryBookPupilBookLendings(int libraryBookId) {
    return BookHelpers.pupilBookLendingsLinkedToLibraryBook(
      libraryBookId: libraryBookId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final Map<int, List<LibraryBookProxy>> isbnBooks = watchValue(
      (BookManager x) => x.isbnLibraryBooksMap,
    );
    final List<LibraryBookProxy> bookProxies = isbnBooks[isbn] ?? [];

    final descriptionTileController = createOnce<ExpansibleController>(
      () => ExpansibleController(),
    );
    final LibraryBookProxy bookProxy = bookProxies.first;

    return CardBox(
      padding: EdgeInsets.zero,
      child: InkWell(
          onLongPress: () async {
            if (!di<HubSessionManager>().isAdmin) {
              informationDialog(
                context,
                'Keine Berechtigung',
                'Bücher können nur von Admins bearbeitet werden!',
              );
              return;
            }
            final bool? result = await confirmationDialog(
              context: context,
              title: 'Buch löschen',
              message:
                  'Buch "${bookProxy.title}" wirklich löschen? ACHTUNG: Alle Ausleihen dieses Buchs werden werden ebenfalls gelöscht!',
            );
            if (result == true) {
              await di<BookManager>().deleteLibraryBook(bookProxy);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: Style.spacing.sm,
              left: Style.spacing.lg,
              right: Style.spacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: InkWell(
                    onLongPress: (di<HubSessionManager>().isAdmin)
                        ? () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (ctx) => NewBook(
                            //     isEdit: true,
                            //     bookAuthor: books.first.author,
                            //     bookId: book.bookId,
                            //     isbn: book.isbn,
                            //     bookReadingLevel: book.readingLevel,
                            //     bookTitle: book.title,
                            //     bookDescription: book.description,
                            //     bookImageId: book.imageId,
                            //     location: book.location,
                            //   ),
                            // ));
                          }
                        : () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          bookProxy.title,
                          style: context.typography.title,
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        bookProxy.author,
                        style: context.typography.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Gap(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final File? file = await createAndCropImageFile(
                              context,
                            );
                            if (file == null) return;

                            await di<BookManager>().updateBookImage(
                              file: file,
                              isbn: bookProxy.isbn,
                            );
                          },
                          child: UnencryptedImageInCard(
                            cacheKey: bookProxy.isbn.toString(),
                            path: bookProxy.imagePath,
                            type: UnencryptedImageType.book,
                            size: 100,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('ISBN:'),
                                const Gap(10),
                                Text(
                                  bookProxy.isbn.displayAsIsbn(),
                                  style: context.typography.body.bold,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('LeseStufe:'),
                                const Gap(10),
                                Text(
                                  bookProxy.readingLevel ??
                                      ReadingLevel.notSet.value,
                                  overflow: TextOverflow.fade,
                                  style: context.typography.body.bold,
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: 2,
                              children: [
                                const Text('Tags: '),
                                for (final tag in bookProxy.bookTags) ...[
                                  const Gap(5),
                                  Tag(
                                    label: tag.name,
                                    color: style.colors.accent,
                                  ),
                                ],
                              ],
                            ),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.all(0),
                  controller: descriptionTileController,
                  title: Text(
                    'Beschreibung:',
                    style: context.typography.body.bold,
                  ),
                  children: [
                    InkWell(
                      onTap: () async {
                        final result = await longTextFieldDialog(
                          title: 'Beschreibung',
                          labelText: 'Beschreibung',
                          initialValue: bookProxy.description,
                          parentContext: context,
                        );
                        if (result == null ||
                            result.value == bookProxy.description) {
                          return;
                        }
                        di<BookManager>().updateLibraryBookAndBookProperties(
                          isbn: bookProxy.isbn,
                          libraryId: bookProxy.libraryId,
                          description: result.value,
                        );
                      },
                      child: Text(
                        bookProxy.description,
                        style: context.typography.body.withColor(
                          style.colors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: bookProxies.map((book) {
                    return LibraryBookCard(libraryBookProxy: book);
                  }).toList(),
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      );
  }
}
