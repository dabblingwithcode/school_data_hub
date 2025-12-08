import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/isbn_extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/library_book_card.dart';
import 'package:school_data_hub_flutter/features/books/presentation/edit_book_page/edit_book_controller.dart';
import 'package:watch_it/watch_it.dart';

class SearchResultBookCard extends WatchingWidget {
  final List<LibraryBookProxy> group;

  const SearchResultBookCard({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (group.isEmpty) return const SizedBox.shrink();

    final List<LibraryBookProxy> books = group;
    final LibraryBookProxy bookProxy = books.first;
    final descriptionTileController = createOnce<ExpansibleController>(
      () => ExpansibleController(),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: InkWell(
          onLongPress: () async {},
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditBook(libraryBook: bookProxy),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          bookProxy.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book image on the left side
                    UnencryptedImageInCard(
                      cacheKey: bookProxy.isbn.toString(),
                      path: bookProxy.imagePath,
                      size: 100,
                    ),
                    const Gap(15),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
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
                                  bookProxy.readingLevel ??
                                      ReadingLevel.notSet.value,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(5),
                            Wrap(
                              spacing: 2,
                              children: [
                                const Text('Tags: '),
                                if (bookProxy.bookTags.isEmpty)
                                  const Text(
                                    'Keine Tags',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                else
                                  for (final tag in bookProxy.bookTags) ...[
                                    const Gap(5),
                                    Chip(
                                      padding: const EdgeInsets.all(4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      label: Text(tag.name),
                                      backgroundColor:
                                          AppColors.interactiveColor,
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
                      color: Colors.black,
                    ),
                  ),
                  children: [
                    InkWell(
                      onTap: () async {
                        final String? description = await longTextFieldDialog(
                          title: 'Beschreibung',
                          labelText: 'Beschreibung',
                          initialValue: bookProxy.description,
                          parentContext: context,
                        );
                        di<BookManager>().updateLibraryBookAndBookProperties(
                          isbn: bookProxy.isbn,
                          libraryId: bookProxy.libraryId,
                          description: description,
                        );
                      },
                      child: Text(
                        bookProxy.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.interactiveColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: books
                      .fold<List<LibraryBookProxy>>([], (uniqueBooks, book) {
                        // Only add if libraryId is not already in the list
                        if (!uniqueBooks.any(
                          (existing) => existing.libraryId == book.libraryId,
                        )) {
                          uniqueBooks.add(book);
                        }
                        return uniqueBooks;
                      })
                      .map((book) {
                        return LibraryBookCard(libraryBookProxy: book);
                      })
                      .toList(),
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
