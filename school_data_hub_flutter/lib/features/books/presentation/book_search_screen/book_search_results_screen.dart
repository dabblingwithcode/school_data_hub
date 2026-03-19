import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/spinner.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:flutter_it/flutter_it.dart';

import '../../domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'book_search_result_card.dart';

class BookSearchResultsScreen extends WatchingWidget {
  final String? title;
  final String? author;
  final String? keywords;
  final LibraryBookLocation? location;
  final String? readingLevel;
  final BorrowedStatus? borrowStatus;
  final List<BookTag> selectedTags;

  const BookSearchResultsScreen({
    super.key,
    this.title,
    this.author,
    this.keywords,
    this.location,
    this.readingLevel,
    this.borrowStatus,
    this.selectedTags = const [],
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final bookManager = di<BookManager>();
    final scrollController = createOnce(() => ScrollController());

    callOnce((context) {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 300 &&
            !bookManager.isLoadingMore) {
          bookManager.loadNextPage(
            title: title,
            author: author,
            keywords: keywords,
            location: location,
            readingLevel: readingLevel,
            available: borrowStatus == BorrowedStatus.available
                ? true
                : borrowStatus == BorrowedStatus.borrowed
                ? false
                : null,
            tags: selectedTags.isNotEmpty ? selectedTags : null,
          );
        }
      });
    });

    final searchResults = watchValue((BookManager x) => x.searchResults);

    return Scaffold(
      appBar: const AppHeader(
        iconData: Icons.search,
        title: 'Suchergebnisse',
      ),
      body: searchResults.isEmpty
          ? const Center(child: Text("Keine Ergebnisse"))
          : Builder(
              builder: (context) {
                final groupedMap = groupBy(
                  searchResults,
                  (LibraryBookProxy book) => book.isbn,
                );
                final groups = groupedMap.values.toList();

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount:
                          groups.length + (bookManager.hasMorePages ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < groups.length) {
                          final group = groups[index];
                          if (group.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return BookSearchResultCard(group: group);
                        } else {
                          if (bookManager.hasMorePages &&
                              bookManager.isLoadingMore) {
                            return Padding(
                              padding: EdgeInsets.all(Style.spacing.lg),
                              child: Center(
                                child: Spinner(
                                  color: style.colors.accent,
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: const ActionBar(),
    );
  }
}
