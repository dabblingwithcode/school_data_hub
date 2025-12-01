import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/core/router/sliding_branch_container.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:watch_it/watch_it.dart';

class ScaffoldWithNavBar extends WatchingStatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<Widget>? children; // Added children parameter

  const ScaffoldWithNavBar({
    required this.navigationShell,
    this.children,
    super.key,
  });

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final currentIndex = widget.navigationShell.currentIndex;

    // Watch BottomNavManager to handle programmatic changes
    final bottomNavIndex = watchValue((BottomNavManager x) => x.bottomNavState);

    // If BottomNavManager changes and it's different from current shell index, navigate
    if (bottomNavIndex != currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.navigationShell.goBranch(
          bottomNavIndex,
          initialLocation: bottomNavIndex == currentIndex,
        );
      });
    }

    // The body content. If children are provided (from navigatorContainerBuilder), use them.
    // Otherwise use navigationShell directly (fallback).
    Widget bodyContent = widget.children != null
        ? SlidingBranchContainer(
            currentIndex: currentIndex,
            children: widget.children!,
          )
        : widget.navigationShell;

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          int newIndex = currentIndex;

          if (details.primaryVelocity! < 0) {
            // Swipe Left -> Go Next
            if (currentIndex < 4) {
              newIndex++;
            }
          } else if (details.primaryVelocity! > 0) {
            // Swipe Right -> Go Previous
            if (currentIndex > 0) {
              newIndex--;
            }
          }

          if (newIndex != currentIndex) {
            widget.navigationShell.goBranch(newIndex);
            di<BottomNavManager>().setBottomNavPage(newIndex);
          }
        },
        child: bodyContent,
      ),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: BottomNavigationBar(
          iconSize: 28,
          onTap: (index) {
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
            di<BottomNavManager>().setBottomNavPage(index);
          },
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
              label: locale.scanTools,
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
