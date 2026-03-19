import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/spinner.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/books/data/book_api_service.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_helper.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_infos_screen/widgets/book_header.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_screen/widgets/book_pupil_card.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_screen/new_book_controller.dart';

class BookInfosScreen extends WatchingStatefulWidget {
  final String libraryId;

  const BookInfosScreen({super.key, required this.libraryId});

  @override
  State<BookInfosScreen> createState() => _BookInfosScreenState();
}

class _BookInfosScreenState extends State<BookInfosScreen> {
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
    final style = Style.of(context);
    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(title: 'Buch Details', iconData: Icons.book),
      body: _buildBody(),
      bottomNavigationBar: ActionBar(
        actions: [
          IconButton(
            tooltip: 'Buch bearbeiten',
            icon: const Icon(Icons.edit, size: 30),
            onPressed: _editBook,
          ),
        ],
      ),
    );
  }

  void _editBook() {
    if (_bookProxy == null) return;
    Navigator.push(
      context,
      MaterialPageRoute<void>(
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
    final style = Style.of(context);
    if (_isLoading) {
      return Center(child: Spinner(color: style.colors.foreground));
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage!,
              style: context.typography.body.withColor(style.colors.error),
            ),
            const Gap(10),
            Button(onPressed: _loadBook, label: 'Erneut versuchen'),
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
          padding: EdgeInsets.all(Style.spacing.xs),
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
    final style = Style.of(context);
    return CardBox(
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Beschreibung:',
            style: context.typography.subtitle,
          ),
          const Gap(8),
          InkWell(
            onTap: () async {
              final result = await longTextFieldDialog(
                title: 'Beschreibung',
                labelText: 'Beschreibung',
                initialValue: bookProxy.description,
                parentContext: context,
              );
              if (result == null || result.value == bookProxy.description) {
                return;
              }

              await di<BookManager>().updateLibraryBookAndBookProperties(
                isbn: bookProxy.isbn,
                libraryId: bookProxy.libraryId,
                description: result.value,
              );
              _loadBook(); // Reload to reflect changes
            },

            child: Text(
              bookProxy.description.isNotEmpty
                  ? bookProxy.description
                  : 'Keine Beschreibung verfügbar.',
              style: context.typography.body.withColor(
                bookProxy.description.isEmpty
                    ? style.colors.mutedForeground
                    : style.colors.foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherCopies(LibraryBookProxy bookProxy) {
    final style = Style.of(context);
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
        Text(
          'Weitere Exemplare:',
          style: context.typography.subtitle,
        ),
        const Gap(10),
        CardBox(
          padding: EdgeInsets.all(Style.spacing.lg),
          child: Column(
            children: otherCopies.map((book) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          BookInfosScreen(libraryId: book.libraryId),
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
                        color: book.available
                            ? style.colors.success
                            : style.colors.warning,
                        size: 20,
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exemplar: ${book.libraryId}',
                              style: context.typography.body.bold,
                            ),
                            Text(
                              'Ort: ${book.location.location}',
                              style: context.typography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: style.colors.mutedForeground,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(10),
            Text(
              'Ausleihen:',
              style: context.typography.subtitle,
            ),
          ],
        ),
        const Gap(10),
        if (sortedLendings.isEmpty)
          CardBox(
            padding: EdgeInsets.all(Style.spacing.lg),
            child: const Center(child: Text('Keine Ausleihen vorhanden')),
          )
        else
          ...sortedLendings.map(
            (lending) => BookLendingPupilCard(passedPupilBook: lending),
          ),
      ],
    );
  }
}
