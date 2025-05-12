import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/library_book_card.dart';
import 'package:watch_it/watch_it.dart';

class SearchResultBookCard extends WatchingWidget {
  final List<BookProxy> group;

  const SearchResultBookCard({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (group.isEmpty) return const SizedBox.shrink();

    final List<BookProxy> books = group;
    final BookProxy book = books.first;
    final descriptionTileController = createOnce<ExpansionTileController>(
      () => ExpansionTileController(),
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
                    const Column(
                      children: [
                        SizedBox(height: 10),
                        const Gap(10),
                      ],

                      // TODOD: Repair when image loading is implemented
                      //  InkWell(
                      //   onTap: () async {
                      //     final File? file = await uploadImageFile(context);
                      //     if (file == null) return;
                      //     await locator<BookManager>()
                      //         .patchBookImage(file, book.isbn);
                      //   },
                      //   child: UnencryptedImageInCard(
                      //     documentImageData: DocumentImageData(
                      //       documentTag: book.imageId,
                      //       documentUrl:
                      //           '${locator<EnvManager>().env!.serverUrl}${BookApiService.getBookImageUrl(book.isbn)}',
                      //       size: 140,
                      //     ),
                      //   ),
                      // ),
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
                                    labelStyle: AppStyles.filterItemsTextStyle,
                                    label: Text(tag.name),
                                    backgroundColor: AppColors.backgroundColor,
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
        ),
      ),
    );
  }
}
