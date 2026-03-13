import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/services/attendance_pdf_generator.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_schooldays_pupil_list_page/widgets/missed_class_stats_widget.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_schooldays_pupil_list_page/widgets/missed_schooldays_filters.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_schooldays_pupil_list_page/widgets/missed_schooldays_pupil_list_card.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/missed_classes_badges_info_dialog.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';

class MissedSchooldaysPupilListPage extends StatelessWidget {
  const MissedSchooldaysPupilListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilsFilter = di<PupilsFilter>();

    return GenericListPage<PupilProxy>(
      title: 'Fehlzeiten',
      iconData: Icons.calendar_month_rounded,
      backgroundColor: AppColors.canvasColor,
      maxWidth: 700,
      onRefresh: () async => di<PupilProxyManager>().fetchAllPupils(),
      sliverAppBarHeight: 110,

      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: AttendanceRankingStats(
          pupilsListenable: pupilsFilter.filteredPupils,
        ),
        searchType: SearchType.pupil,
        hintText: 'Schüler/in suchen',
        refreshFunction: pupilsFilter.refresh,
        onChanged: (value) => pupilsFilter.textFilter.setFilterText(value),
        searchTextSource: pupilsFilter.textFilter,
        filtersActive: di<FiltersStateManager>().filtersActive,
        onResetFilters: pupilsFilter.resetFilters,
      ),

      itemsListenable: pupilsFilter.filteredPupils,
      itemBuilder: (_, pupil) => MissedSchooldaysPupilListCard(pupil),

      bottomBarActions: [
        IconButton(
          tooltip: 'Info',
          icon: const Icon(Icons.info, size: 30),
          onPressed: () async {
            missedSchooldaysBadgesInformationDialog(context: context);
          },
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
                        MissedSchooldaysPdfGenerator.generateMissedSchooldaysPdf(
                          pupils: pupilsFilter.filteredPupils.value,
                        ),
                    title: 'Fehlzeitenliste PDF',
                    iconData: Icons.calendar_month_rounded,
                  ),
                ),
              );
            },
          ),
      ],
      filterSheetChildren: const [
        CommonPupilFiltersWidget(),
        MissedSchooldayFilters(),
      ],
    );
  }
}
