import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:isbn/isbn.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';

class BooksMainMenuScreen extends WatchingWidget {
  const BooksMainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = watchValue((BookManager m) => m.bookStats);
    final style = Style.of(context);

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(iconData: Icons.book_rounded, title: 'Bücherei'),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Style.spacing.lg),
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
      bottomNavigationBar: const ActionBar(),
    );
  }
}

class BookActionsCard extends StatelessWidget {
  const BookActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Style.spacing.lg),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonMinWidth = 120.0;
          final buttonMaxWidth = 160.0;
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: Style.spacing.md,
            runSpacing: Style.spacing.md,
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
                icon: Icons.swap_horiz,
                label: 'Buch ausleihen',
                minWidth: buttonMinWidth,
                maxWidth: buttonMaxWidth,
                onTap: () {
                  context.push(RoutePaths.learningBooksLending);
                },
              ),
              BookActionButton(
                icon: Icons.assignment_return,
                label: 'Buch zurückgeben',
                minWidth: buttonMinWidth,
                maxWidth: buttonMaxWidth,
                onTap: () {
                  context.push(RoutePaths.learningBooksReturn);
                },
              ),
              BookActionButton(
                icon: Icons.search,
                label: 'Bücher suchen',
                minWidth: buttonMinWidth,
                maxWidth: buttonMaxWidth,
                onTap: () {
                  context.push(RoutePaths.learningBooksSearch);
                },
              ),
              BookActionButton(
                icon: Icons.bookmark,
                label: 'Schlagwörter',
                minWidth: buttonMinWidth,
                maxWidth: buttonMaxWidth,
                onTap: () {
                  context.push(RoutePaths.learningBooksTags);
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
    final style = Style.of(context);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: maxWidth,
        child: Container(
          padding: EdgeInsets.all(Style.spacing.lg),
          decoration: BoxDecoration(
            color: style.colors.accent,
            borderRadius: BorderRadius.circular(Style.radii.medium),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36, color: style.colors.accentForeground),
              const Gap(8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: context.typography.body.w500.withColor(
                  style.colors.accentForeground,
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
    final style = Style.of(context);

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Column(
        children: [
          Text(
            'Bibliotheks-Statistik',
            style: context.typography.subtitle.bold,
          ),
          Divider(color: style.colors.border),
          BookStatRow(
            label: 'Katalogisierte Bücher',
            value: stats.totalCatalogedBooks.toString(),
          ),
          BookStatRow(
            label: 'Exemplare in Bibliothek',
            value: stats.totalLibraryBooks.toString(),
          ),
          Divider(color: style.colors.border),
          BookStatRow(
            label: 'Verliehene Bücher',
            value: stats.actuallyBorrowedBooks.toString(),
          ),
          BookStatRow(
            label: 'Gelesene Bücher (Rückgaben)',
            value: stats.totalReadBooks.toString(),
          ),
          Divider(color: style.colors.border),
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
      padding: EdgeInsets.symmetric(vertical: Style.spacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.typography.body),
          Text(value, style: context.typography.body.bold),
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
      context.push(RoutePaths.learningBooksInfo, extra: libraryId);
    }
  } else {
    final String? scannedLibraryId = await qrScanner(
      context: context,
      overlayText: 'Buch-ID scannen',
    );
    if (scannedLibraryId == null) return;

    final bookId = scannedLibraryId.replaceFirst('Buch ID: ', '').trim();
    if (context.mounted) {
      context.push(RoutePaths.learningBooksInfo, extra: bookId);
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
      context.push(
        RoutePaths.learningBooksNew,
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
      di<NotificationManager>().showSnackBar(
        NotificationType.error,
        'Die gescannte ISBN ist ungültig: $scannedIsbn',
      );
      return;
    }

    final cleanScannedIsbn = scannedIsbn.replaceAll('-', '');
    if (!context.mounted) return;
    context.push(
      RoutePaths.learningBooksNew,
      extra: {'isEdit': false, 'isbn': int.parse(cleanScannedIsbn)},
    );
  }
}
