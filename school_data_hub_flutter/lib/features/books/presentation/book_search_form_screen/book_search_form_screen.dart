import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_form_screen/select_book_tags_screen.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_screen/book_search_results_screen.dart';

class BookSearchFormScreen extends WatchingStatefulWidget {
  const BookSearchFormScreen({super.key});

  @override
  State<BookSearchFormScreen> createState() => _BookSearchFormScreenState();
}

class _BookSearchFormScreenState extends State<BookSearchFormScreen> {
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
    final style = Style.of(context);
    final locations = watchValue((BookManager x) => x.locations);
    final List<LibraryBookLocation> locationItems = [
      LibraryBookLocation(location: "Alle Räume"),
      ...locations.where((loc) => loc.location != "Alle Räume"),
    ];
    selectedLocation ??= locationItems.first;

    return Scaffold(
      appBar: const AppHeader(
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
                        padding: EdgeInsets.all(Style.spacing.sm),
                        child: TextField(
                          controller: titleSearchController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            fillColor: style.colors.background,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(Style.radii.medium),
                            ),
                            hintText: 'Titel des Buches',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Style.spacing.sm),
                        child: TextField(
                          controller: authorSearchController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            fillColor: style.colors.background,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(Style.radii.medium),
                            ),
                            hintText: 'Autor',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Style.spacing.sm),
                        child: TextField(
                          controller: keywordsSearchController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            fillColor: style.colors.background,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(Style.radii.medium),
                            ),
                            hintText: 'Schlagwörter',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Style.spacing.sm),
                        child: Container(
                          decoration: BoxDecoration(
                            color: style.colors.background,
                            borderRadius: BorderRadius.circular(Style.radii.medium),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(Style.spacing.lg),
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
                                            ? style.colors.mutedForeground
                                            : style.colors.accent,
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
                                            icon: Icon(
                                              Icons.clear,
                                              color: style.colors.error,
                                            ),
                                            tooltip:
                                                'Alle Schlagwörter entfernen',
                                          ),
                                        IconButton(
                                          onPressed: () async {
                                            final result =
                                                await Navigator.of(
                                                  context,
                                                ).push<List<BookTag>>(
                                                  MaterialPageRoute<
                                                    List<BookTag>
                                                  >(
                                                    builder: (context) =>
                                                        SelectBookTagsScreen(
                                                          initialSelectedTags:
                                                              selectedBookTags,
                                                        ),
                                                  ),
                                                );
                                            if (result != null) {
                                              setState(() {
                                                selectedBookTags = result;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: style.colors.accent,
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
                                      return ThemedFilterChip(
                                        label: tag.name,
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
                        padding: EdgeInsets.all(Style.spacing.sm),
                        child: DropdownButtonFormField<LibraryBookLocation>(
                          decoration: InputDecoration(
                            fillColor: style.colors.background,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(Style.radii.medium),
                            ),
                            labelText: 'Ablageort',
                          ),
                          items: locationItems
                              .map(
                                (loc) => DropdownMenuItem<LibraryBookLocation>(
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Style.spacing.sm),
                        child: TextField(
                          controller: levelSearchController,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            fillColor: style.colors.background,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(Style.radii.medium),
                            ),
                            hintText: 'Lesestufe',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Style.spacing.sm),
                        child: DropdownButtonFormField<BorrowedStatus>(
                          initialValue: BorrowedStatus.all,
                          decoration: InputDecoration(
                            fillColor: style.colors.background,
                            filled: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(Style.radii.medium),
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
                child: Button(
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
                    if (!context.mounted) return;
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => BookSearchResultsScreen(
                          title: title,
                          author: author,
                          keywords: keywords,
                          location: selectedLocation?.location == "Alle Räume"
                              ? null
                              : selectedLocation!,
                          readingLevel: readingLevel,
                          borrowStatus: selectedBorrowStatus,
                          selectedTags: selectedBookTags,
                        ),
                      ),
                    );
                  },
                  label: 'SUCHEN',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ActionBar(),
    );
  }
}
