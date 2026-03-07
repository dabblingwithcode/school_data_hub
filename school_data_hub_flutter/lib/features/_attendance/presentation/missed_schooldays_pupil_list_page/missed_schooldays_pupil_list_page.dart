import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_schooldays_pupil_list_page/widgets/missed_schooldays_pupil_list_card.dart';
import 'package:school_data_hub_flutter/common/services/attendance_pdf_generator.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_schooldays_pupil_list_page/widgets/missed_schooldays_filters.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/missed_classes_badges_info_dialog.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_schooldays_pupil_list_page/widgets/attendance_ranking_pupil_list_searchbar.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:flutter_it/flutter_it.dart';

class MissedSchooldaysPupilListPage extends WatchingWidget {
  const MissedSchooldaysPupilListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.calendar_month_rounded,
        title: 'Fehlzeiten',
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<PupilProxyManager>().fetchAllPupils(),
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
                      MissedSchooldaysPupilListCard(pupil),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          IconButton(
            tooltip: 'Info',
            icon: const Icon(Icons.info, size: 30),
            onPressed: () async {
              missedSchooldaysBadgesInformationDialog(context: context);
            },
          ),
          GenericFilterButton(
            isSearchBar: false,
            showBottomSheetFunction: (context) => showGenericFilterBottomSheet(
              context: context,
              filterList: [
                const CommonPupilFiltersWidget(),
                const MissedSchooldayFilters(),
              ],
            ),
          ),
          if (di<HubSessionManager>().isAdmin)
            IconButton(
              tooltip: 'PDF drucken',
              icon: const Icon(Icons.print_rounded, size: 30),
              onPressed: () async {
                try {
                  final pdfFile =
                      await MissedSchooldaysPdfGenerator
                          .generateMissedSchooldaysPdf(pupils: pupils);
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
                        content: Text(
                            'Fehler beim Erstellen der PDF: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
        ],
      ),
    );
  }
}
