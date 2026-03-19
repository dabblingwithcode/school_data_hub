import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_helper.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/learn_resources_menu_screen.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/pupil_lists_menu_screen.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/school_lists_menu_screen.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/tools_screen.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_screen/settings_screen.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class MainMenuBottomNavigation extends WatchingStatefulWidget {
  const MainMenuBottomNavigation({super.key});

  @override
  State<MainMenuBottomNavigation> createState() =>
      _MainMenuBottomNavigationState();
}

class _MainMenuBottomNavigationState extends State<MainMenuBottomNavigation>
    with WidgetsBindingObserver {
  final List<Widget> pages = [
    const PupilListsMenuScreen(),
    const SchoolListsMenuScreen(),
    const LearnResourcesMenuScreen(),
    const ToolsScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // On some devices (e.g. Samsung Tab S6 Lite), orientation change can report
    // new orientation before updated dimensions. Force a rebuild after a short
    // delay so the next frame gets correct viewport constraints.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

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
            di<NotificationManager>().showInformationDialog(
              NotificationType.error,
              'Es fehlen noch diese Daten im Server:\n\n$missingData',
            );
          }),
        );
      }
      await di.allReady();
      PupilIdentityHelper.checkForOutdatedPupilIdentities();
    });

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return PageView(
            controller: pageViewController,
            children: const <Widget>[
              PupilListsMenuScreen(),
              SchoolListsMenuScreen(),
              LearnResourcesMenuScreen(),
              ToolsScreen(),
              SettingsScreen(),
            ],
            onPageChanged: (index) => bottomNavmanager.setBottomNavPage(index),
          );
        },
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
        ),
      ),
    );
  }
}
