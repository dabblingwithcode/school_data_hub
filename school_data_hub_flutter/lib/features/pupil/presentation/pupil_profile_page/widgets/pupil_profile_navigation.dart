import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/app/domain/main_menu_bottom_nav_manager.dart';
import 'package:watch_it/watch_it.dart';

final _mainMenuBottomNavManager = di<MainMenuBottomNavManager>();

enum ProfileNavigation {
  info(0),
  language(1),
  credit(2),
  attendance(3),
  schooldayEvent(4),
  ogs(5),
  lists(6),
  authorization(7),
  learningSupport(8),
  learning(9),
  ;

  final int value;
  const ProfileNavigation(this.value);
}

class PupilProfileNavigation extends WatchingStatefulWidget {
  final double boxWidth;
  const PupilProfileNavigation({required this.boxWidth, super.key});

  @override
  State<PupilProfileNavigation> createState() => _PupilProfileNavigationState();
}

class _PupilProfileNavigationState extends State<PupilProfileNavigation> {
  Color navigationBackgroundColor(int page) {
    return page == _mainMenuBottomNavManager.pupilProfileNavState.value
        ? Colors.white
        : AppColors.backgroundColor;
  }

  Color navigationBackgroundActive = AppColors.accentColor;
  Color navigationIconInactive = Colors.white;
  Color navigationIconActive = Colors.white;

  @override
  Widget build(BuildContext context) {
    final int pupilProfileNavState =
        watchValue((MainMenuBottomNavManager x) => x.pupilProfileNavState);
    //double boxHeight = 35;
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
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //- Information Button - top left border radius
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              color: AppColors.backgroundColor, width: 2.0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                        ),
                        backgroundColor: navigationBackgroundColor(
                            ProfileNavigation.info.value),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 0) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.info.value);
                      },
                      child: Icon(
                        Icons.info_rounded,
                        color: _mainMenuBottomNavManager
                                    .pupilProfileNavState.value ==
                                0
                            ? AppColors.backgroundColor
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Language Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                color: AppColors.backgroundColor, width: 2.0),
                            borderRadius: BorderRadius.zero),
                        backgroundColor: navigationBackgroundColor(
                            ProfileNavigation.language.value),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 1) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.language.value);
                      },
                      child: Icon(
                        Icons.language_rounded,
                        color: _mainMenuBottomNavManager
                                    .pupilProfileNavState.value ==
                                1
                            ? AppColors.groupColor
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Credit Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                color: AppColors.backgroundColor, width: 2.0),
                            borderRadius: BorderRadius.zero),
                        backgroundColor: navigationBackgroundColor(
                            ProfileNavigation.credit.value),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 2) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.credit.value);
                      },
                      child: Icon(
                        Icons.attach_money_rounded,
                        color: _mainMenuBottomNavManager
                                    .pupilProfileNavState.value ==
                                2
                            ? AppColors.accentColor
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Attendance Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                color: AppColors.backgroundColor, width: 2.0),
                            borderRadius: BorderRadius.zero),
                        backgroundColor: navigationBackgroundColor(
                            ProfileNavigation.attendance.value),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 3) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.attendance.value);
                      },
                      child: Icon(
                        Icons.calendar_month_rounded,
                        color: _mainMenuBottomNavManager
                                    .pupilProfileNavState.value ==
                                3
                            ? Colors.grey[800]
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- SchooldayEvent Button - bottom right border radius
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              color: AppColors.backgroundColor, width: 2.0),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                        ),
                        backgroundColor: navigationBackgroundColor(
                            ProfileNavigation.schooldayEvent.value),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 4) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.schooldayEvent.value);
                      },
                      child: Icon(
                        Icons.warning_rounded,
                        color: _mainMenuBottomNavManager
                                    .pupilProfileNavState.value ==
                                4
                            ? AppColors.accentColor
                            : Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //- OGS Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        backgroundColor: navigationBackgroundColor(
                            ProfileNavigation.ogs.value),
                      ),
                      onPressed: () {
                        if (pupilProfileNavState == 5) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.ogs.value);
                      },
                      child: Text(
                        'OGS',
                        style: TextStyle(
                            color: _mainMenuBottomNavManager
                                        .pupilProfileNavState.value ==
                                    5
                                ? AppColors.backgroundColor
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  //- Lists Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: navigationBackgroundColor(
                              ProfileNavigation.lists.value)),
                      onPressed: () {
                        if (pupilProfileNavState == 6) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.lists.value);
                      },
                      child: Icon(
                        Icons.rule,
                        color: _mainMenuBottomNavManager
                                    .pupilProfileNavState.value ==
                                6
                            ? Colors.grey[600]
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Authorization Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: navigationBackgroundColor(
                              ProfileNavigation.authorization.value)),
                      onPressed: () {
                        if (pupilProfileNavState == 7) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.authorization.value);
                      },
                      child: Icon(
                        Icons.fact_check_rounded,
                        color: _mainMenuBottomNavManager
                                    .pupilProfileNavState.value ==
                                7
                            ? Colors.grey[600]
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Learning supporn button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: navigationBackgroundColor(
                              ProfileNavigation.learningSupport.value)),
                      onPressed: () {
                        if (pupilProfileNavState == 8) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.learningSupport.value);
                      },
                      child: Icon(
                        Icons.support_rounded,
                        color: _mainMenuBottomNavManager
                                    .pupilProfileNavState.value ==
                                8
                            ? const Color.fromARGB(255, 245, 75, 75)
                            : Colors.white,
                      ),
                    ),
                  ),
                  //- Learning Button - bottom right border radius
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: navigationBackgroundColor(
                              ProfileNavigation.learning.value)),
                      onPressed: () {
                        if (pupilProfileNavState == 9) return;
                        _mainMenuBottomNavManager.setPupilProfileNavPage(
                            ProfileNavigation.learning.value);
                      },
                      child: Icon(
                        Icons.lightbulb,
                        color: _mainMenuBottomNavManager
                                    .pupilProfileNavState.value ==
                                9
                            ? AppColors.accentColor
                            : Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
