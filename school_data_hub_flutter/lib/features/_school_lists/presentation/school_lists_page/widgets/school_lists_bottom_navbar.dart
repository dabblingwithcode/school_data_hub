import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/round_button_switch.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_enums.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/new_list_page/new_school_list_page.dart';

class SchoolListsBottomNavBar extends WatchingWidget {
  const SchoolListsBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolListFilterManager = di<SchoolListFilterManager>();
    Map<SchoolListFilter, bool> filterState = watchValue(
      (SchoolListFilterManager x) => x.schoolListFilterState,
    );

    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(9),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              RoundButtonSwitch(
                icon: Icons.school_rounded,
                isActive: filterState[SchoolListFilter.publicLists] ?? false,
                onTap: () => schoolListFilterManager.togglePublicListsFilter(),
                activeBackgroundColor: AppColors.accentColor,
                inactiveBackgroundColor: AppColors.backgroundColor,
                activeIconColor: Colors.white,
                inactiveIconColor: Colors.white,
                iconSize: 20,
              ),
              const Gap(5),
              RoundButtonSwitch(
                icon: Icons.person_rounded,
                isActive: filterState[SchoolListFilter.myLists] ?? false,
                onTap: () => schoolListFilterManager.toggleMyListsFilter(),
                activeBackgroundColor: AppColors.accentColor,
                inactiveBackgroundColor: AppColors.backgroundColor,
                activeIconColor: Colors.white,
                inactiveIconColor: Colors.white,
                iconSize: 20,
              ),
              const Gap(5),
              RoundButtonSwitch(
                icon: Icons.people_rounded,
                isActive: filterState[SchoolListFilter.otherLists] ?? false,
                onTap: () => schoolListFilterManager.toggleOtherListsFilter(),
                activeBackgroundColor: AppColors.accentColor,
                inactiveBackgroundColor: AppColors.backgroundColor,
                activeIconColor: Colors.white,
                inactiveIconColor: Colors.white,
                iconSize: 20,
              ),
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 35),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(AppPaddings.bottomNavBarButtonGap),
              IconButton(
                tooltip: 'Neue Liste',
                icon: const Icon(Icons.add, size: 35),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const NewSchoolListPage(),
                    ),
                  );
                },
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
