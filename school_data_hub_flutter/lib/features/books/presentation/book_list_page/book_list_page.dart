import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/book_card.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/book_list_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_search_text_field.dart';
import 'package:watch_it/watch_it.dart';

class BookListPage extends WatchingWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
    final Map<int, List<LibraryBookProxy>> isbnBooks =
        watchValue((BookManager x) => x.isbnLibraryBooksMap);

    //List<Book> books = watchValue((BookManager x) => x.books);
    callOnce((context) async {
      await di<BookManager>().fetchLibraryBooks();
    });
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_alt_rounded,
              size: 25,
              color: Colors.white,
            ),
            Gap(10),
            Text(
              'Bücherei',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<BookManager>().fetchLibraryBooks(),
        child: isbnBooks.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Es wurden noch keine Bücher angelegt!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 15.0, right: 10.00),
                        child: Row(
                          children: [
                            const Text(
                              'Gesamt:',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              isbnBooks.length.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: PupilSearchTextField(
                                searchType: SearchType.workbook,
                                hintText: 'Buch suchen',
                                //TODO: Add refresh function
                                refreshFunction: () => (),
                              ),
                            ),
                            //---------------------------------
                            InkWell(
                              onTap: () {},

                              onLongPress: () =>
                                  di<FiltersStateManager>().resetFilters(),
                              // onPressed: () => showBottomSheetFilters(context),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.filter_list,
                                  color: filtersOn
                                      ? Colors.deepOrange
                                      : Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      isbnBooks.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Keine Ergebnisse',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: isbnBooks.keys.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final isbn = isbnBooks.keys.elementAt(index);

                                  return BookCard(isbn: isbn);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: const BookListBottomNavBar(),
    );
  }
}
