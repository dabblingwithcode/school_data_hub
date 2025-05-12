import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/upload_image.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_helper.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/library_book_card.dart';
import 'package:watch_it/watch_it.dart';

class BookCard extends WatchingWidget {
  const BookCard({required this.isbn, super.key});
  final int isbn;

  List<PupilBookLending> libraryBookPupilBooks(int bookId) {
    return BookHelpers.pupilBooksLinkedToBook(bookId: bookId);
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, List<BookProxy>> isbnBooks =
        watchValue((BookManager x) => x.booksByIsbn);
    final List<BookProxy> books = isbnBooks[isbn] ?? [];
    final tileController = createOnce<CustomExpansionTileController>(
        () => CustomExpansionTileController());
    final descriptionTileController = createOnce<ExpansionTileController>(
      () => ExpansionTileController(),
    );
    final BookProxy book = books.first;

    // BookBorrowStatus? bookBorrowStatus = bookPupilBooks.isEmpty
    //     ? null
    //     : BookHelpers.getBorrowedStatus(bookPupilBooks.first);
    // final Color borrowedColor = book.available
    //     ? Colors.green
    //     : bookBorrowStatus == BookBorrowStatus.since2Weeks
    //         ? Colors.yellow
    //         : bookBorrowStatus == BookBorrowStatus.since3Weeks
    //             ? Colors.orange
    //             : Colors.red;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: InkWell(
            onLongPress: () async {
              // if (!locator<SessionManager>().isAdmin.value) {
              //   informationDialog(context, 'Keine Berechtigung',
              //       'Bücher können nur von Admins bearbeitet werden!');
              //   return;
              // }
              // final bool? result = await confirmationDialog(
              //     context: context,
              //     title: 'Buch löschen',
              //     message:
              //         'Buch "${book.title}" wirklich löschen? ACHTUNG: Alle Ausleihen dieses Buchs werden werden ebenfalls gelöscht!');
              // if (result == true) {
              //   await locator<BookManager>().deleteLibraryBook(book.bookId);
              // }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: InkWell(
                      onLongPress: (di<ServerpodSessionManager>().isAdmin)
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
                            book.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                          book.author,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.normal),
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
                                final File? file =
                                    await createImageFile(context);
                                if (file == null) return;
                                await di<BookManager>()
                                    .patchBookImage(file, book.isbn);
                              },
                              child: DocumentImage(
                                documentId: book.imageId,
                                size: 140,
                              )),
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
                                    book.isbn.displayAsIsbn(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('LeseStufe:'),
                                  const Gap(10),
                                  Text(
                                    book.readingLevel,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Wrap(
                                spacing: 2,
                                children: [
                                  const Text('Tags: '),
                                  for (final tag in book.bookTags) ...[
                                    const Gap(5),
                                    Chip(
                                      padding: const EdgeInsets.all(2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelStyle:
                                          AppStyles.filterItemsTextStyle,
                                      label: Text(tag.name),
                                      backgroundColor:
                                          AppColors.backgroundColor,
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
                    title: const Text(
                      'Beschreibung:',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    children: [
                      InkWell(
                        onTap: () async {
                          final String? description = await longTextFieldDialog(
                              title: 'Beschreibung',
                              labelText: 'Beschreibung',
                              initialValue: book.description,
                              parentContext: context);
                          di<BookManager>().updateBookProperty(
                            isbn: book.isbn,
                            description: description,
                          );
                        },
                        child: Text(
                          book.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.interactiveColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: books.map((book) {
                      return LibraryBookCard(book: book);
                    }).toList(),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          )),
    );
  }
}
