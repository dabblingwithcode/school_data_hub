import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isbn/isbn.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_form/book_search_form_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../common/theme/app_colors.dart';
import '../../../../common/widgets/dialogs/short_textfield_dialog.dart';
import '../book_list_page/book_list_page.dart';
import '../book_list_page/widgets/book_list_bottom_navbar.dart';
import '../new_book_page/new_book_controller.dart';

class BooksMainMenuPage extends StatelessWidget {
  const BooksMainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(iconData: Icons.lightbulb, title: 'Bücher'),
      body: Center(
        child: SizedBox(
          width: 380,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(context, "Schlagwörter verwalten", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const BookTagManagement(),
                  ),
                );
              }),
              const SizedBox(height: 20),
              _buildButton(context, "Ausgeliehene Bücher", () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const BookListPage()),
                );
              }),
              const SizedBox(height: 20),
              _buildButton(context, "Buch erfassen", () async {
                await _showNewBookDialog(context);
              }),
              const SizedBox(height: 20),
              _buildButton(context, "Bücher suchen", () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const BookSearchFormPage(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BookListBottomNavBar(),
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
        builder:
            (ctx) => NewBook(isEdit: false, isbn: int.parse(cleanScannedIsbn)),
      ),
    );
  }
}
