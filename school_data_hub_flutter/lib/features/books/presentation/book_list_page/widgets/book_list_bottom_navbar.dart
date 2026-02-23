import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:isbn/isbn.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_infos_page/book_infos_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_form/book_search_form_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_page/new_book_controller.dart';

import '../../../../../common/widgets/dialogs/short_textfield_dialog.dart';

class BookListBottomNavBar extends WatchingWidget {
  const BookListBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(9),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 35),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(10),
              IconButton(
                tooltip: 'Schlagwörter verwalten',
                icon: const Icon(Icons.bookmark, size: 30),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const BookTagManagement(),
                    ),
                  );
                },
              ),
              const Gap(10),
              IconButton(
                tooltip: 'Buch erfassen',
                icon: const Icon(Icons.qr_code_scanner, size: 30),
                onPressed: () async {
                  await _showNewBookDialog(context);
                },
                onLongPress: () async {
                  await _showNewBookDialog(context, useKeyboard: true);
                },
              ),
              const Gap(10),
              IconButton(
                tooltip: 'Buch-Infos',
                icon: const Icon(Icons.info_outline, size: 30),
                onPressed: () async {
                  await _showBookInfosDialog(context);
                },
                onLongPress: () => () async {
                  await _showBookInfosDialog(context, typeIsbn: true);
                }(),
              ),
              const Gap(10),
              IconButton(
                tooltip: 'Bücher suchen',
                icon: const Icon(Icons.search, size: 30),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const BookSearchFormPage(),
                    ),
                  );
                },
              ),

              const Gap(5),
            ],
          ),
        ),
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
