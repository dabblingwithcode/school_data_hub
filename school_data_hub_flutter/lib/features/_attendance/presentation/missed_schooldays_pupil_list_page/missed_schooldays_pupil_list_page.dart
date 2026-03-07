import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
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
      backgroundColor: AppColors.canvasColor,
      iconData: Icons.calendar_month_rounded,
      title: 'Fehlzeiten',
      sliverAppBarHeight: 110,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: AttendanceRankingStats(
          pupilsListenable: pupilsFilter.filteredPupils,
        ),
        searchType: SearchType.pupil,
        hintText: 'Schüler/in suchen',
        refreshFunction: pupilsFilter.refreshs,
        onChanged: (value) => pupilsFilter.textFilter.setFilterText(value),
        searchTextSource: pupilsFilter.textFilter,
        filtersActive: di<FiltersStateManager>().filtersActive,
        onResetFilters: pupilsFilter.resetFilters,
      ),

      filterSheetChildren: const [
        CommonPupilFiltersWidget(),
        MissedSchooldayFilters(),
      ],
      itemsListenable: pupilsFilter.filteredPupils,
      itemBuilder: (_, pupil) => MissedSchooldaysPupilListCard(pupil),
      onRefresh: () async => di<PupilProxyManager>().fetchAllPupils(),
      maxWidth: 700,
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
            onPressed: () async {
              try {
                final pupils = pupilsFilter.filteredPupils.value;
                final pdfFile =
                    await MissedSchooldaysPdfGenerator.generateMissedSchooldaysPdf(
                      pupils: pupils,
                    );
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          MissedSchooldaysPdfViewPage(pdfFile: pdfFile),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Fehler beim Erstellen der PDF: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
      ],
    );
  }
}
