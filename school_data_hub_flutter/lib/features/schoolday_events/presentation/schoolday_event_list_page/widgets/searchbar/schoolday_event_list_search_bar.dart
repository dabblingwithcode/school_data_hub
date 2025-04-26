import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/domain/filters/filters_state_manager.dart';
import 'package:schuldaten_hub/common/domain/models/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/presentation/widgets/pupil_search_text_field.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/schoolday_event_helper_functions.dart';
import 'package:schuldaten_hub/features/schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/schoolday_events/presentation/schoolday_event_list_page/widgets/searchbar/schoolday_event_stats_row.dart';
import 'package:watch_it/watch_it.dart';

class SchooldayEventListSearchBar extends WatchingWidget {
  const SchooldayEventListSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final pupils = watchValue((PupilsFilter x) => x.filteredPupils);
    final filtersActive =
        watchValue((FiltersStateManager x) => x.filtersActive);

    // Let's get the total numbers for the schoolday events variants
    final SchooldayEventsCounts schooldayEventsCounts =
        SchoolDayEventHelper.getSchooldayEventsCounts(pupils);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          const Gap(5),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.00),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SchooldayEventStats(
                  pupilsWithEventsCount:
                      SchoolDayEventHelper.pupilsWithSchoolDayEvents(),
                  schooldayEventsCount: schooldayEventsCounts,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                    child: PupilSearchTextField(
                        searchType: SearchType.pupil,
                        hintText: 'Schüler/in suchen',
                        refreshFunction: locator<PupilsFilter>().refreshs)),
                const Gap(5),
                InkWell(
                  onTap: () => showSchooldayEventFilterBottomSheet(context),
                  onLongPress: () {
                    locator<FiltersStateManager>().resetFilters();
                  },
                  child: Icon(
                    Icons.filter_list,
                    color: filtersActive ? Colors.deepOrange : Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
