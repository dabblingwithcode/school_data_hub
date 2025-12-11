import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/books/data/book_api_service.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_page/new_book_page.dart';
import 'package:watch_it/watch_it.dart';

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
    super.key,
  });

  @override
  NewBookController createState() => NewBookController();
}

class NewBookController extends State<NewBook> {
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

  LibraryBookLocation lastLocationValue =
      di<BookManager>().lastLocationValue.value;

  String readingLevel = ReadingLevel.notSet.value;

  String? imagePath;

  void switchBookTagSelection(BookTag tag) {
    setState(() {
      bookTagSelection[tag] = !bookTagSelection[tag]!;
    });
  }

  Future<void> fetchBookData() async {
    final Book? bookData = await BookApiService().fetchBookByIsbn(widget.isbn);
    // TODO BUG BOMB: We need to handle possible errors here, e.g. if the book is not found
    bookTitleTextFieldController.text = bookData!.title;
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
    if (widget.isEdit) {
      bookIdTextFieldController.text = widget.libraryId ?? '';
      bookTitleTextFieldController.text = widget.bookTitle ?? '';
      authorTextFieldController.text = widget.bookAuthor ?? '';
      lastLocationValue =
          widget.location ?? di<BookManager>().lastLocationValue.value;
      readingLevel = widget.bookReadingLevel ?? ReadingLevel.notSet.value;

      bookDescriptionTextFieldController.text = widget.bookDescription ?? '';
    }

    for (var tag in di<BookManager>().bookTags.value) {
      bookTagSelection[tag] = false;
    }
  }

  void onChangedReadingLevelDropDown(ReadingLevel? value) {
    setState(() {
      readingLevel = value!.value;
    });
  }

  void onChangedLocationDropDown(LibraryBookLocation value) {
    setState(() {
      lastLocationValue = value;
      di<BookManager>().setLastLocationValue(value);
    });
  }

  Future<void> scanBookId() async {
    final String? scannedBookId = await qrScanner(
      context: context,
      overlayText: 'Bücherei-Id scannen',
    );

    if (scannedBookId == null) {
      di<NotificationService>().showSnackBar(
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
    final lastLocation = di<BookManager>().lastLocationValue.value;

    // Remove duplicates from the list first (based on ID/content equality)
    // We can use a Set, but we need equality operator on LibraryBookLocation first.
    // Assuming we added equality operator in the model.
    final uniqueLocations = allLocations.toSet().toList();

    locationDropdownItems.clear();

    // Check if lastLocation is already in the list
    final isLastLocationInList = uniqueLocations.any(
      (location) => location == lastLocation,
    );

    // Add all locations from the unique list
    for (final location in uniqueLocations) {
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

      // Check if current selection still exists, if not, reset or select default
      // We check if the lastLocationValue exists in the updated items by comparing IDs/Objects
      // Since objects might be new instances, we might need robust check.
      // But _createDropdownItems adds the *current* lastLocationValue if missing.
      // So effectively, lastLocationValue is always "valid" in the sense that it's in the list.
      // BUT: The error says "Either zero or 2 or more ... detected".
      // This implies duplication in the items list OR that the value passed to DropdownButton
      // matches multiple items in the list.
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
      di<NotificationService>().showSnackBar(
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
      MaterialPageRoute(builder: (context) => const BookTagManagement()),
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
    if (bookTags.isNotEmpty) {
      await di<BookManager>().updateBookTags(widget.isbn, bookTags);
    }

    Navigator.pop(context);
  }

  bool validateRequestDataPayload() {
    if (bookIdTextFieldController.text.isEmpty) {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Bitte scannen Sie die Bücherei-Id oder tippen Sie sie ein!',
      );

      return false;
    }
    if (bookTitleTextFieldController.text.isEmpty) {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Bitte geben Sie den Buchtitel ein!',
      );

      return false;
    }
    if (lastLocationValue == 'Bitte auswählen') {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Bitte wählen Sie den Ablageort aus!',
      );

      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NewBookPage(this);
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
