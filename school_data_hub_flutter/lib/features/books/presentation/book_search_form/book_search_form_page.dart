import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/book_list_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

class BookSearchFormPage extends StatefulWidget {
  const BookSearchFormPage({super.key});

  @override
  State<BookSearchFormPage> createState() => _BookSearchFormPageState();
}

class _BookSearchFormPageState extends State<BookSearchFormPage> {
  final titleSearchController = TextEditingController();
  final authorSearchController = TextEditingController();
  final keywordsSearchController = TextEditingController();
  final levelSearchController = TextEditingController();

  BorrowedStatus? selectedBorrowStatus;
  LibraryBookLocation? selectedLocation;
  List<BookTag> selectedBookTags = [];
  final BookManager bookManager = di<BookManager>();

  @override
  void dispose() {
    titleSearchController.dispose();
    authorSearchController.dispose();
    keywordsSearchController.dispose();
    levelSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.search,
        title: 'Bücher suchen',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedBookTags.isEmpty
                                          ? 'Keine Schlagwörter ausgewählt!'
                                          : 'Ausgewählte Schlagwörter:',
                                      style: TextStyle(
                                        color: selectedBookTags.isEmpty
                                            ? Colors.grey[600]
                                            : AppColors.interactiveColor,
                                        fontWeight: selectedBookTags.isEmpty
                                            ? FontWeight.normal
                                            : FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (selectedBookTags.isNotEmpty)
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedBookTags = [];
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.clear,
                                              color: Colors.red,
                                            ),
                                            tooltip:
                                                'Alle Schlagwörter entfernen',
                                          ),
                                        IconButton(
                                          onPressed: () async {
                                            final result = await context
                                                .push<List<BookTag>>(
                                                  '/learning/books/select-tags',
                                                  extra: selectedBookTags,
                                                );
                                            if (result != null) {
                                              setState(() {
                                                selectedBookTags = result;
                                              });
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: AppColors.interactiveColor,
                                          ),
                                          tooltip: 'Schlagwörter auswählen',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (selectedBookTags.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: selectedBookTags.map((tag) {
                                      return FilterChip(
                                        label: Text(tag.name),
                                        selected: true,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            selectedBookTags = selectedBookTags
                                                .where(
                                                  (selectedTag) =>
                                                      selectedTag.id != tag.id,
                                                )
                                                .toList();
                                          });
                                        },
                                        selectedColor: AppColors
                                            .interactiveColor
                                            .withValues(alpha: 0.2),
                                        checkmarkColor:
                                            AppColors.interactiveColor,
                                        deleteIcon: const Icon(
                                          Icons.close,
                                          size: 18,
                                          color: AppColors.interactiveColor,
                                        ),
                                        onDeleted: () {
                                          setState(() {
                                            selectedBookTags = selectedBookTags
                                                .where(
                                                  (selectedTag) =>
                                                      selectedTag.id != tag.id,
                                                )
                                                .toList();
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            ValueListenableBuilder<List<LibraryBookLocation>>(
                              valueListenable: bookManager.locations,
                              builder: (context, locations, _) {
                                final List<LibraryBookLocation> locationItems =
                                    [
                                      LibraryBookLocation(
                                        location: "Alle Räume",
                                      ),
                                      ...locations.where(
                                        (loc) => loc.location != "Alle Räume",
                                      ),
                                    ];
                                selectedLocation ??= locationItems.first;

                                return DropdownButtonFormField<
                                  LibraryBookLocation
                                >(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: 'Ablageort',
                                  ),
                                  items: locationItems
                                      .map(
                                        (loc) =>
                                            DropdownMenuItem<
                                              LibraryBookLocation
                                            >(
                                              value: loc,
                                              child: Text(loc.location),
                                            ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedLocation = value;
                                    });
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: AppColors.successButtonColor,
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
                      tags: selectedBookTags.isNotEmpty
                          ? selectedBookTags
                          : null,
                    );
                    context.push(
                      '/learning/books/search-results',
                      extra: {
                        'title': title,
                        'author': author,
                        'keywords': keywords,
                        'location': selectedLocation?.location == "Alle Räume"
                            ? null
                            : selectedLocation!,
                        'readingLevel': readingLevel,
                        'borrowStatus': selectedBorrowStatus,
                        'selectedTags': selectedBookTags,
                      },
                    );
                  },
                  child: const Text('SUCHEN', style: AppStyles.buttonTextStyle),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BookListBottomNavBar(),
    );
  }
}
