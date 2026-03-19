import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_helper.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

/// Shell widget for [StatefulShellRoute] — renders the branch navigators inside
/// a [Scaffold] with a [PageView] body and a bottom navigation bar.
///
/// Uses the primary [StatefulShellRoute] constructor with
/// [navigatorContainerBuilder] so that the branch navigators are provided as
/// [children] and wrapped in a [PageView] for swipe-between-tabs support.
class ScaffoldWithNavBar extends WatchingStatefulWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with WidgetsBindingObserver {
  late final PageController _pageController = PageController(
    initialPage: widget.navigationShell.currentIndex,
  );

  /// Guards against recursive calls when the PageView animation triggers
  /// onPageChanged which calls goBranch which triggers the handler.
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    // On some devices (e.g. Samsung Tab S6 Lite), orientation change can report
    // new orientation before updated dimensions. Force a rebuild after a short
    // delay so the next frame gets correct viewport constraints.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  void _onTap(int index) {
    // Sync BottomNavManager so existing code that reads bottomNavState still works
    di<BottomNavManager>().setBottomNavPage(index);

    // Animate the PageView to the tapped tab
    _isAnimating = true;
    _pageController
        .animateToPage(
          index,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        )
        .then((_) => _isAnimating = false);
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    // One-time env-data check (migrated from MainMenuBottomNavigation)
    callOnce((context) async {
      final envManager = di<EnvManager>();
      final envDataIncomplete = envManager.isAnyImportantEnvDataNotPopulatedInServer();
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

    // Keep BottomNavManager in sync when go_router changes branch externally
    // (e.g. programmatic navigation via setBottomNavPage(0) in PupilIdentityManager)
    registerHandler(
      select: (BottomNavManager x) => x.bottomNavState,
      handler: (context, value, cancel) {
        if (value != widget.navigationShell.currentIndex && !_isAnimating) {
          _isAnimating = true;
          _pageController
              .animateToPage(
                value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              )
              .then((_) => _isAnimating = false);
        }
      },
    );

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      body: PageView(
        controller: _pageController,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) {
          if (_isAnimating) return; // Avoid recursive calls during animation
          // Sync go_router branch and BottomNavManager when user swipes
          widget.navigationShell.goBranch(index);
          di<BottomNavManager>().setBottomNavPage(index);
        },
        children: widget.children,
      ),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: BottomNavigationBar(
          iconSize: 28,
          onTap: _onTap,
          showSelectedLabels: true,
          currentIndex: widget.navigationShell.currentIndex,
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
