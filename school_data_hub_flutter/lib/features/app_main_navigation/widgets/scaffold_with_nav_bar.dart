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

/// Main shell widget — PageView with 5 tabs and a bottom navigation bar.
///
/// This is a simple PageView-based shell (like the old [MainMenuBottomNavigation]).
/// go_router handles auth/connection redirects; this widget just renders the
/// authenticated main UI. Feature screens push onto the root navigator via
/// [context.push], so no branch navigators or [StatefulShellRoute] needed.
class ScaffoldWithNavBar extends WatchingStatefulWidget {
  const ScaffoldWithNavBar({this.initialTab, super.key});

  /// If non-null, overrides [BottomNavManager] and opens on this tab index.
  final int? initialTab;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with WidgetsBindingObserver {
  static const _pages = <Widget>[
    PupilListsMenuScreen(),
    SchoolListsMenuScreen(),
    LearnResourcesMenuScreen(),
    ToolsScreen(),
    SettingsScreen(),
  ];

  late final PageController _pageController;

  /// Duration per page when animating between tabs via bottom nav tap.
  static const _msPerPage = 150;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final initialPage =
        widget.initialTab ?? di<BottomNavManager>().bottomNavState.value;
    if (widget.initialTab != null) {
      di<BottomNavManager>().setBottomNavPage(widget.initialTab!);
    }
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  void _onTap(int index) {
    di<BottomNavManager>().setBottomNavPage(index);
    final distance =
        (index - (_pageController.page?.round() ?? 0)).abs().clamp(1, 5);
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: _msPerPage * distance),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final tab = watchValue((BottomNavManager x) => x.bottomNavState);

    // One-time env-data check
    callOnce((context) async {
      final envManager = di<EnvManager>();
      final envDataIncomplete =
          envManager.isAnyImportantEnvDataNotPopulatedInServer();
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

    // Programmatic tab changes (e.g. PupilIdentityManager.setBottomNavPage(0))
    registerHandler(
      select: (BottomNavManager x) => x.bottomNavState,
      handler: (context, value, cancel) {
        if ((_pageController.page?.round() ?? 0) != value) {
          final distance =
              (value - (_pageController.page?.round() ?? 0)).abs().clamp(1, 5);
          _pageController.animateToPage(
            value,
            duration: Duration(milliseconds: _msPerPage * distance),
            curve: Curves.easeInOut,
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          di<BottomNavManager>().setBottomNavPage(index);
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: BottomNavigationBar(
          iconSize: 28,
          onTap: _onTap,
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
