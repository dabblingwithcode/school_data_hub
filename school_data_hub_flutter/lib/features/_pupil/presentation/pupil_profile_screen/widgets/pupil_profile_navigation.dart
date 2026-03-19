import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

enum ProfileNavigationState {
  info(0),
  language(1),
  credit(2),
  attendance(3),
  schooldayEvent(4),
  afterSchoolCare(5),
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

  Color _navigationBackgroundColor(BuildContext context, bool isSelected) {
    final style = Style.of(context);
    return isSelected ? style.colors.background : style.colors.accent;
  }

  Color _activeForegroundColor(BuildContext context, ProfileNavigationState state) {
    final style = Style.of(context);
    switch (state) {
      case ProfileNavigationState.info:
        return style.colors.accent;
      case ProfileNavigationState.language:
        return style.colors.groupColor;
      case ProfileNavigationState.credit:
        return style.colors.warning;
      case ProfileNavigationState.attendance:
        return style.colors.foreground;
      case ProfileNavigationState.schooldayEvent:
        return style.colors.warning;
      case ProfileNavigationState.afterSchoolCare:
        return style.colors.accent;
      case ProfileNavigationState.lists:
        return style.colors.mutedForeground;
      case ProfileNavigationState.authorization:
        return style.colors.mutedForeground;
      case ProfileNavigationState.learningSupport:
        return style.colors.error;
      case ProfileNavigationState.learning:
        return style.colors.warning;
    }
  }

  Widget _navButton(
    BuildContext context, {
    required ProfileNavigationState state,
    required int selectedState,
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    final style = Style.of(context);
    final bool isSelected = selectedState == state.value;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: style.colors.accent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(Style.radii.medium)),
        ),
        backgroundColor: _navigationBackgroundColor(context, isSelected),
      ),
      onPressed: () {
        if (isSelected) {
          return;
        }
        di<BottomNavManager>().setPupilProfileNavPage(state.value);
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int pupilProfileNavState = watchValue(
      (BottomNavManager x) => x.pupilProfileNavState,
    );

    final style = Style.of(context);
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
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              decoration: BoxDecoration(
                color: style.colors.accent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Style.radii.medium),
                  topRight: Radius.circular(Style.radii.medium),
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
                          context,
                          state: ProfileNavigationState.info,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.info_rounded,
                            color:
                                di<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.info.value
                                ? _activeForegroundColor(
                                    context,
                                    ProfileNavigationState.info,
                                  )
                                : style.colors.background,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          context,
                          state: ProfileNavigationState.language,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.language_rounded,
                            color:
                                di<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.language.value
                                ? _activeForegroundColor(
                                    context,
                                    ProfileNavigationState.language,
                                  )
                                : style.colors.background,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          context,
                          state: ProfileNavigationState.credit,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.attach_money_rounded,
                            color:
                                di<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.credit.value
                                ? _activeForegroundColor(
                                    context,
                                    ProfileNavigationState.credit,
                                  )
                                : style.colors.background,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          context,
                          state: ProfileNavigationState.attendance,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color:
                                di<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.attendance.value
                                ? _activeForegroundColor(
                                    context,
                                    ProfileNavigationState.attendance,
                                  )
                                : style.colors.background,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          context,
                          state: ProfileNavigationState.schooldayEvent,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.warning_rounded,
                            color:
                                di<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.schooldayEvent.value
                                ? _activeForegroundColor(
                                    context,
                                    ProfileNavigationState.schooldayEvent,
                                  )
                                : style.colors.background,
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
                          context,
                          state: ProfileNavigationState.afterSchoolCare,
                          selectedState: pupilProfileNavState,
                          padding: EdgeInsets.zero,
                          child: Text(
                            'OGS',
                            style: TextStyle(
                              color:
                                  di<BottomNavManager>()
                                          .pupilProfileNavState
                                          .value ==
                                      ProfileNavigationState
                                          .afterSchoolCare
                                          .value
                                  ? _activeForegroundColor(
                                      context,
                                      ProfileNavigationState.afterSchoolCare,
                                    )
                                  : style.colors.background,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          context,
                          state: ProfileNavigationState.lists,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.rule,
                            color:
                                di<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.lists.value
                                ? _activeForegroundColor(
                                    context,
                                    ProfileNavigationState.lists,
                                  )
                                : style.colors.background,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          context,
                          state: ProfileNavigationState.authorization,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.fact_check_rounded,
                            color:
                                di<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.authorization.value
                                ? _activeForegroundColor(
                                    context,
                                    ProfileNavigationState.authorization,
                                  )
                                : style.colors.background,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          context,
                          state: ProfileNavigationState.learningSupport,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.support_rounded,
                            color:
                                di<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.learningSupport.value
                                ? _activeForegroundColor(
                                    context,
                                    ProfileNavigationState.learningSupport,
                                  )
                                : style.colors.background,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _navButton(
                          context,
                          state: ProfileNavigationState.learning,
                          selectedState: pupilProfileNavState,
                          child: Icon(
                            Icons.lightbulb,
                            color:
                                di<BottomNavManager>()
                                        .pupilProfileNavState
                                        .value ==
                                    ProfileNavigationState.learning.value
                                ? _activeForegroundColor(
                                    context,
                                    ProfileNavigationState.learning,
                                  )
                                : style.colors.background,
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
