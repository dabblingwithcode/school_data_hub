import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/app/presentation/app_main_navigation/widgets/main_menu_button.dart';

class SchoolListsMenuPage extends StatelessWidget {
  const SchoolListsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          locale.checkLists,
          style: AppStyles.appBarTextStyle,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 380,
          height: 380,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(20),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MainMenuButton(
                  destinationPage: const Placeholder(), //SchoolListsPage(),
                  buttonIcon: const Icon(
                    Icons.rule,
                    size: 50,
                    color: AppColors.gridViewColor,
                  ),
                  buttonText: locale.lists),
              MainMenuButton(
                  destinationPage:
                      const Placeholder(), // AuthorizationsListPage(),
                  buttonIcon: const Icon(
                    Icons.fact_check_rounded,
                    size: 50,
                    color: AppColors.gridViewColor,
                  ),
                  buttonText: locale.authorizations)
            ],
          ),
        ),
      ),
    );
  }
}
