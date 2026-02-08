import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/learn_resources_menu_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/pupil_lists_menu_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/school_lists_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/tools_page.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_page/settings_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_helper.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:flutter_it/flutter_it.dart';

class MainMenuBottomNavigation extends WatchingStatefulWidget {
  const MainMenuBottomNavigation({super.key});

  @override
  State<MainMenuBottomNavigation> createState() =>
      _MainMenuBottomNavigationState();
}

class _MainMenuBottomNavigationState extends State<MainMenuBottomNavigation> {
  final List pages = [
    const PupilListsMenuPage(),
    const SchoolListsMenuPage(),
    const LearnResourcesMenuPage(),
    const ToolsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavmanager = di<BottomNavManager>();
    final envManager = di<EnvManager>();
    final locale = AppLocalizations.of(context)!;

    final tab = watchValue((BottomNavManager x) => x.bottomNavState);
    final pageViewController = createOnce(
      () => PageController(initialPage: tab),
    );

    registerHandler(
      select: (BottomNavManager x) => x.bottomNavState,
      handler: (context, value, cancel) {
        pageViewController.jumpToPage(value);
      },
    );
    callOnce((context) async {
      final envDataIncomplete = di<EnvManager>()
          .isAnyImportantEnvDataNotPopulatedInServer();
      if (envDataIncomplete) {
        final serverDataStatus = envManager.populatedEnvServerData;
        final List<String> missingFields = [];
        if (!serverDataStatus.schoolSemester) {
          missingFields.add('Schulhalbjahr');
        }
        if (!serverDataStatus.schooldays) {
          missingFields.add('Schultage');
        }
        if (!serverDataStatus.competences) {
          missingFields.add('Kompetenzen');
        }
        if (!serverDataStatus.supportCategories) {
          missingFields.add('Förderkategorien');
        }
        final String missingData = missingFields.join('\n');

        // delayed because of race condition
        unawaited(
          Future<void>.delayed(const Duration(milliseconds: 500), () {
            di<NotificationService>().showInformationDialog(
              'Es fehlen noch diese Daten im Server:\n\n$missingData',
            );
          }),
        );
      }
      await di.allReady();
      PupilIdentityHelper.checkForOutdatedPupilIdentities();
    });

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      body: PageView(
        controller: pageViewController,
        children: const <Widget>[
          PupilListsMenuPage(),
          SchoolListsMenuPage(),
          LearnResourcesMenuPage(),
          ToolsPage(),
          SettingsPage(),
        ],
        onPageChanged: (index) => bottomNavmanager.setBottomNavPage(index),
      ),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: BottomNavigationBar(
          iconSize: 28,
          onTap: (index) {
            bottomNavmanager.setBottomNavPage(index);
            pageViewController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
            //BottomNavManager().setBottomNavPage(index);
          },
          showSelectedLabels: true,
          currentIndex: tab,
          selectedItemColor: AppColors.accentColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_box_rounded),
              label: locale.pupilLists,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: locale.schoolLists,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.lightbulb),
              label: locale.learningLists,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.build_rounded),
              label: locale.tools,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: locale.settings,
            ),
          ],

          //onTap:
        ),
      ),
    );
  }
}
