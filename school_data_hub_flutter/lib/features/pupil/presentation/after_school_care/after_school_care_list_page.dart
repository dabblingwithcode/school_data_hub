import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/after_school_care/widgets/after_school_care_list_card.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/after_school_care/widgets/after_school_care_list_search_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/after_school_care/widgets/after_school_care_view_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

List<PupilProxy> _afterSchoolCareFilter(List<PupilProxy> pupils) {
  List<PupilProxy> filteredPupils = [];
  for (PupilProxy pupil in pupils) {
    if (!pupil.ogs == true) {
      di<FiltersStateManager>().setFilterState(
        filterState: FilterState.pupil,
        value: true,
      );

      continue;
    }
    filteredPupils.add(pupil);
  }
  return filteredPupils;
}

class OgsListPage extends WatchingWidget {
  const OgsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);

    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    List<PupilProxy> ogsPupils = _afterSchoolCareFilter(pupils);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.restaurant_menu_rounded,
        title: 'OGS Infos',
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            di<PupilProxyManager>().updatePupilList(ogsPupils),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverSearchAppBar(
                  height: 110,
                  title: AfterSchoolCareListSearchBar(
                    pupils: ogsPupils,
                    filtersOn: filtersOn,
                  ),
                ),
                GenericSliverListWithEmptyListCheck(
                  items: ogsPupils,
                  itemBuilder: (_, pupil) => AfterSchoolCareCard(pupil),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AfterSchoolCareListPageBottomNavBar(
        filtersOn: filtersOn,
      ),
    );
  }
}
