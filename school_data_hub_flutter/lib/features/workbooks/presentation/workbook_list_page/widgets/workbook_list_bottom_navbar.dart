import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_page/new_workbook_page.dart';
import 'package:watch_it/watch_it.dart';

Widget workbookListBottomNavBar(BuildContext context) {
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
              tooltip: 'Neues Arbeitsheft',
              icon: const Icon(
                Icons.add,
                size: 35,
              ),
              onPressed: () async {
                int? isbn;
                if (Platform.isAndroid || Platform.isIOS) {
                  final scanResult = await qrScanner(
                      context: context, overlayText: 'ISBN code scannen');
                  if (scanResult == null) {
                    return;
                  }
                  isbn = int.parse(scanResult);
                } else {
                  final isbnText = await shortTextfieldDialog(
                    context: context,
                    title: 'ISBN',
                    hintText: 'ISBN',
                    labelText: 'ISBN',
                  );
                  if (isbnText == null) {
                    return;
                  }
                  isbn = int.tryParse(isbnText);
                }
                if (!di<WorkbookManager>()
                    .workbooks
                    .value
                    .any((element) => element.isbn == isbn)) {
                  if (context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => NewWorkbookPage(
                          isEdit: false,
                          isbn: isbn!,
                        ),
                      ),
                    );
                  }
                  return;
                }

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => NewWorkbookPage(isbn: isbn!, isEdit: false),
                ));
              },
            ),
            const Gap(15)
          ],
        ),
      ),
    ),
  );
}
