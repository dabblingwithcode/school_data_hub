import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';
import 'package:school_data_hub_flutter/features/books/presentation/edit_book_page/edit_book_page.dart';
import 'package:watch_it/watch_it.dart';

class EditBook extends WatchingStatefulWidget {
  final LibraryBookProxy libraryBook;

  const EditBook({required this.libraryBook, super.key});

  @override
  EditBookController createState() => EditBookController();
}

class EditBookController extends State<EditBook> {
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
  LibraryBookLocation? selectedLocation;

  String readingLevel = ReadingLevel.notSet.value;
  String? imagePath;

  LibraryBookProxy get libraryBook => widget.libraryBook;

  void switchBookTagSelection(BookTag tag) {
    setState(() {
      bookTagSelection[tag] = !(bookTagSelection[tag] ?? false);
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeFormData();
    _createDropdownItems();
    _setSelectedLocation();
  }

  void _initializeFormData() {
    // Initialize form fields with current book data
    bookTitleTextFieldController.text = libraryBook.title;
    authorTextFieldController.text = libraryBook.author;
    bookDescriptionTextFieldController.text = libraryBook.description;
    readingLevel = libraryBook.readingLevel ?? ReadingLevel.notSet.value;
    imagePath = libraryBook.imagePath;

    // Initialize book tag selection
    _initializeBookTagSelection();
  }

  void _initializeBookTagSelection() {
    final currentBookTags = libraryBook.bookTags;
    final allBookTags = di<BookManager>().bookTags.value;

    // Debug logging
    print(
      'DEBUG: Current book tags: ${currentBookTags.map((t) => '${t.name} (id: ${t.id})').toList()}',
    );
    print(
      'DEBUG: All available tags: ${allBookTags.map((t) => '${t.name} (id: ${t.id})').toList()}',
    );

    // Clear and reinitialize the selection map
    bookTagSelection.clear();

    for (var tag in allBookTags) {
      // Compare by ID since BookTag doesn't have custom equality
      final isSelected = currentBookTags.any(
        (currentTag) => currentTag.id == tag.id,
      );
      bookTagSelection[tag] = isSelected;
      print('DEBUG: Tag ${tag.name} (id: ${tag.id}) -> selected: $isSelected');
    }

    print(
      'DEBUG: Final bookTagSelection: ${bookTagSelection.map((k, v) => MapEntry('${k.name} (id: ${k.id})', v))}',
    );
  }

  void _setSelectedLocation() {
    final currentLocation = libraryBook.location;
    final allLocations = di<BookManager>().locations.value;

    // Find the matching location in the dropdown items
    selectedLocation = allLocations.firstWhere(
      (location) => location.id == currentLocation.id,
      orElse:
          () => currentLocation, // Fallback to current location if not found
    );
  }

  void onChangedReadingLevelDropDown(ReadingLevel? value) {
    setState(() {
      readingLevel = value!.value;
    });
  }

  void onChangedLocationDropDown(LibraryBookLocation value) {
    setState(() {
      selectedLocation = value;
    });
  }

  final List<DropdownMenuItem<LibraryBookLocation>> locationDropdownItems = [];

  void _createDropdownItems() {
    // Clear existing items to avoid duplicates
    locationDropdownItems.clear();

    final allLocations = di<BookManager>().locations.value.toList();
    final currentLocation = libraryBook.location;

    // Create a set to track added locations by ID to prevent duplicates
    final addedLocationIds = <int>{};

    // Add all locations from the manager's list
    for (final location in allLocations) {
      if (!addedLocationIds.contains(location.id)) {
        locationDropdownItems.add(
          DropdownMenuItem(value: location, child: Text(location.location)),
        );
        addedLocationIds.add(location.id!);
      }
    }

    // Only add current location if it's not already in the list
    if (!addedLocationIds.contains(currentLocation.id)) {
      locationDropdownItems.add(
        DropdownMenuItem(
          value: currentLocation,
          child: Text(
            currentLocation.location,
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
      setState(() {
        locations.clear();
        locations.addAll(di<BookManager>().locations.value);
        _createDropdownItems();
        _setSelectedLocation();
      });
    }
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
        _initializeBookTagSelection();
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
        _initializeBookTagSelection();
      });
    }
  }

  Future<void> submitBook() async {
    if (!validateRequestDataPayload()) {
      return;
    }

    // Get selected tags
    final selectedTags =
        bookTagSelection.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList();

    // Update the book properties
    await di<BookManager>().updateLibraryBookProperty(
      isbn: libraryBook.isbn,
      libraryId: libraryBook.libraryId,
      title: bookTitleTextFieldController.text,
      description: bookDescriptionTextFieldController.text,
      readingLevel: readingLevel,
      author: authorTextFieldController.text,
      location: selectedLocation,
      tags: selectedTags,
    );
  }

  bool validateRequestDataPayload() {
    if (bookTitleTextFieldController.text.isEmpty) {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Bitte geben Sie den Buchtitel ein!',
      );
      return false;
    }

    if (selectedLocation == null) {
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
    return EditBookPage(this);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the tree
    bookTitleTextFieldController.dispose();
    authorTextFieldController.dispose();
    bookDescriptionTextFieldController.dispose();
    super.dispose();
  }
}
