import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/books/data/book_api_service.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_screen/book_tag_management_controller.dart';
import 'package:school_data_hub_flutter/features/books/presentation/edit_book_screen/book_tag_selection_screen.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_screen/new_book_screen.dart';

class NewBook extends WatchingStatefulWidget {
  final String? bookTitle;
  final int isbn;
  final String? libraryId;
  final String? bookAuthor;
  final String? bookDescription;
  final String? bookImageId;
  final String? bookReadingLevel;
  final LibraryBookLocation? location;
  final bool? bookAvailable;
  final String? imageId;
  final bool isEdit;
  final List<BookTagging>? bookTags;
  const NewBook({
    required this.isEdit,
    this.bookTitle,
    required this.isbn,
    this.libraryId,
    this.bookAuthor,
    this.bookDescription,
    this.bookImageId,
    this.bookReadingLevel,
    this.location,
    this.bookAvailable,
    this.imageId,
    this.bookTags,
    super.key,
  });

  @override
  NewBookController createState() => NewBookController();
}

class NewBookController extends State<NewBook> {
  static LibraryBookLocation _lastLocation = LibraryBookLocation(
    location: 'Bitte auswählen',
  );

  final TextEditingController bookIdTextFieldController =
      TextEditingController();

  final TextEditingController bookTitleTextFieldController =
      TextEditingController();

  final TextEditingController authorTextFieldController =
      TextEditingController();

  final TextEditingController bookDescriptionTextFieldController =
      TextEditingController();

  final List<DropdownMenuItem<ReadingLevel>> readingLevelDropdownItems = [
    DropdownMenuItem(
      value: ReadingLevel.beginner,
      child: Text(ReadingLevel.beginner.value),
    ),
    DropdownMenuItem(
      value: ReadingLevel.easy,
      child: Text(ReadingLevel.easy.value),
    ),
    DropdownMenuItem(
      value: ReadingLevel.medium,
      child: Text(ReadingLevel.medium.value),
    ),
    DropdownMenuItem(
      value: ReadingLevel.hard,
      child: Text(ReadingLevel.hard.value),
    ),
    DropdownMenuItem(
      value: ReadingLevel.notSet,
      child: Text(ReadingLevel.notSet.value),
    ),
  ];

  final List<BookTag> bookTags = di<BookManager>().bookTags.value;

  Map<BookTag, bool> bookTagSelection = {};

  final List<LibraryBookLocation> locations = di<BookManager>().locations.value;

  LibraryBookLocation lastLocationValue = _lastLocation;

  String readingLevel = ReadingLevel.notSet.value;

  String? imagePath;

  void switchBookTagSelection(BookTag tag) {
    setState(() {
      bookTagSelection[tag] = !bookTagSelection[tag]!;
    });
  }

