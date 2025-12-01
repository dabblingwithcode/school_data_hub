import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:isbn/isbn.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../common/theme/app_colors.dart';
import '../../../../common/widgets/dialogs/short_textfield_dialog.dart';
import '../book_list_page/widgets/book_list_bottom_navbar.dart';

class BooksMainMenuPage extends WatchingWidget {
  const BooksMainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = watchValue((BookManager m) => m.bookStats);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(iconData: Icons.lightbulb, title: 'Bücher'),
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
                  context.push('/learning/books/tags');
                }),
                const SizedBox(height: 20),
                _buildButton(context, "Ausgeliehene Bücher", () {
                  context.push('/learning/books/list');
                }),
                const SizedBox(height: 20),
                _buildButton(context, "Buch erfassen", () async {
                  await _showNewBookDialog(context);
                }),
                const SizedBox(height: 20),
                _buildButton(context, "Bücher suchen", () {
                  context.push('/learning/books/search');
                }),
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

  Widget _buildButton(BuildContext context, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _showNewBookDialog(BuildContext context) async {
  if (Platform.isWindows) {
    final isbn = await shortTextfieldDialog(
      context: context,
      title: 'ISBN eingeben',
      labelText: 'ISBN',
      hintText: 'Bitte geben Sie die ISBN ein',
    );

    if (isbn != null && isbn.isNotEmpty) {
      final cleanIsbn = isbn.replaceAll('-', '');

      context.push(
        '/learning/books/new',
        extra: {'isEdit': false, 'isbn': int.parse(cleanIsbn)},
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
    context.push(
      '/learning/books/new',
      extra: {'isEdit': false, 'isbn': int.parse(cleanScannedIsbn)},
    );
  }
}
