import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_filters_widget.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_pupil_list_card/schoolday_event_pupil_list_card.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/searchbar/schoolday_event_stats.dart';

class SchooldayEventListPage extends WatchingWidget {
  const SchooldayEventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilsFilter = di<PupilsFilter>();
    final filterManager = di<SchooldayEventFilterManager>();
    final itemsListenable = createOnce(
      () =>
          pupilsFilter.filteredPupils.combineLatest3<
            Map<SchooldayEventFilter, bool>,
            Set<int>,
            List<PupilProxy>
          >(
            filterManager.schooldayEventsFilterState,
            filterManager.pupilIdsWithFilteredSchooldayEvents,
            (pupils, state, ids) {
              if (!state.values.any((x) => x == true)) return pupils;
              return pupils.where((p) => ids.contains(p.pupilId)).toList();
            },
          ),
    );

    return GenericListPage<PupilProxy>(
      backgroundColor: AppColors.canvasColor,
      iconData: Icons.warning_amber_rounded,
      title: 'Ereignisse',
      sliverAppBarHeight: 110,

      searchBarConfig: GenericListSearchBarConfig(
        searchType: SearchType.pupil,
        hintText: 'Schüler/in suchen',
        refreshFunction: pupilsFilter.refresh,
        onChanged: (value) => pupilsFilter.textFilter.setFilterText(value),
        searchTextSource: pupilsFilter.textFilter,
        filtersActive: di<FiltersStateManager>().filtersActive,
        onResetFilters: pupilsFilter.resetFilters,
        statsWidget: SchooldayEventStats(
          pupilsWithEventsCount:
              SchoolDayEventHelper.pupilsWithSchoolDayEvents(),
        ),
      ),
      filterSheetChildren: const [
        CommonPupilFiltersWidget(),
        SchooldayEventFiltersWidget(),
      ],
      itemsListenable: itemsListenable,
      itemBuilder: (_, pupil) => KeyedSubtree(
        key: ValueKey(pupil.pupilId),
        child: SchooldayEventPupilListCard(pupil),
      ),
      onRefresh: () async => di<SchooldayEventManager>().fetchSchooldayEvents(),
      maxWidth: 700,
    );
  }
}
