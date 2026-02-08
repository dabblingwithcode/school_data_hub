import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:flutter_it/flutter_it.dart';

import '../../domain/models/library_book_proxy.dart';
import '../book_list_page/widgets/book_list_bottom_navbar.dart';
import 'book_search_result_card.dart';

class BookSearchResultsPage extends WatchingWidget {
  final String? title;
  final String? author;
  final String? keywords;
  final LibraryBookLocation? location;
  final String? readingLevel;
  final BorrowedStatus? borrowStatus;
  final List<BookTag> selectedTags;

  const BookSearchResultsPage({
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
      appBar: const GenericAppBar(
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
                          return SearchResultBookCard(group: group);
                        } else {
                          if (bookManager.hasMorePages &&
                              bookManager.isLoadingMore) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
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
      bottomNavigationBar: const BookListBottomNavBar(),
    );
  }
}
