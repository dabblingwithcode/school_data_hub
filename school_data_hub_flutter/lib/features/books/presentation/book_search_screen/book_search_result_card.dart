import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/isbn_extensions.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tag.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_screen/widgets/library_book_card.dart';

class BookSearchResultCard extends WatchingWidget {
  final List<LibraryBookProxy> group;

  const BookSearchResultCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    if (group.isEmpty) return const SizedBox.shrink();

    final List<LibraryBookProxy> books = group;
    final LibraryBookProxy bookProxy = books.first;
    final descriptionTileController = createOnce<ExpansionController>(
      () => ExpansionController(),
    );
    return CardBox(
      padding: EdgeInsets.only(top: Style.spacing.sm, bottom: Style.spacing.sm),
      child: _BookSearchResultContent(
        bookProxy: bookProxy,
        books: books,
        descriptionTileController: descriptionTileController,
      ),
    );
  }
}

/// Rebuilds only when [bookProxy] (library book data) changes.
class _BookSearchResultContent extends WatchingWidget {
  final LibraryBookProxy bookProxy;
  final List<LibraryBookProxy> books;
  final ExpansionController descriptionTileController;

  const _BookSearchResultContent({
    required this.bookProxy,
    required this.books,
    required this.descriptionTileController,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    watch(bookProxy);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: InkWell(
            onTap: () {
              context.push(RoutePaths.learningBooksEdit, extra: bookProxy);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Style.spacing.lg),
                  child: Text(
                    bookProxy.title,
                    style: context.typography.subtitle.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: Style.spacing.lg,
            right: Style.spacing.md,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(bookProxy.author, style: context.typography.bodySmall),
              ],
            ),
          ),
        ),
        const Gap(5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Style.spacing.lg),
              child: KeyedSubtree(
                key: ValueKey(bookProxy.imagePath),
                child: UnencryptedImageInCard(
                  cacheKey: bookProxy.isbn.toString(),
                  path: bookProxy.imagePath,
                  type: UnencryptedImageType.book,
                  size: 100,
                ),
              ),
            ),
            Gap(Style.spacing.lg),
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
                          style: context.typography.body.bold.withColor(
                            style.colors.foreground,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('LeseStufe:'),
                        const Gap(10),
                        Text(
                          bookProxy.readingLevel ?? ReadingLevel.notSet.value,
                          overflow: TextOverflow.fade,
                          style: context.typography.body.bold.withColor(
                            style.colors.foreground,
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
                          Text(
                            'Keine Tags',
                            style: context.typography.bodySmall.copyWith(
                              color: style.colors.mutedForeground,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        else
                          for (final tag in bookProxy.bookTags) ...[
                            const Gap(5),
                            Tag(label: tag.name, color: style.colors.accent),
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Style.spacing.lg),
          child: ExpansionHeader(
            expansionController: descriptionTileController,
            includeSwitch: true,
            switchColor: style.colors.accent,
            expansionSwitchWidget: Text(
              'Beschreibung:',
              style: context.typography.body.bold.withColor(
                style.colors.foreground,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Style.spacing.lg),
          child: ExpansionBody(
            tileController: descriptionTileController,
            widgetList: [
              InkWell(
                onTap: () async {
                  final result = await longTextFieldDialog(
                    title: 'Beschreibung',
                    labelText: 'Beschreibung',
                    initialValue: bookProxy.description,
                    parentContext: context,
                  );
                  if (result == null || result.value == bookProxy.description) {
                    return;
                  }
                  di<BookManager>().updateLibraryBookAndBookProperties(
                    isbn: bookProxy.isbn,
                    libraryId: bookProxy.libraryId,
                    description: result.value,
                  );
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(right: Style.spacing.lg),
                    child: Text(
                      bookProxy.description,
                      style: context.typography.body.withColor(
                        style.colors.accent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: books
              .fold<List<LibraryBookProxy>>([], (uniqueBooks, book) {
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
    );
  }
}
