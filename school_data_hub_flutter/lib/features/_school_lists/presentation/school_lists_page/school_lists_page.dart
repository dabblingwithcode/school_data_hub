import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/icon_toggle.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_enums.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/new_list_page/new_school_list_page.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_lists_page/widgets/school_list_card.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_lists_page/widgets/school_list_search_text_field.dart';

class SchoolListsPage extends WatchingWidget {
  const SchoolListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolListFilterManager = di<SchoolListFilterManager>();
    final schoolListManager = di<SchoolListManager>();
    bool filtersOn = watchValue((SchoolListFilterManager x) => x.filterState);
    // List<SchoolList> schoolLists =
    //     watchPropertyValue((SchoolListManager x) => x.schoolLists);
    // _schoolListFilterManager.updateFilteredSchoolLists(schoolLists);
    List<SchoolList> filteredSchoolLists = watchValue(
      (SchoolListFilterManager x) => x.filteredSchoolLists,
    );

    Map<SchoolListFilter, bool> filterState = watchValue(
      (SchoolListFilterManager x) => x.schoolListFilterState,
    );
    // List<SchoolList> visibleSchoolLists = schoolLists
    //     .where((element) =>
    //         element.visibility == 'public' ||
    //         element.createdBy == session.username ||
    //         element.visibility.contains(session.username!))
    //     .toList();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.rule_rounded,
        title: 'Listen',
      ),

      body: RefreshIndicator(
        onRefresh: () async => schoolListManager.fetchSchoolLists(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 15.0,
                    right: 10.00,
                  ),
                  child: Row(
                    children: [
                      const Text('Gesamt:', style: TextStyle(fontSize: 13)),
                      const Gap(10),
                      Text(
                        filteredSchoolLists.length.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      IconToggle(
                        icon: Icons.school_rounded,
                        isActive:
                            filterState[SchoolListFilter.publicLists] ?? false,
                        onTap: () =>
                            schoolListFilterManager.togglePublicListsFilter(),
                        activeBackgroundColor: AppColors.accentColor,
                        inactiveBackgroundColor: AppColors.backgroundColor,
                        activeIconColor: Colors.white,
                        inactiveIconColor: Colors.white,
                        iconSize: 20,
                      ),
                      const Gap(5),
                      IconToggle(
                        icon: Icons.person_rounded,
                        isActive:
                            filterState[SchoolListFilter.myLists] ?? false,
                        onTap: () =>
                            schoolListFilterManager.toggleMyListsFilter(),
                        activeBackgroundColor: AppColors.accentColor,
                        inactiveBackgroundColor: AppColors.backgroundColor,
                        activeIconColor: Colors.white,
                        inactiveIconColor: Colors.white,
                        iconSize: 20,
                      ),
                      const Gap(5),
                      IconToggle(
                        icon: Icons.people_rounded,
                        isActive:
                            filterState[SchoolListFilter.otherLists] ?? false,
                        onTap: () =>
                            schoolListFilterManager.toggleOtherListsFilter(),
                        activeBackgroundColor: AppColors.accentColor,
                        inactiveBackgroundColor: AppColors.backgroundColor,
                        activeIconColor: Colors.white,
                        inactiveIconColor: Colors.white,
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SchoolListSearchTextField(
                          searchType: SearchType.list,
                          hintText: 'Liste suchen',
                          refreshFunction: schoolListManager.fetchSchoolLists,
                        ),
                      ),

                      InkWell(
                        onTap: () {},

                        onLongPress: () =>
                            schoolListFilterManager.resetFilters(),
                        // onPressed: () => showBottomSheetFilters(context),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.filter_list,
                            color: filtersOn ? Colors.deepOrange : Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(10),
                filteredSchoolLists.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Keine Ergebnisse',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: filteredSchoolLists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SchoolListCard(
                              schoolList: filteredSchoolLists[index],
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          IconButton(
            tooltip: 'Neue Liste',
            icon: const Icon(Icons.add, size: 35),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (ctx) => const NewSchoolListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
