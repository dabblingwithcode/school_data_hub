import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:watch_it/watch_it.dart';

final _mainMenuBottomNavManager = di<BottomNavManager>();

enum ProfileNavigationState {
  info(0),
  language(1),
  credit(2),
  attendance(3),
  schooldayEvent(4),
  ogs(5),
  lists(6),
  authorization(7),
  learningSupport(8),
  learning(9);

  final int value;
  const ProfileNavigationState(this.value);
}

class PupilProfileNavigation extends WatchingWidget {
  final double boxWidth;
  const PupilProfileNavigation({required this.boxWidth, super.key});

  Color _navigationBackgroundColor(bool isSelected) {
    return isSelected ? Colors.white : AppColors.backgroundColor;
  }

  Color _activeForegroundColor(ProfileNavigationState state) {
    switch (state) {
      case ProfileNavigationState.info:
        return AppColors.backgroundColor;
      case ProfileNavigationState.language:
        return AppColors.groupColor;
      case ProfileNavigationState.credit:
        return AppColors.accentColor;
      case ProfileNavigationState.attendance:
        return Colors.grey.shade800;
      case ProfileNavigationState.schooldayEvent:
        return AppColors.accentColor;
      case ProfileNavigationState.ogs:
        return AppColors.backgroundColor;
      case ProfileNavigationState.lists:
        return Colors.grey.shade600;
      case ProfileNavigationState.authorization:
        return Colors.grey.shade600;
      case ProfileNavigationState.learningSupport:
        return const Color.fromARGB(255, 245, 75, 75);
      case ProfileNavigationState.learning:
        return AppColors.accentColor;
    }
  }

  ElevatedButton _navButton({
    required ProfileNavigationState state,
    required int selectedState,
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    final bool isSelected = selectedState == state.value;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.backgroundColor, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        backgroundColor: _navigationBackgroundColor(isSelected),
      ),
      onPressed: () {
        if (isSelected) {
          return;
        }
        _mainMenuBottomNavManager.setPupilProfileNavPage(state.value);
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int pupilProfileNavState = watchValue(
      (BottomNavManager x) => x.pupilProfileNavState,
    );

    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
      child: Center(
        child: SizedBox(
          height: Platform.isWindows ? 65 : 85,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0), //5.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.info,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.info_rounded,
                            color:
                                _mainMenuBottomNavManager
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.info.value
                                ? _activeForegroundColor(
                                    ProfileNavigationState.info,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.language,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.language_rounded,
                            color:
                                _mainMenuBottomNavManager
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.language.value
                                ? _activeForegroundColor(
                                    ProfileNavigationState.language,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.credit,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.attach_money_rounded,
                            color:
                                _mainMenuBottomNavManager
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.credit.value
                                ? _activeForegroundColor(
                                    ProfileNavigationState.credit,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.attendance,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color:
                                _mainMenuBottomNavManager
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.attendance.value
                                ? _activeForegroundColor(
                                    ProfileNavigationState.attendance,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.schooldayEvent,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.warning_rounded,
                            color:
                                _mainMenuBottomNavManager
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.schooldayEvent.value
                                ? _activeForegroundColor(
                                    ProfileNavigationState.schooldayEvent,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.ogs,
                          selectedState: pupilProfileNavState,
                          padding: EdgeInsets.zero,
                          child: Text(
                            'OGS',
                            style: TextStyle(
                              color:
                                  _mainMenuBottomNavManager
                                          .pupilProfileNavState
                                          .value ==
                                      ProfileNavigationState.ogs.value
                                  ? _activeForegroundColor(
                                      ProfileNavigationState.ogs,
                                    )
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.lists,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.rule,
                            color:
                                _mainMenuBottomNavManager
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.lists.value
                                ? _activeForegroundColor(
                                    ProfileNavigationState.lists,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.authorization,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.fact_check_rounded,
                            color:
                                _mainMenuBottomNavManager
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.authorization.value
                                ? _activeForegroundColor(
                                    ProfileNavigationState.authorization,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.learningSupport,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.support_rounded,
                            color:
                                _mainMenuBottomNavManager
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.learningSupport.value
                                ? _activeForegroundColor(
                                    ProfileNavigationState.learningSupport,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          state: ProfileNavigationState.learning,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.lightbulb,
                            color:
                                _mainMenuBottomNavManager
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.learning.value
                                ? _activeForegroundColor(
                                    ProfileNavigationState.learning,
                                  )
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
