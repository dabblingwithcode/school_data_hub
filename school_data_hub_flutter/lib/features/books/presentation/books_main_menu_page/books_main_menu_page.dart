import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:isbn/isbn.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_infos_page/book_infos_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/book_list_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_form/book_search_form_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_page/new_book_controller.dart';

import '../../../../common/theme/app_colors.dart';

class BooksMainMenuPage extends WatchingWidget {
  const BooksMainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = watchValue((BookManager m) => m.bookStats);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.book_rounded,
        title: 'Bücherei',
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const Gap(16),
                  if (stats != null) BookStatsCard(stats: stats),
                  const BookActionsCard(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BookListBottomNavBar(),
    );
  }
}

class BookActionsCard extends StatelessWidget {
  const BookActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonMinWidth = 120.0;
          final buttonMaxWidth = 160.0;
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              BookActionButton(
                icon: Icons.qr_code_scanner,
                label: 'Buch erfassen',
                minWidth: buttonMinWidth,
                maxWidth: buttonMaxWidth,
                onTap: () async {
                  await _showNewBookDialog(context);
                },
                onLongPress: () async {
                  await _showNewBookDialog(context, useKeyboard: true);
                },
              ),
              BookActionButton(
                icon: Icons.info_outline,
                label: 'Buch-Infos',
                minWidth: buttonMinWidth,
                maxWidth: buttonMaxWidth,
                onTap: () async {
                  await _showBookInfosDialog(context);
                },
                onLongPress: () async {
                  await _showBookInfosDialog(context, typeIsbn: true);
                },
              ),
              BookActionButton(
                icon: Icons.search,
                label: 'Bücher suchen',
                minWidth: buttonMinWidth,
                maxWidth: buttonMaxWidth,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const BookSearchFormPage(),
                    ),
                  );
                },
              ),
              BookActionButton(
                icon: Icons.bookmark,
                label: 'Schlagwörter',
                minWidth: buttonMinWidth,
                maxWidth: buttonMaxWidth,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const BookTagManagement(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class BookActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final double minWidth;
  final double maxWidth;

  const BookActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.onLongPress,
    this.minWidth = 120,
    this.maxWidth = 120,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: maxWidth,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36, color: AppColors.accentColor),
              const Gap(8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookStatsCard extends StatelessWidget {
  final LibraryBookStatsDto stats;

  const BookStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Bibliotheks-Statistik',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            BookStatRow(
              label: 'Katalogisierte Bücher',
              value: stats.totalCatalogedBooks.toString(),
            ),
            BookStatRow(
              label: 'Exemplare in Bibliothek',
              value: stats.totalLibraryBooks.toString(),
            ),
            const Divider(),
            BookStatRow(
              label: 'Verliehene Bücher',
              value: stats.actuallyBorrowedBooks.toString(),
            ),
            BookStatRow(
              label: 'Gelesene Bücher (Rückgaben)',
              value: stats.totalReadBooks.toString(),
            ),
            const Divider(),
            BookStatRow(
              label: 'Lesestufe 1',
              value: stats.totalBooksWithReadingLevel1.toString(),
            ),
            BookStatRow(
              label: 'Lesestufe 2',
              value: stats.booksWithReadingLevel2.toString(),
            ),
            BookStatRow(
              label: 'Lesestufe 3',
              value: stats.booksWithReadingLevel3.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class BookStatRow extends StatelessWidget {
  final String label;
  final String value;

  const BookStatRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

Future<void> _showBookInfosDialog(
  BuildContext context, {
  bool? typeIsbn,
}) async {
  if (Platform.isWindows || typeIsbn == true) {
    final libraryId = await shortTextfieldDialog(
      context: context,
      title: 'Buch-ID eingeben',
      labelText: 'Buch-ID',
      hintText: 'Bitte geben Sie die Buch-ID ein',
    );

    if (libraryId != null && libraryId.isNotEmpty) {
      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => BookInfosPage(libraryId: libraryId),
        ),
      );
    }
  } else {
    final String? scannedLibraryId = await qrScanner(
      context: context,
      overlayText: 'Buch-ID scannen',
    );
    if (scannedLibraryId == null) return;

    final bookId = scannedLibraryId.replaceFirst('Buch ID: ', '').trim();
    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => BookInfosPage(libraryId: bookId)),
      );
    }
  }
}

Future<void> _showNewBookDialog(
  BuildContext context, {
  bool? useKeyboard,
}) async {
  if (Platform.isWindows || useKeyboard == true) {
    final isbn = await shortTextfieldDialog(
      context: context,
      title: 'ISBN eingeben',
      labelText: 'ISBN',
      hintText: 'Bitte geben Sie die ISBN ein',
    );

    if (isbn != null && isbn.isNotEmpty) {
      final cleanIsbn = isbn.replaceAll('-', '');

      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => NewBook(isEdit: false, isbn: int.parse(cleanIsbn)),
        ),
      );
    }
  } else {
    final String? scannedIsbn = await qrScanner(
      context: context,
      overlayText: 'ISBN scannen',
    );
    if (scannedIsbn == null) return;
    if (!Isbn().isIsbn13(scannedIsbn)) {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Die gescannte ISBN ist ungültig: $scannedIsbn',
      );
      return;
    }

    final cleanScannedIsbn = scannedIsbn.replaceAll('-', '');
    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            NewBook(isEdit: false, isbn: int.parse(cleanScannedIsbn)),
      ),
    );
  }
}
