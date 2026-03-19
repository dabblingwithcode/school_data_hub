import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/content_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/spinner.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_screen/book_search_result_card.dart';

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
    final bookManager = di<BookManager>();

    final groupedResults =
        createOnce<ValueListenable<List<List<LibraryBookProxy>>>>(
          () => bookManager.searchResults.map(
            (results) => groupBy(
              results,
              (LibraryBookProxy book) => book.isbn,
            ).values.where((g) => g.isNotEmpty).toList(),
          ),
        );

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      appBar: const AppHeader(iconData: Icons.search, title: 'Suchergebnisse'),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - 300 &&
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
          return false;
        },
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                ContentSliverList<List<LibraryBookProxy>>(
                  itemsListenable: groupedResults,
                  itemBuilder: (context, group) =>
                      BookSearchResultCard(group: group),
                ),
                const _LoadingSliver(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ActionBar(),
    );
  }
}

class _LoadingSliver extends WatchingWidget {
  const _LoadingSliver();

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final bookManager = di<BookManager>();
    // Watch searchResults so this rebuilds after each page load;
    // hasMorePages/isLoadingMore are plain getters, not listenable.
    watchValue((BookManager x) => x.searchResults);

    if (bookManager.hasMorePages && bookManager.isLoadingMore) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(Style.spacing.lg),
          child: Center(child: Spinner(color: style.colors.accent)),
        ),
      );
    }
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}
