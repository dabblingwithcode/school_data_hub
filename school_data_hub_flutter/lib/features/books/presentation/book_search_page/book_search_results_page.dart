import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:watch_it/watch_it.dart';

import '../../domain/models/book_proxy.dart';
import '../book_list_page/widgets/book_list_bottom_navbar.dart';
import 'book_search_result_card.dart';

class BookSearchResultsPage extends WatchingWidget {
  final String? title;
  final String? author;
  final String? keywords;
  final String? location;
  final String? readingLevel;
  final String? borrowStatus;

  const BookSearchResultsPage({
    super.key,
    this.title,
    this.author,
    this.keywords,
    this.location,
    this.readingLevel,
    this.borrowStatus,
  });

  @override
  Widget build(BuildContext context) {
    final bookManager = di<BookManager>();
    final ScrollController scrollController = ScrollController();

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
          borrowStatus: borrowStatus,
        );
      }
    });

    return Scaffold(
      appBar:
          const GenericAppBar(iconData: Icons.search, title: 'Suchergebnisse'),
      body: ValueListenableBuilder<List<BookProxy>>(
        valueListenable: bookManager.searchResults,
        builder: (context, searchResults, _) {
          if (searchResults.isEmpty) {
            return const Center(child: Text("Keine Ergebnisse"));
          }

          final groupedMap =
              groupBy(searchResults, (BookProxy book) => book.isbn);
          final groups = groupedMap.values.toList();

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView.builder(
                controller: scrollController,
                itemCount: groups.length + (bookManager.hasMorePages ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < groups.length) {
                    final group = groups[index];
                    if (group.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return SearchResultBookCard(group: group);
                  } else {
                    if (bookManager.hasMorePages && bookManager.isLoadingMore) {
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
