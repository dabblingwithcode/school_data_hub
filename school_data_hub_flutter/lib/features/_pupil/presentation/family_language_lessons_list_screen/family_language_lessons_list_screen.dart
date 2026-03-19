import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/family_language_lessons_list_screen/widgets/family_language_lessons_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/family_language_lessons_list_screen/widgets/family_language_lessons_filters_widget.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/pupil_count_search_bar_stats.dart';

List<PupilProxy> familyLanguageLessonsFilter(List<PupilProxy> pupils) {
  final filterStateManager = di<FiltersStateManager>();
  final List<PupilProxy> filteredPupils = [];
  bool filtersOn = false;
  for (PupilProxy pupil in pupils) {
    if (pupil.familyLanguageLessonsSince == null) {
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

class FamilyLanguageLessonsListScreen extends WatchingWidget {
  const FamilyLanguageLessonsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterStateManager = di<FiltersStateManager>();
    final pupilsFilter = di<PupilsFilter>();
    final pupilManager = di<PupilProxyManager>();
    List<PupilProxy> filteredPupils = watchValue(
      (PupilsFilter x) => x.filteredPupils,
    );
    List<PupilProxy> pupils = familyLanguageLessonsFilter(filteredPupils);
    final pupilsListenable = createOnce(
      () => ValueNotifier<List<PupilProxy>>([]),
    );
    pupilsListenable.value = pupils;
    onDispose(() => filterStateManager.resetFilters());

    return PopScope(
      onPopInvokedWithResult: _onPop,
      child: ListScreen<PupilProxy>(
        backgroundColor: Style.of(context).colors.canvas,
        iconData: Icons.translate,
        title: 'Herkunftssprachlicher U.',
        sliverAppBarHeight: 110,
        searchBarConfig: GenericListSearchBarConfig(
          statsWidget: PupilCountSearchBarStats(
            filteredPupils: pupilsListenable,
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
          FamilyLanguageLessonsFiltersWidget(),
        ],
        itemsListenable: pupilsListenable,
        itemBuilder: (_, pupil) => FamilyLanguageLessonsCard(pupil),
        onRefresh: () async => pupilManager.fetchAllPupils(),
        maxWidth: 700,
      ),
    );
  }
}
