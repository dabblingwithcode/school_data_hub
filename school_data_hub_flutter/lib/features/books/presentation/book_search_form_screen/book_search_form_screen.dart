import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
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

  InputDecoration _inputDecoration(
    Style style, {
    String? hintText,
    String? labelText,
  }) {
    return InputDecoration(
      fillColor: style.colors.background,
      filled: true,
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(Style.radii.medium),
      ),
      hintText: hintText,
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final locations = watchValue((BookManager x) => x.locations);
    final List<LibraryBookLocation> locationItems = [
      LibraryBookLocation(location: "Alle Räume"),
      ...locations.where((loc) => loc.location != "Alle Räume"),
    ];
    selectedLocation = locationItems.firstWhere(
      (loc) => loc.location == selectedLocation?.location,
      orElse: () => locationItems.first,
    );

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(iconData: Icons.search, title: 'Bücher suchen'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Style.spacing.sm),
            child: Column(
              children: [
                Gap(Style.spacing.sm),
                TextField(
                  controller: titleSearchController,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(
                    style,
                    hintText: 'Titel des Buches',
                  ),
                ),
                Gap(Style.spacing.sm),
                TextField(
                  controller: authorSearchController,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(style, hintText: 'Autor'),
                ),
                Gap(Style.spacing.sm),
                TextField(
                  controller: keywordsSearchController,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(style, hintText: 'Schlagwörter'),
                ),
                Gap(Style.spacing.sm),
                CardBox(
                  padding: EdgeInsets.all(Style.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              selectedBookTags.isEmpty
                                  ? 'Keine Schlagwörter ausgewählt!'
                                  : 'Ausgewählte Schlagwörter:',
                              style: selectedBookTags.isEmpty
                                  ? context.typography.body.withColor(
                                      style.colors.mutedForeground,
                                    )
                                  : context.typography.body.w500.withColor(
                                      style.colors.accent,
                                    ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (selectedBookTags.isNotEmpty)
                                TappableIcon(
                                  tooltip: 'Alle Schlagwörter entfernen',
                                  icon: Icon(
                                    Icons.clear,
                                    color: style.colors.error,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedBookTags = [];
                                    });
                                  },
                                ),
                              TappableIcon(
                                tooltip: 'Schlagwörter auswählen',
                                icon: Icon(
                                  Icons.add,
                                  color: style.colors.accent,
                                ),
                                onPressed: () async {
                                  final result = await Navigator.of(context)
                                      .push<List<BookTag>>(
                                        MaterialPageRoute<List<BookTag>>(
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
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (selectedBookTags.isNotEmpty) ...[
                        Gap(Style.spacing.sm),
                        Wrap(
                          spacing: Style.spacing.sm,
                          runSpacing: Style.spacing.sm,
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
                Gap(Style.spacing.sm),
                DropdownButtonFormField<LibraryBookLocation>(
                  value: selectedLocation,
                  decoration: _inputDecoration(style, labelText: 'Ablageort'),
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
                Gap(Style.spacing.sm),
                TextField(
                  controller: levelSearchController,
                  textInputAction: TextInputAction.done,
                  decoration: _inputDecoration(style, hintText: 'Lesestufe'),
                ),
                Gap(Style.spacing.sm),
                DropdownButtonFormField<BorrowedStatus>(
                  initialValue: BorrowedStatus.all,
                  decoration: _inputDecoration(style, labelText: 'Status'),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ActionBar(
        actions: [
          TappableIcon(
            tooltip: 'Suchen',
            icon: const Icon(Icons.search, size: 35),
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
                available: selectedBorrowStatus == BorrowedStatus.available
                    ? true
                    : selectedBorrowStatus == BorrowedStatus.borrowed
                    ? false
                    : null,
                tags: selectedBookTags.isNotEmpty ? selectedBookTags : null,
              );
              if (!context.mounted) return;
              Navigator.of(context, rootNavigator: true).push(
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
          ),
        ],
      ),
    );
  }
}
