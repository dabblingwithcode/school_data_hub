import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/religion_page/widgets/religion_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/religion_page/widgets/religion_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/pupil_count_search_bar_stats.dart';

List<PupilProxy> religionFilter(List<PupilProxy> pupils) {
  final filterStateManager = di<FiltersStateManager>();
  final List<PupilProxy> filteredPupils = [];
  bool filtersOn = false;
  for (PupilProxy pupil in pupils) {
    if (pupil.religionLessonsSince == null) {
      filtersOn = true;
      continue;
    }
    if (pupil.religionLessonsCancelledAt != null &&
        pupil.religionLessonsCancelledAt!.isAfter(
          pupil.religionLessonsSince!,
        )) {
      filtersOn = true;
      continue;
    }
    filteredPupils.add(pupil);
  }
  if (filtersOn) {
    filterStateManager.setFilterState(
      filterState: FilterState.pupil,
      value: true,
    );
  }
  return filteredPupils;
}

void _onPop(bool didPop, dynamic result) {
  di<FiltersStateManager>().resetFilters();
}

class ReligionListPage extends WatchingWidget {
  const ReligionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final filterStateManager = di<FiltersStateManager>();
    final pupilsFilter = di<PupilsFilter>();
    final pupilManager = di<PupilProxyManager>();
    List<PupilProxy> filteredPupils = watchValue(
      (PupilsFilter x) => x.filteredPupils,
    );
    List<PupilProxy> pupils = religionFilter(filteredPupils);
    final pupilsListenable =
        createOnce(() => ValueNotifier<List<PupilProxy>>([]));
    pupilsListenable.value = pupils;
    onDispose(() => filterStateManager.resetFilters());

    return PopScope(
      onPopInvokedWithResult: _onPop,
      child: GenericListPage<PupilProxy>(
        backgroundColor: AppColors.canvasColor,
        iconData: Icons.church,
        title: 'Religion',
        sliverAppBarHeight: 110,
        searchBarConfig: GenericListSearchBarConfig(
          statsWidget: PupilCountSearchBarStats(
            filteredPupils: pupilsListenable,
          ),
          searchType: SearchType.pupil,
          hintText: 'Schüler/in suchen',
          refreshFunction: pupilsFilter.refreshs,
          onChanged: (value) => pupilsFilter.textFilter.setFilterText(value),
          searchTextSource: pupilsFilter.textFilter,
          filtersActive: filterStateManager.filtersActive,
          onResetFilters: filterStateManager.resetFilters,
        ),
        filterSheetChildren: const [
          CommonPupilFiltersWidget(),
          Gap(10),
          ReligionFiltersSection(),
        ],
        itemsListenable: pupilsListenable,
        itemBuilder: (_, pupil) => ReligionCard(pupil),
        onRefresh: () async => pupilManager.fetchAllPupils(),
        maxWidth: 700,
      ),
    );
  }
}
