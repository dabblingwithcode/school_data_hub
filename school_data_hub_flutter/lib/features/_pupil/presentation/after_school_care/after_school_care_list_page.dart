import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/after_school_care/widgets/after_school_care_filters_widget.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/after_school_care/widgets/after_school_care_list_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/pupil_count_search_bar_stats.dart';

List<PupilProxy> _afterSchoolCareFilter(List<PupilProxy> pupils) {
  bool filtersOn = false;
  final List<PupilProxy> filteredPupils = [];
  for (PupilProxy pupil in pupils) {
    if (pupil.afterSchoolCare == null) {
      filtersOn = true;
      continue;
    }
    filteredPupils.add(pupil);
  }
  if (filtersOn) {
    di<FiltersStateManager>().setFilterState(
      filterState: FilterState.pupil,
      value: true,
    );
  }
  return filteredPupils;
}

class AfterSchoolListScreen extends WatchingWidget {
  const AfterSchoolListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilsFilter = di<PupilsFilter>();
    final filterStateManager = di<FiltersStateManager>();
    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);
    List<PupilProxy> ogsPupils = _afterSchoolCareFilter(pupils);
    final ogsPupilsListenable =
        createOnce(() => ValueNotifier<List<PupilProxy>>([]));
    ogsPupilsListenable.value = ogsPupils;

    return ListScreen<PupilProxy>(
      backgroundColor: Style.of(context).colors.canvas,
      iconData: Icons.restaurant_menu_rounded,
      title: 'OGS Infos',
      sliverAppBarHeight: 105,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: PupilCountSearchBarStats(
          filteredPupils: ogsPupilsListenable,
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
        AfterSchoolCareFiltersWidget(),
      ],
      itemsListenable: ogsPupilsListenable,
      itemBuilder: (_, pupil) => AfterSchoolCareCard(pupil),
      onRefresh: () async => di<PupilProxyManager>().fetchAllPupils(),
      maxWidth: 800,
    );
  }
}
