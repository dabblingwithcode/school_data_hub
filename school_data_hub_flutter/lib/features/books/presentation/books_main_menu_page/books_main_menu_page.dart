import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';

import '../../../../common/theme/app_colors.dart';
import '../book_list_page/widgets/book_list_bottom_navbar.dart';

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
              children: [if (stats != null) BookStatsCard(stats: stats)],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BookListBottomNavBar(),
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
