import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/common/widgets/list_view_components/generic_app_bar.dart';
import 'package:schuldaten_hub/common/widgets/list_view_components/generic_bottom_nav_bar.dart';
import 'package:schuldaten_hub/common/widgets/list_view_components/generic_sliver_list.dart';
import 'package:schuldaten_hub/common/widgets/list_view_components/generic_sliver_search_app_bar.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/domain/pupil_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_pupil_list_card/schoolday_event_pupil_list_card.dart';
import 'package:schuldaten_hub/features/schoolday_events/presentation/schoolday_event_list_page/widgets/searchbar/schoolday_event_list_search_bar.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventListPage extends WatchingWidget {
  const SchooldayEventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //- TODO: check how this works
    // pushScope(
    //     init: (locator) => locator.registerSingleton<PupilsFilter>(
    //         locator<PupilManager>().getPupilFilter()));
    //-TODO: Filterstate in SchooldayEventSearchbar and SchooldayEventListPageBottomNavBar

    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
          iconData: Icons.warning_amber_rounded, title: 'Ereignisse'),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                const GenericSliverSearchAppBar(
                  height: 110,
                  title: SchooldayEventListSearchBar(),
                ),
                GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (_, pupil) =>
                        SchooldayEventPupilListCard(pupil)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const GenericBottomNavBar(
        specificFilterBottomSheetFunction: showSchooldayEventFilterBottomSheet,
        bottomNavBarButtons: null,
      ),
    );
  }
}
