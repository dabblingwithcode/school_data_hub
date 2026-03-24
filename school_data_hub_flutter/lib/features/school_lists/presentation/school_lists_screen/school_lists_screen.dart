import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/icon_toggle.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_enums.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_lists_screen/widgets/school_list_card.dart';

class SchoolListsScreen extends StatelessWidget {
  const SchoolListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolListManager = di<SchoolListManager>();
    final schoolListFilterManager = di<SchoolListFilterManager>();
    final filtersStateManager = di<FiltersStateManager>();

    return ListScreen<SchoolList>(
      iconData: Icons.rule_rounded,
      title: 'Listen',
      backgroundColor: Style.of(context).colors.canvas,
      maxWidth: 700,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: const _SchoolListStatsRow(),
        searchType: SearchType.list,
        hintText: 'Liste suchen',
        refreshFunction: schoolListManager.fetchSchoolLists,
        onChanged: schoolListFilterManager.onSearchTextSchoolListsFilter,
        filtersActive: filtersStateManager.filtersActive,
        onResetFilters: schoolListFilterManager.resetFilters,
      ),
      itemsListenable: schoolListFilterManager.filteredSchoolLists,
      itemBuilder: (context, schoolList) =>
          SchoolListCard(schoolList: schoolList),
      onRefresh: () async => schoolListManager.fetchSchoolLists(),
      bottomBarActions: [
        TappableIcon(
          tooltip: 'Neue Liste',
          icon: const Icon(Icons.add, size: 35),
          onPressed: () {
            context.push(RoutePaths.schoolListNew);
          },
        ),
      ],
    );
  }
}

class _SchoolListStatsRow extends WatchingWidget {
  const _SchoolListStatsRow();

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final schoolListFilterManager = di<SchoolListFilterManager>();
    final filteredSchoolLists = watchValue(
      (SchoolListFilterManager x) => x.filteredSchoolLists,
    );
    final filterState = watchValue(
      (SchoolListFilterManager x) => x.schoolListFilterState,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
      child: Row(
        children: [
          Text('Gesamt:', style: context.typography.bodySmall),
          const Gap(10),
          Text(
            filteredSchoolLists.length.toString(),
            style: context.typography.title.withColor(style.colors.foreground),
          ),
          const Spacer(),
          IconToggle(
            icon: Icons.school_rounded,
            isActive: filterState[SchoolListFilter.publicLists] ?? false,
            onTap: () => schoolListFilterManager.togglePublicListsFilter(),
            activeBackgroundColor: style.colors.accent,
            inactiveBackgroundColor: style.colors.accent,
            activeIconColor: style.colors.background,
            inactiveIconColor: style.colors.background,
            iconSize: 20,
          ),
          const Gap(5),
          IconToggle(
            icon: Icons.person_rounded,
            isActive: filterState[SchoolListFilter.myLists] ?? false,
            onTap: () => schoolListFilterManager.toggleMyListsFilter(),
            activeBackgroundColor: style.colors.accent,
            inactiveBackgroundColor: style.colors.accent,
            activeIconColor: style.colors.background,
            inactiveIconColor: style.colors.background,
            iconSize: 20,
          ),
          const Gap(5),
          IconToggle(
            icon: Icons.people_rounded,
            isActive: filterState[SchoolListFilter.otherLists] ?? false,
            onTap: () => schoolListFilterManager.toggleOtherListsFilter(),
            activeBackgroundColor: style.colors.accent,
            inactiveBackgroundColor: style.colors.accent,
            activeIconColor: style.colors.background,
            inactiveIconColor: style.colors.background,
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}
