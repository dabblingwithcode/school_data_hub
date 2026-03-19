import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class BottomNavBarLayout extends StatelessWidget {
  final Widget bottomNavBar;
  const BottomNavBarLayout({required this.bottomNavBar, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Platform.isWindows
          ? const EdgeInsets.only(left: 5, right: 5, bottom: 20)
          : const EdgeInsets.only(left: 5, right: 5, bottom: 20),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 30,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Theme(
                data: ThemeData(canvasColor: AppColors.backgroundColor),
                child: bottomNavBar,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBarProfileLayout extends StatelessWidget {
  final Widget bottomNavBar;
  const BottomNavBarProfileLayout({required this.bottomNavBar, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Platform.isWindows
          ? const EdgeInsets.only(bottom: 10)
          : EdgeInsets.zero,
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Theme(
              data: ThemeData(canvasColor: AppColors.backgroundColor),
              child: bottomNavBar,
            ),
          ),
        ),
      ),
    );
  }
}
