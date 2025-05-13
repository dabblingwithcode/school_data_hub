import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/books/data/book_api_service.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
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
  const NewBook(
      {required this.isEdit,
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
      super.key});

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
    final Book bookData = await BookApiService().fetchBookByIsbn(widget.isbn);

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
    final String? scannedBookId =
        await qrScanner(context: context, overlayText: 'Bücherei-Id scannen');

    if (scannedBookId == null) {
      di<NotificationService>()
          .showSnackBar(NotificationType.error, 'Fehler beim Scannen');
      return;
    }
    final bookId = scannedBookId.replaceFirst('Buch ID: ', '').trim();
    bookIdTextFieldController.text = bookId;
  }

  final List<DropdownMenuItem<LibraryBookLocation>> locationDropdownItems = [];

  void _createDropdownItems() {
    for (final location in di<BookManager>().locations.value) {
      locationDropdownItems.add(DropdownMenuItem(
        value: location,
        child: Text(location.location),
      ));
    }

    locationDropdownItems.add(DropdownMenuItem(
      value: di<BookManager>().lastLocationValue.value,
      child: Text(
        di<BookManager>().lastLocationValue.value.location,
        style: const TextStyle(color: Colors.red),
      ),
    ));
  }

  void addLocation() async {
    final String? newLocation = await shortTextfieldDialog(
        context: context,
        title: 'Neuer Ablageort',
        labelText: 'Ablageort hinzufügen',
        hintText: 'Name des Ablageorts');
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

  void submitBook() {
    if (!validateRequestDataPayload()) {
      return;
    }

    if (widget.isEdit) {
      // Update the book
      di<BookManager>().updateBookProperty(
        isbn: widget.isbn,
        libraryId: widget.libraryId!,
        title: bookTitleTextFieldController.text,
        description: bookDescriptionTextFieldController.text,
        readingLevel: readingLevel,
        author: authorTextFieldController.text,
      );
    } else {
      // Create a new book
      di<BookManager>().postLibraryBook(
        isbn: widget.isbn,
        libraryId: bookIdTextFieldController.text,
        location: lastLocationValue,
      );
    }
    Navigator.pop(context);
  }

  bool validateRequestDataPayload() {
    if (bookIdTextFieldController.text.isEmpty) {
      di<NotificationService>().showSnackBar(NotificationType.error,
          'Bitte scannen Sie die Bücherei-Id oder tippen Sie sie ein!');

      return false;
    }
    if (bookTitleTextFieldController.text.isEmpty) {
      di<NotificationService>().showSnackBar(
          NotificationType.error, 'Bitte geben Sie den Buchtitel ein!');

      return false;
    }
    if (lastLocationValue == 'Bitte auswählen') {
      di<NotificationService>().showSnackBar(
          NotificationType.error, 'Bitte wählen Sie den Ablageort aus!');

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
