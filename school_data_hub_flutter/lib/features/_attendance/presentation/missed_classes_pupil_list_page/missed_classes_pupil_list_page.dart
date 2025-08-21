import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_classes_pupil_list_page/widgets/missed_classes_pupil_list_card.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_classes_pupil_list_page/widgets/missed_classes_pupil_list_page_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_classes_pupil_list_page/widgets/missed_classes_pupil_list_searchbar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class MissedSchooldayesPupilListPage extends WatchingWidget {
  const MissedSchooldayesPupilListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
          iconData: Icons.calendar_month_rounded, title: 'Fehlzeiten'),
      body: RefreshIndicator(
        onRefresh: () async => di<PupilManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverSearchAppBar(
                  height: 110,
                  title: AttendanceRankingListSearchbar(pupils: pupils),
                ),
                GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (_, pupil) =>
                        AttendanceRankingListCard(pupil)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AttendanceRankingListPageBottomNavBar(),
    );
  }
}
