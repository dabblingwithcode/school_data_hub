import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/services/attendance_pdf_generator.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/missed_schooldays_pupil_list_screen/widgets/missed_class_stats_widget.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/missed_schooldays_pupil_list_screen/widgets/missed_schooldays_filters.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/missed_schooldays_pupil_list_screen/widgets/missed_schooldays_pupil_list_card.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/missed_schoolday_badges_info_dialog.dart';

class MissedSchooldaysPupilListScreen extends StatelessWidget {
  const MissedSchooldaysPupilListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupilsFilter = di<PupilsFilter>();

    return ListScreen<PupilProxy>(
      title: 'Fehlzeiten',
      iconData: Icons.calendar_month_rounded,
      backgroundColor: style.colors.canvas,
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
        TappableIcon(
          icon: const Icon(Icons.info, size: 30),
          tooltip: 'Info',
          onPressed: () async {
            missedSchooldaysBadgesInformationDialog(context: context);
          },
        ),
        if (di<HubSessionManager>().isAdmin)
          TappableIcon(
            icon: const Icon(Icons.print_rounded, size: 30),
            tooltip: 'PDF drucken',
            onPressed: () {
              context.push(
                RoutePaths.utilPdfViewer,
                extra: {
                  'pdfGenerator': () =>
                      MissedSchooldaysPdfGenerator.generateMissedSchooldaysPdf(
                        pupils: pupilsFilter.filteredPupils.value,
                      ),
                  'title': 'Fehlzeitenliste PDF',
                  'iconData': Icons.calendar_month_rounded,
                },
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