  Future<void> fetchBookData() async {
    final Book? bookData = await BookApiService().fetchBookByIsbn(widget.isbn);
    if (bookData == null || !mounted) return;
    bookTitleTextFieldController.text = bookData.title;
    authorTextFieldController.text = bookData.author;
    bookDescriptionTextFieldController.text = bookData.description;

    setState(() {
      readingLevel = bookData.readingLevel ?? ReadingLevel.notSet.value;
      imagePath = bookData.imagePath;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBookData();
    _createDropdownItems();
    // Ensure lastLocationValue uses the exact instance from the dropdown items
    // (LibraryBookLocation doesn't override == / hashCode)
    lastLocationValue = _findMatchingLocation(lastLocationValue);
    if (widget.isEdit) {
      bookIdTextFieldController.text = widget.libraryId ?? '';
      bookTitleTextFieldController.text = widget.bookTitle ?? '';
      authorTextFieldController.text = widget.bookAuthor ?? '';

      // Find the matching location instance from the dropdown items
      // to avoid identity mismatch (LibraryBookLocation doesn't override ==)
      final widgetLocation = widget.location ?? _lastLocation;
      lastLocationValue = _findMatchingLocation(widgetLocation);

      readingLevel = widget.bookReadingLevel ?? ReadingLevel.notSet.value;

      bookDescriptionTextFieldController.text = widget.bookDescription ?? '';
      for (final BookTagging tag in widget.bookTags ?? []) {
        bookTagSelection[tag.bookTag!] = true;
      }
    }
  }

  /// Finds the matching [LibraryBookLocation] instance from [locationDropdownItems]
  /// by comparing [id]. This is necessary because [LibraryBookLocation] (Serverpod
  /// generated) doesn't override == / hashCode, so the dropdown requires the exact
  /// same object instance.
  LibraryBookLocation _findMatchingLocation(LibraryBookLocation target) {
    for (final item in locationDropdownItems) {
      if (item.value?.id == target.id) {
        return item.value!;
      }
    }
    // Fallback: return the target itself (will be added by _createDropdownItems
    // if not already present)
    return target;
  }

  void onChangedReadingLevelDropDown(ReadingLevel? value) {
    setState(() {
      readingLevel = value!.value;
    });
  }

  void onChangedLocationDropDown(LibraryBookLocation value) {
    setState(() {
      lastLocationValue = value;
      _lastLocation = value;
    });
  }

  Future<void> scanBookId() async {
    final String? scannedBookId = await qrScanner(
      context: context,
      overlayText: 'Bücherei-Id scannen',
    );

    if (scannedBookId == null) {
      di<NotificationManager>().showSnackBar(
        NotificationType.error,
        'Fehler beim Scannen',
      );
      return;
    }
    final bookId = scannedBookId.replaceFirst('Buch ID: ', '').trim();
    bookIdTextFieldController.text = bookId;
  }

  final List<DropdownMenuItem<LibraryBookLocation>> locationDropdownItems = [];

  void _createDropdownItems() {
    final allLocations = di<BookManager>().locations.value.toList();
    final lastLocation = _lastLocation;

    // Check if lastLocation is already in the list to avoid duplicates
    final isLastLocationInList = allLocations.any(
      (location) => location.id == lastLocation.id,
    );

    // Add all locations from the list
    for (final location in allLocations) {
      locationDropdownItems.add(
        DropdownMenuItem(value: location, child: Text(location.location)),
      );
    }

    // Only add lastLocation if it's not already in the list
    if (!isLastLocationInList) {
      locationDropdownItems.add(
        DropdownMenuItem(
          value: lastLocation,
          child: Text(
            lastLocation.location,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  void addLocation() async {
    final String? newLocation = await shortTextfieldDialog(
      context: context,
      title: 'Neuer Ablageort',
      labelText: 'Ablageort hinzufügen',
      hintText: 'Name des Ablageorts',
    );
    if (newLocation != null) {
      await di<BookManager>().postLocation(newLocation);
    }
    setState(() {
      locations.clear();
      locations.addAll(di<BookManager>().locations.value);
      locationDropdownItems.clear();
      _createDropdownItems();
    });
  }

  void createNewTag(BuildContext context) async {
    final String? newTagName = await shortTextfieldDialog(
      context: context,
      title: 'Neues Buch-Tag erstellen',
      labelText: 'Tag-Name',
      hintText: 'Name des neuen Tags eingeben',
    );

    if (newTagName != null && newTagName.trim().isNotEmpty) {
      await di<BookManager>().postBookTag(newTagName.trim());
      di<NotificationManager>().showSnackBar(
        NotificationType.success,
        'Tag "$newTagName" wurde erfolgreich erstellt',
      );

      // Refresh the book tags
      await di<BookManager>().fetchBookTags();
      setState(() {
        bookTagSelection.clear();
        for (var tag in di<BookManager>().bookTags.value) {
          bookTagSelection[tag] = false;
        }
      });
    }
  }

  void openTagManagement(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute<bool?>(builder: (context) => const BookTagManagement()),
    );

    // Refresh the book tags after returning from tag management
    if (result == true || result == null) {
      await di<BookManager>().fetchBookTags();
      setState(() {
        bookTagSelection.clear();
        for (var tag in di<BookManager>().bookTags.value) {
          bookTagSelection[tag] = false;
        }
      });
    }
  }

  Future<void> openBookTagSelectionPage(BuildContext context) async {
    final allTags = di<BookManager>().bookTags.value;
    final selectedTagIds = bookTagSelection.entries
        .where((e) => e.value)
        .map((e) => e.key.id!)
        .toSet();

    final result = await Navigator.push<Set<int>>(
      context,
      MaterialPageRoute<Set<int>>(
        builder: (context) => BookTagSelectionScreen(
          allTags: allTags,
          selectedTagIds: selectedTagIds,
        ),
      ),
    );

    if (result != null) {
      final freshTags = di<BookManager>().bookTags.value;
      setState(() {
        bookTagSelection = {
          for (final tag in freshTags) tag: result.contains(tag.id),
        };
      });
    }
  }

  Future<void> submitBook() async {
    if (!validateRequestDataPayload()) {
      return;
    }

    if (!widget.isEdit) {
      await di<BookManager>().postLibraryBook(
        isbn: widget.isbn,
        libraryId: bookIdTextFieldController.text,
        location: lastLocationValue,
      );
    }
    // Update the book
    di<BookManager>().updateLibraryBookAndBookProperties(
      isbn: widget.isbn,
      libraryId: bookIdTextFieldController.text,
      title: bookTitleTextFieldController.text,
      description: bookDescriptionTextFieldController.text,
      readingLevel: readingLevel,
      author: authorTextFieldController.text,
    );
    final selectedTags = bookTagSelection.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    if (selectedTags.isNotEmpty) {
      await di<BookManager>().updateBookTags(widget.isbn, selectedTags);
    }
    if (!context.mounted) return;
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  bool validateRequestDataPayload() {
    if (bookIdTextFieldController.text.isEmpty) {
      di<NotificationManager>().showSnackBar(
        NotificationType.error,
        'Bitte scannen Sie die Bücherei-Id oder tippen Sie sie ein!',
      );

      return false;
    }
    if (bookTitleTextFieldController.text.isEmpty) {
      di<NotificationManager>().showSnackBar(
        NotificationType.error,
        'Bitte geben Sie den Buchtitel ein!',
      );

      return false;
    }
    if (lastLocationValue == LibraryBookLocation(location: 'Bitte auswählen')) {
      di<NotificationManager>().showSnackBar(
        NotificationType.error,
        'Bitte wählen Sie den Ablageort aus!',
      );

      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NewBookScreen(this);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the tree

    bookIdTextFieldController.dispose();

    bookTitleTextFieldController.dispose();

    authorTextFieldController.dispose();

    bookDescriptionTextFieldController.dispose();

    super.dispose();
  }
}
