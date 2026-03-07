import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
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

    return GenericListPage<PupilProxy>(
      backgroundColor: AppColors.canvasColor,
      iconData: Icons.warning_amber_rounded,
      title: 'Ereignisse',
      sliverAppBarHeight: 110,

      searchBarConfig: GenericListSearchBarConfig(
        searchType: SearchType.pupil,
        hintText: 'Schüler/in suchen',
        refreshFunction: pupilsFilter.refreshs,
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
      itemsListenable: pupilsFilter.filteredPupils,
      itemBuilder: (_, pupil) => SchooldayEventPupilListCard(pupil),
      onRefresh: () async => di<SchooldayEventManager>().fetchSchooldayEvents(),
      maxWidth: 700,
    );
  }
}
