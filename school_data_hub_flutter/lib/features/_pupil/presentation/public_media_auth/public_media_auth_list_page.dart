import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupil_media_auth_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/public_media_auth/widgets/public_media_auth_filters_widget.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/public_media_auth/widgets/public_media_auth_list_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/pupil_count_search_bar_stats.dart';

List<PupilProxy> _publicMediaAuthFilter(List<PupilProxy> pupils) {
  final filterStateManager = di<FiltersStateManager>();
  final mediaAuthFilterManager = di<PupilMediaAuthFilterManager>();
  final List<PupilProxy> filteredPupils = [];
  bool filtersOn = false;
  for (final pupil in pupils) {
    if (mediaAuthFilterManager.isMatchedByPublicMediaAuthFilters(pupil)) {
      filteredPupils.add(pupil);
    } else {
      filtersOn = true;
    }
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

class PublicMediaAuthListPage extends WatchingWidget {
  const PublicMediaAuthListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final filterStateManager = di<FiltersStateManager>();
    final pupilsFilter = di<PupilsFilter>();
    final pupilManager = di<PupilProxyManager>();
    List<PupilProxy> filteredPupils = watchValue(
      (PupilsFilter x) => x.filteredPupils,
    );
    watchValue(
      (PupilMediaAuthFilterManager x) => x.publicMediaAuthFilterState,
    );
    List<PupilProxy> pupils = _publicMediaAuthFilter(filteredPupils);
    final pupilsListenable =
        createOnce(() => ValueNotifier<List<PupilProxy>>([]));
    pupilsListenable.value = pupils;
    onDispose(() => filterStateManager.resetFilters());

    return PopScope(
      onPopInvokedWithResult: _onPop,
      child: GenericListPage<PupilProxy>(
        backgroundColor: AppColors.canvasColor,
        iconData: Icons.photo_library_rounded,
        title: 'Veröffentlichungseinwilligung',
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
          Gap(10),
          PublicMediaAuthFiltersWidget(),
        ],
        itemsListenable: pupilsListenable,
        itemBuilder: (_, pupil) => PublicMediaAuthListCard(pupil: pupil),
        onRefresh: () async => pupilManager.fetchAllPupils(),
        maxWidth: 800,
      ),
    );
  }
}
