import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/special_info_page/widgets/special_info_card.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/special_info_page/widgets/special_info_list_page_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/special_info_page/widgets/special_info_list_search_bar.dart';
import 'package:watch_it/watch_it.dart';

List<PupilProxy> specialInfoFilter(List<PupilProxy> pupils) {
  final _filterStateManager = di<FiltersStateManager>();
  List<PupilProxy> filteredPupils = [];
  bool filtersOn = false;
  for (PupilProxy pupil in pupils) {
    if (pupil.specialInformation == null || pupil.specialInformation!.isEmpty) {
      filtersOn = true;
      continue;
    }

    filteredPupils.add(pupil);
  }
  if (filtersOn) {
    _filterStateManager.setFilterState(
      filterState: FilterState.pupil,
      value: true,
    );
  }
  return filteredPupils;
}

void _onPop(bool didPop, dynamic result) {
  final _filterStateManager = di<FiltersStateManager>();
  _filterStateManager.resetFilters();
}

class SpecialInfoListPage extends WatchingWidget {
  const SpecialInfoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _filterStateManager = di<FiltersStateManager>();
    final _pupilManager = di<PupilProxyManager>();
    List<PupilProxy> filteredPupils = watchValue(
      (PupilsFilter x) => x.filteredPupils,
    );
    List<PupilProxy> pupils = specialInfoFilter(filteredPupils);
    onDispose(() {
      _filterStateManager.resetFilters();
    });
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => _onPop(didPop, result),
      child: Scaffold(
        backgroundColor: AppColors.canvasColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emergency_rounded, size: 25, color: Colors.white),
              Gap(10),
              Text('Besondere Infos', style: AppStyles.appBarTextStyle),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          onRefresh: () async => _pupilManager.updatePupilList(pupils),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: CustomScrollView(
                slivers: [
                  const SliverGap(5),
                  GenericSliverSearchAppBar(
                    height: 110,
                    title: SpecialInfoListSearchBar(pupils: pupils),
                  ),
                  GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (_, pupil) => SpecialInfoCard(pupil),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SpecialInfoListPageBottomNavBar(),
      ),
    );
  }
}
