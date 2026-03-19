import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
import 'package:school_data_hub_flutter/features/books/presentation/books_main_menu_screen/books_main_menu_screen.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/competence_list_page/competence_list_page.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_item_list_page/competence_report_item_list_scope.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_page/support_category_list_page.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_screen/workbook_list_screen.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class LearnResourcesMenuScreen extends StatelessWidget {
  const LearnResourcesMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      appBar: AppHeader(
        iconData: Icons.lightbulb,
        title: locale.learningresources,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = Platform.isWindows
              ? 700.0
              : math.min(600.0, constraints.maxWidth);
          final height = Platform.isWindows
              ? 600.0
              : constraints.maxHeight * 0.9;
          return Center(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    MainMenuButton(
                      destinationPage: const CompetenceListScreen(),
                      buttonIcon: Icon(
                        Icons.lightbulb,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: locale.competences,
                    ),
                    MainMenuButton(
                      destinationPage: const CategoryListScreen(),
                      buttonIcon: Icon(
                        Icons.support_rounded,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: locale.supportCategories,
                    ),
                    if (di<HubSessionManager>().user!.userFlags.isTester)
                      MainMenuButton(
                        destinationPage: const WorkbookListScreen(),
                        buttonIcon: Icon(
                          Icons.note_alt,
                          size: 50,
                          color: AppColors.gridViewColor,
                        ),
                        buttonText: locale.workbooks,
                      ),
                    MainMenuButton(
                      destinationPage: const BooksMainMenuScreen(),
                      buttonIcon: Icon(
                        Icons.book,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Bücherei',
                    ),
                    MainMenuButton(
                      destinationPage: const CompetenceReportItemListScope(),
                      buttonIcon: Icon(
                        Icons.assignment,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Zeugnis-\nkompetenzen',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
