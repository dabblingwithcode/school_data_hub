import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_page/new_book_controller.dart';
import 'package:watch_it/watch_it.dart';

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
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(15),
              IconButton(
                tooltip: 'Neues Buch',
                icon: const Icon(
                  Icons.add,
                  size: 35,
                ),
                onPressed: () async {
                  if (Platform.isWindows) {
                    final isbn = await shortTextfieldDialog(
                        context: context,
                        title: 'ISBN eingeben',
                        labelText: 'ISBN',
                        hintText: 'Bitte geben Sie die ISBN ein');
                    if (isbn != null && isbn.isNotEmpty) {
                      final cleanIsbn = isbn.replaceAll('-', '');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => NewBook(
                          isEdit: false,
                          isbn: int.parse(cleanIsbn),
                        ),
                      ));
                    } else {
                      final String? isbn = await qrScanner(
                          context: context, overlayText: 'ISBN scannen');
                      if (isbn != null && isbn.isNotEmpty) {
                        final cleanIsbn = isbn.replaceAll('-', '');
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => NewBook(
                            isEdit: false,
                            isbn: int.parse(isbn),
                          ),
                        ));
                      }
                    }
                  }
                },
              ),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}
