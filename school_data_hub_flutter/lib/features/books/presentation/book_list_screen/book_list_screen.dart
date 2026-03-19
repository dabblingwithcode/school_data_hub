import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_screen/widgets/book_card.dart';

class BookListScreen extends WatchingWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookManager = di<BookManager>();

    callOnce((context) async {
      await bookManager.fetchLibraryBooks();
    });

    final isbnKeysListenable = createOnce<ValueListenable<List<int>>>(
      () => bookManager.isbnLibraryBooksMap.map((m) => m.keys.toList()),
    );

    return ListScreen<int>(
      iconData: Icons.note_alt_rounded,
      title: 'Bücherei',
      backgroundColor: Style.of(context).colors.canvas,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: const _BookStatsWidget(),
        searchType: SearchType.workbook,
        hintText: 'Buch suchen',
        refreshFunction: () {},
        onChanged: (value) =>
            di<PupilsFilter>().textFilter.setFilterText(value),
        filtersActive: di<FiltersStateManager>().filtersActive,
        onResetFilters: di<FiltersStateManager>().resetFilters,
      ),
      itemsListenable: isbnKeysListenable,
      itemBuilder: (context, isbn) => BookCard(isbn: isbn),
      onRefresh: () => bookManager.fetchLibraryBooks(),
      emptyMessage: 'Es wurden noch keine Bücher angelegt!',
    );
  }
}

class _BookStatsWidget extends WatchingWidget {
  const _BookStatsWidget();

  @override
  Widget build(BuildContext context) {
    final isbnBooks = watchValue((BookManager x) => x.isbnLibraryBooksMap);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
      child: Row(
        children: [
          Text('Gesamt:', style: context.typography.bodySmall),
          const Gap(10),
          Text(
            isbnBooks.length.toString(),
            style: context.typography.title.bold,
          ),
        ],
      ),
    );
  }
}
