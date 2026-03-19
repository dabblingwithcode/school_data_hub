import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/icon_toggle.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_enums.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/new_list_screen/new_school_list_screen.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_lists_screen/widgets/school_list_card.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_lists_screen/widgets/school_list_search_text_field.dart';

class SchoolListsScreen extends WatchingWidget {
  const SchoolListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final schoolListFilterManager = di<SchoolListFilterManager>();
    final schoolListManager = di<SchoolListManager>();
    bool filtersOn = watchValue((SchoolListFilterManager x) => x.filterState);
    List<SchoolList> filteredSchoolLists = watchValue(
      (SchoolListFilterManager x) => x.filteredSchoolLists,
    );

    Map<SchoolListFilter, bool> filterState = watchValue(
      (SchoolListFilterManager x) => x.schoolListFilterState,
    );

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
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
                      Text(
                        'Gesamt:',
                        style: context.typography.bodySmall,
                      ),
                      const Gap(10),
                      Text(
                        filteredSchoolLists.length.toString(),
                        style: context.typography.title.withColor(
                          style.colors.foreground,
                        ),
                      ),
                      const Spacer(),
                      IconToggle(
                        icon: Icons.school_rounded,
                        isActive:
                            filterState[SchoolListFilter.publicLists] ?? false,
                        onTap: () =>
                            schoolListFilterManager.togglePublicListsFilter(),
                        activeBackgroundColor: style.colors.accent,
                        inactiveBackgroundColor: style.colors.accent,
                        activeIconColor: style.colors.background,
                        inactiveIconColor: style.colors.background,
                        iconSize: 20,
                      ),
                      const Gap(5),
                      IconToggle(
                        icon: Icons.person_rounded,
                        isActive:
                            filterState[SchoolListFilter.myLists] ?? false,
                        onTap: () =>
                            schoolListFilterManager.toggleMyListsFilter(),
                        activeBackgroundColor: style.colors.accent,
                        inactiveBackgroundColor: style.colors.accent,
                        activeIconColor: style.colors.background,
                        inactiveIconColor: style.colors.background,
                        iconSize: 20,
                      ),
                      const Gap(5),
                      IconToggle(
                        icon: Icons.people_rounded,
                        isActive:
                            filterState[SchoolListFilter.otherLists] ?? false,
                        onTap: () =>
                            schoolListFilterManager.toggleOtherListsFilter(),
                        activeBackgroundColor: style.colors.accent,
                        inactiveBackgroundColor: style.colors.accent,
                        activeIconColor: style.colors.background,
                        inactiveIconColor: style.colors.background,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.filter_list,
                            color: filtersOn
                                ? style.colors.error
                                : style.colors.mutedForeground,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(10),
                filteredSchoolLists.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Keine Ergebnisse',
                            style: context.typography.title,
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
      bottomNavigationBar: ActionBar(
        actions: [
          TappableIcon(
            tooltip: 'Neue Liste',
            icon: const Icon(Icons.add, size: 35),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (ctx) => const NewSchoolListScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
