import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_filters_widget.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_list_card.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_search_bar_stats.dart';

class LearningSupportListScreen extends WatchingWidget {
  const LearningSupportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilManager = di<PupilProxyManager>();
    final pupilsFilter = di<PupilsFilter>();
    final filterStateManager = di<FiltersStateManager>();

    return ListScreen<PupilProxy>(
      backgroundColor: Style.of(context).colors.canvas,
      iconData: Icons.support_rounded,
      title: 'Förderung',
      sliverAppBarHeight: 110,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: LearningSupportSearchBarStats(
          filteredPupils: pupilsFilter.filteredPupils,
        ),
        searchType: SearchType.pupil,
        hintText: 'Schüler/in suchen',
        refreshFunction: pupilsFilter.refresh,
        onChanged: (value) => pupilsFilter.textFilter.setFilterText(value),
        searchTextSource: pupilsFilter.textFilter,
        filtersActive: filterStateManager.filtersActive,
        onResetFilters: filterStateManager.resetFilters,
      ),
      filterSheetChildren: const [
        CommonPupilFiltersWidget(),
        LearningSupportFiltersWidget(),
      ],
      itemsListenable: pupilsFilter.filteredPupils,
      itemBuilder: (_, pupil) => LearningSupportCard(pupil),
      onRefresh: () async => pupilManager.fetchAllPupils(),
      maxWidth: 700,
    );
  }
}
