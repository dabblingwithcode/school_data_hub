import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
import 'package:school_data_hub_flutter/features/books/presentation/books_main_menu_page/books_main_menu_page.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/competence_list_page/competence_list_page.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_item_list_page/competence_report_item_list_scope.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_page/support_category_list_page.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_page/workbook_list_page.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class LearnResourcesMenuPage extends StatelessWidget {
  const LearnResourcesMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: GenericAppBar(
        iconData: Icons.lightbulb,
        title: locale.learningresources,
      ),

      body: Center(
        child: SizedBox(
          width: 380,
          height: 560,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(20),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MainMenuButton(
                destinationPage: const CompetenceListPage(),
                buttonIcon: Icon(
                  Icons.lightbulb,
                  size: 50,
                  color: AppColors.gridViewColor,
                ),
                buttonText: locale.competences,
              ),
              MainMenuButton(
                destinationPage: const CategoryListPage(),
                buttonIcon: Icon(
                  Icons.support_rounded,
                  size: 50,
                  color: AppColors.gridViewColor,
                ),
                buttonText: locale.supportCategories,
              ),
              if (di<HubSessionManager>().user!.userFlags.isTester)
                MainMenuButton(
                  destinationPage: const WorkbookListPage(),
                  buttonIcon: Icon(
                    Icons.note_alt,
                    size: 50,
                    color: AppColors.gridViewColor,
                  ),
                  buttonText: locale.workbooks,
                ),
              MainMenuButton(
                destinationPage: const BooksMainMenuPage(),
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
  }
}
