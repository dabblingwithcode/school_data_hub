import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_screen.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/services/attendance_pdf_generator.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/content_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/search_row.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/sliver_search_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_helper.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_screen/widgets/attendance_filters.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_screen/widgets/attendance_list_card.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_screen/widgets/attendance_search_bar_stats.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/missed_schoolday_badges_info_dialog.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class AttendanceListScreen extends WatchingWidget {
  const AttendanceListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
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

    void openFilterSheet(BuildContext ctx) {
      showSheet(
        ctx,
        const FilterSheet(
          children: [CommonPupilFiltersWidget(), AttendanceFilters()],
        ),
      );
    }

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppHeader(
        onTitleTap: () async => AttendanceHelper.setThisDate(context, thisDate),
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.today_rounded,
              color: AttendanceHelper.schooldayIsToday(thisDate)
                  ? const Color.fromARGB(255, 83, 196, 55)
                  : style.colors.background,
              size: 30,
            ),
            const Gap(10),
            Text(
              '${thisDate.asWeekdayName(context)}, ${thisDate.formatDateForUser()}',
              style: context.typography.heading,
            ),
          ],
        ),
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
                SliverSearchBar(
                  height: 110,
                  searchWidgetWithStatsRow: SearchRow(
                    statsWidget: const AttendanceSearchBarStatsWidget(),
                    searchType: SearchType.pupil,
                    hintText: 'Schüler/in suchen',
                    refreshFunction: pupilsFilter.refresh,
                    onChanged: (value) =>
                        pupilsFilter.textFilter.setFilterText(value),
                    searchTextSource: pupilsFilter.textFilter,
                    filtersActive: filterStateManager.filtersActive,
                    onResetFilters: filterStateManager.resetFilters,
                    showFilterBottomSheet: openFilterSheet,
                  ),
                ),
                ContentSliverList(
                  itemsListenable: pupilsFilter.filteredPupils,
                  itemBuilder: (_, pupil) => AttendanceCard(pupil, thisDate),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ActionBar(
        actions: [
          TappableIcon(
            icon: const Icon(Icons.info, size: 30),
            tooltip: 'Info',
            onPressed: () async {
              missedSchooldaysBadgesInformationDialog(
                context: context,
                isAttendancePage: true,
              );
            },
          ),
          TappableIcon(
            icon: const Icon(Icons.today_rounded, size: 30),
            tooltip: 'Datum wechseln',
            onPressed: () async {
              final DateTime? newDate = await selectSchooldayDate(
                context,
                thisDate,
              );
              if (newDate != null) {
                di<SchoolCalendarManager>().setThisDate(newDate);
              }
            },
          ),
          FilterButton(
            isSearchBar: false,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: () => di<FiltersStateManager>().resetFilters(),
            showBottomSheetFunction: openFilterSheet,
          ),
          if (di<HubSessionManager>().isAdmin)
            TappableIcon(
              icon: const Icon(Icons.print_rounded, size: 30),
              tooltip: 'PDF drucken',
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute<void>(
                    builder: (context) => PdfViewerScreen(
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
