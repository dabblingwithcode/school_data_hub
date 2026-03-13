import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/services/attendance_pdf_generator.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_search_bar_with_stats.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_filters.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_list_card.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_search_bar_stats.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/missed_classes_badges_info_dialog.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class AttendanceListPage extends WatchingWidget {
  const AttendanceListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final attendanceManager = di<AttendanceManager>();
    final pupilsFilter = di<PupilsFilter>();
    final filterStateManager = di<FiltersStateManager>();

    DateTime thisDate = watchValue(
      (SchoolCalendarManager x) => x.thisDate,
    ).toLocal();

    callOnce((context) {
      attendanceManager.fetchMissedSchooldayesOnASchoolday(thisDate);
    });

    // Do not watch global missedSchooldays here: it would rebuild the entire list
    // when any child's attendance changes. Each AttendanceCard's _AttendanceData
    // watches only that pupil's getPupilMissedSchooldaysProxy(pupilId).

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: InkWell(
          onTap: () async => AttendanceHelper.setThisDate(context, thisDate),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.today_rounded,
                color: AttendanceHelper.schooldayIsToday(thisDate)
                    ? const Color.fromARGB(255, 83, 196, 55)
                    : Colors.white,
                size: 30,
              ),
              const Gap(10),
              Text(
                '${thisDate.asWeekdayName(context)}, ${thisDate.formatDateForUser()}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            attendanceManager.fetchMissedSchooldayesOnASchoolday(thisDate),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverAppBarWithSearchWidget(
                  height: 110,
                  searchWidgetWithStatsRow: GenericListSearchBarWithStats(
                    statsWidget: const AttendanceSearchBarStatsWidget(),
                    searchType: SearchType.pupil,
                    hintText: 'Schüler/in suchen',
                    refreshFunction: pupilsFilter.refresh,
                    onChanged: (value) =>
                        pupilsFilter.textFilter.setFilterText(value),
                    searchTextSource: pupilsFilter.textFilter,
                    filtersActive: filterStateManager.filtersActive,
                    onResetFilters: filterStateManager.resetFilters,
                    showFilterBottomSheet: (context) =>
                        showGenericFilterBottomSheet(
                          context: context,
                          filterList: const [
                            CommonPupilFiltersWidget(),
                            AttendanceFilters(),
                          ],
                        ),
                  ),
                ),
                GenericSliverListWithEmptyListCheck(
                  itemsListenable: pupilsFilter.filteredPupils,
                  itemBuilder: (_, pupil) => AttendanceCard(pupil, thisDate),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: //const AttendanceListPageBottomNavBar(),
      GenericBottomNavBar(
        actions: [
          IconButton(
            tooltip: 'Info',
            icon: const Icon(Icons.info, size: 30),
            onPressed: () async {
              missedSchooldaysBadgesInformationDialog(
                context: context,
                isAttendancePage: true,
              );
            },
          ),
          IconButton(
            tooltip: 'Datum wechseln',
            icon: const Icon(Icons.today_rounded, size: 30),
            onPressed: () async {
              final DateTime? newDate = await selectSchooldayDate(
                context,
                thisDate,
              );
              if (newDate != null) {
                di<SchoolCalendarManager>().setThisDate(newDate);
              }
            },
            onLongPress: () => di<SchoolCalendarManager>().getThisDate(),
          ),

          GenericFilterButton(
            isSearchBar: false,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: () => di<FiltersStateManager>().resetFilters(),
            showBottomSheetFunction: (context) => showGenericFilterBottomSheet(
              context: context,
              filterList: [
                const CommonPupilFiltersWidget(),
                const AttendanceFilters(),
              ],
            ),
          ),

          if (di<HubSessionManager>().isAdmin)
            IconButton(
              tooltip: 'PDF drucken',
              icon: const Icon(Icons.print_rounded, size: 30),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => PdfViewerPage(
                      pdfGenerator: () =>
                          AttendancePdfGenerator.generateAttendancePdf(
                            date: thisDate,
                            pupils: pupilsFilter.filteredPupils.value,
                          ),
                      title: 'Anwesenheitsliste PDF',
                      iconData: Icons.list_alt_rounded,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
