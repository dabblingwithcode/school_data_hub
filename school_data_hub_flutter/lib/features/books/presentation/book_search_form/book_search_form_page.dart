import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/book_list_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_page/book_search_results_page.dart';
import 'package:watch_it/watch_it.dart';

class BookSearchFormPage extends WatchingWidget {
  const BookSearchFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleSearchController =
        createOnce<TextEditingController>(() => TextEditingController());
    final authorSearchController =
        createOnce<TextEditingController>(() => TextEditingController());
    final keywordsSearchController =
        createOnce<TextEditingController>(() => TextEditingController());
    final levelSearchController =
        createOnce<TextEditingController>(() => TextEditingController());

    BorrowedStatus? selectedBorrowStatus;

    LibraryBookLocation? selectedLocation;
    final bookManager = di<BookManager>();

    return Scaffold(
      appBar:
          const GenericAppBar(iconData: Icons.search, title: 'Bücher suchen'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: titleSearchController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Titel des Buches',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: authorSearchController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Autor',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: keywordsSearchController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Schlagwörter',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ValueListenableBuilder<List<LibraryBookLocation>>(
                    valueListenable: bookManager.locations,
                    builder: (context, locations, _) {
                      final List<LibraryBookLocation> locationItems = [
                        LibraryBookLocation(location: "Alle Räume"),
                        ...locations
                      ];
                      selectedLocation ??= locationItems.first;

                      return DropdownButtonFormField<LibraryBookLocation>(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Ablageort',
                        ),
                        value: selectedLocation,
                        items: locationItems
                            .map(
                              (loc) => DropdownMenuItem<LibraryBookLocation>(
                                value: loc,
                                child: Text(loc.location),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          selectedLocation = value;
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: levelSearchController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Lesestufe',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<BorrowedStatus>(
                    value: BorrowedStatus.all,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Status',
                    ),
                    items: BorrowedStatus.values
                        .map(
                          (status) => DropdownMenuItem<BorrowedStatus>(
                            value: status,
                            child: Text(status.value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      selectedBorrowStatus = value;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: AppColors.backgroundColor,
                    minimumSize: const Size.fromHeight(60),
                  ),
                  onPressed: () async {
                    final title = titleSearchController.text;
                    final author = authorSearchController.text;
                    final keywords = keywordsSearchController.text;
                    final readingLevel = levelSearchController.text;

                    await bookManager.searchBooks(
                      title: title,
                      author: author,
                      keywords: keywords,
                      location: selectedLocation?.location == "Alle Räume"
                          ? null
                          : selectedLocation!,
                      readingLevel: readingLevel,
                      available:
                          selectedBorrowStatus == BorrowedStatus.available
                              ? true
                              : selectedBorrowStatus == BorrowedStatus.borrowed
                                  ? false
                                  : null,
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BookSearchResultsPage(
                          title: title,
                          author: author,
                          keywords: keywords,
                          location: selectedLocation?.location == "Alle Räume"
                              ? null
                              : selectedLocation!,
                          readingLevel: readingLevel,
                          borrowStatus: selectedBorrowStatus),
                    ));
                  },
                  child: const Text(
                    'SUCHEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BookListBottomNavBar(),
    );
  }
}
