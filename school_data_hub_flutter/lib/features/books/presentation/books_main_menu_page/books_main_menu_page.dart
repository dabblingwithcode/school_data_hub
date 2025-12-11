import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:isbn/isbn.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_infos_page/book_infos_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_form/book_search_form_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../common/theme/app_colors.dart';
import '../../../../common/widgets/dialogs/short_textfield_dialog.dart';
import '../book_list_page/widgets/book_list_bottom_navbar.dart';
import '../new_book_page/new_book_controller.dart';

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
      body: Center(
        child: SizedBox(
          width: 380,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (stats != null) _buildStatsCard(stats),
                const Gap(20),
                _buildButton(context, "Schlagwörter verwalten", () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const BookTagManagement(),
                    ),
                  );
                }, icon: Icons.bookmark),
                // const SizedBox(height: 20),
                // _buildButton(context, "Ausgeliehene Bücher", () {
                //   Navigator.of(context).push(
                //     MaterialPageRoute(builder: (ctx) => const BookListPage()),
                //   );
                // }),
                const SizedBox(height: 5),
                _buildButton(
                  context,
                  "Buch erfassen",
                  () async {
                    await _showNewBookDialog(context);
                  },
                  icon: Icons.qr_code_scanner,
                  onLongPress: () async {
                    // For Windows: allow manual ISBN entry
                    await _showNewBookDialog(context, dialog: true);
                  },
                ),
                const SizedBox(height: 5),
                _buildButton(context, "Buch-Infos", () async {
                  await _showBookInfosDialog(context);
                }, icon: Icons.info_outline),
                const SizedBox(height: 5),
                _buildButton(context, "Bücher suchen", () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const BookSearchFormPage(),
                    ),
                  );
                }, icon: Icons.search),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BookListBottomNavBar(),
    );
  }

  Widget _buildStatsCard(LibraryBookStatsDto stats) {
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
            _buildStatRow(
              'Katalogisierte Bücher',
              stats.totalCatalogedBooks.toString(),
            ),
            _buildStatRow(
              'Exemplare in Bibliothek',
              stats.totalLibraryBooks.toString(),
            ),
            const Divider(),
            _buildStatRow(
              'Verliehene Bücher',
              stats.actuallyBorrowedBooks.toString(),
            ),
            _buildStatRow(
              'Gelesene Bücher (Rückgaben)',
              stats.totalReadBooks.toString(),
            ),
            const Divider(),
            _buildStatRow(
              'Lesestufe 1',
              stats.totalBooksWithReadingLevel1.toString(),
            ),
            _buildStatRow(
              'Lesestufe 2',
              stats.booksWithReadingLevel2.toString(),
            ),
            _buildStatRow(
              'Lesestufe 3',
              stats.booksWithReadingLevel3.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
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

  Widget _buildButton(
    BuildContext context,
    String label,
    VoidCallback onTap, {
    VoidCallback? onLongPress,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Card(
          color: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 24, color: Colors.white),
                  const Gap(10),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _showNewBookDialog(BuildContext context, {bool? dialog}) async {
  if (Platform.isWindows || dialog == true) {
    final isbn = await shortTextfieldDialog(
      context: context,
      title: 'ISBN eingeben',
      labelText: 'ISBN',
      hintText: 'Bitte geben Sie die ISBN ein',
    );

    if (isbn != null && isbn.isNotEmpty) {
      final cleanIsbn = isbn.replaceAll('-', '');

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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            NewBook(isEdit: false, isbn: int.parse(cleanScannedIsbn)),
      ),
    );
  }
}

Future<void> _showBookInfosDialog(BuildContext context) async {
  if (Platform.isWindows) {
    final libraryId = await shortTextfieldDialog(
      context: context,
      title: 'Buch-ID eingeben',
      labelText: 'Buch-ID',
      hintText: 'Bitte geben Sie die Buch-ID ein',
    );

    if (libraryId != null && libraryId.isNotEmpty) {
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

    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => BookInfosPage(libraryId: bookId)),
    );
  }
}
