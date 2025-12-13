import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/bottom_nav_bar_no_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/data/book_api_service.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_helper.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_infos_page/widgets/book_header.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/book_pupil_card.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_page/new_book_controller.dart';
import 'package:watch_it/watch_it.dart';

class BookInfosPage extends WatchingStatefulWidget {
  final String libraryId;

  const BookInfosPage({super.key, required this.libraryId});

  @override
  State<BookInfosPage> createState() => _BookInfosPageState();
}

class _BookInfosPageState extends State<BookInfosPage> {
  LibraryBookProxy? _bookProxy;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  Future<void> _loadBook() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final libraryBook = await BookApiService().fetchLibraryBookByLibraryId(
        widget.libraryId,
      );

      if (libraryBook != null) {
        setState(() {
          _bookProxy = LibraryBookProxy(librarybook: libraryBook);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Buch nicht gefunden';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Fehler beim Laden: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(title: 'Buch Details', iconData: Icons.book),
      body: _buildBody(),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: GenericBottomNavBarWithActions(
          actions: [
            IconButton(
              tooltip: 'Buch bearbeiten',
              icon: const Icon(Icons.edit, size: 30),
              onPressed: _editBook,
            ),
          ],
        ),
      ),
    );
  }

  void _editBook() {
    if (_bookProxy == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewBook(
          isEdit: true,
          isbn: _bookProxy!.isbn,
          libraryId: _bookProxy!.libraryId,
          bookTitle: _bookProxy!.title,
          bookAuthor: _bookProxy!.author,
          bookDescription: _bookProxy!.description,
          bookReadingLevel: _bookProxy!.readingLevel,
          location: _bookProxy!.location,
          bookAvailable: _bookProxy!.available,
          imageId: _bookProxy!.imagePath,
          bookTags: _bookProxy!.book.tags,
        ),
      ),
    ).then((_) {
      // Reload book after editing
      _loadBook();
    });
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            const Gap(10),
            ElevatedButton(
              onPressed: _loadBook,
              child: const Text('Erneut versuchen'),
            ),
          ],
        ),
      );
    }

    if (_bookProxy == null) {
      return const Center(child: Text('Kein Buch gefunden'));
    }

    final bookProxy = _bookProxy!;

    return Center(
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookHeader(bookProxy: bookProxy),
              const Gap(10),
              _buildDescription(bookProxy),
              const Gap(10),
              _buildOtherCopies(bookProxy),
              const Gap(0),
              _buildLendings(bookProxy),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(LibraryBookProxy bookProxy) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Beschreibung:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            InkWell(
              onTap: () async {
                final String? description = await longTextFieldDialog(
                  title: 'Beschreibung',
                  labelText: 'Beschreibung',
                  initialValue: bookProxy.description,
                  parentContext: context,
                );
                if (description != null &&
                    description != bookProxy.description) {
                  await di<BookManager>().updateLibraryBookAndBookProperties(
                    isbn: bookProxy.isbn,
                    libraryId: bookProxy.libraryId,
                    description: description,
                  );
                  _loadBook(); // Reload to reflect changes
                }
              },
              child: Text(
                bookProxy.description.isNotEmpty
                    ? bookProxy.description
                    : 'Keine Beschreibung verfügbar.',
                style: TextStyle(
                  fontSize: 14,
                  color: bookProxy.description.isEmpty
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherCopies(LibraryBookProxy bookProxy) {
    final otherCopies = di<BookManager>()
        .getLibraryBooksByIsbn(bookProxy.isbn)
        .where((book) => book.libraryId != bookProxy.libraryId)
        .toList();

    if (otherCopies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weitere Exemplare:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Gap(10),
        Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: otherCopies.map((book) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookInfosPage(libraryId: book.libraryId),
                      ),
                    ).then((_) => _loadBook());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          book.available
                              ? Icons.check_circle
                              : Icons.hourglass_empty,
                          color: book.available ? Colors.green : Colors.orange,
                          size: 20,
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exemplar: ${book.libraryId}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Ort: ${book.location.location}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLendings(LibraryBookProxy bookProxy) {
    final lendings = BookHelpers.pupilBookLendingsLinkedToLibraryBook(
      libraryBookId: bookProxy.id,
    );

    // Sort lendings: current (not returned) first, then by date desc
    final sortedLendings = lendings.toList();
    sortedLendings.sort((a, b) {
      if (a.returnedAt == null && b.returnedAt != null) return -1;
      if (a.returnedAt != null && b.returnedAt == null) return 1;
      return b.lentAt.compareTo(a.lentAt);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(10),
            Text(
              'Ausleihen:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Gap(10),
        if (sortedLendings.isEmpty)
          const Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text('Keine Ausleihen vorhanden')),
            ),
          )
        else
          ...sortedLendings.map(
            (lending) => BookLendingPupilCard(passedPupilBook: lending),
          ),
      ],
    );
  }
}
