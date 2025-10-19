import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/services/pdf_generation_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_classes_pupil_list_page/widgets/missed_classes_filters.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/missed_classes_badges_info_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingListPageBottomNavBar extends WatchingWidget {
  const AttendanceRankingListPageBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final filtersActive = watchValue(
      (FiltersStateManager x) => x.filtersActive,
    );
    final pupils = watchValue((PupilsFilter x) => x.filteredPupils);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(10),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  tooltip: 'zurück',
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Gap(30),
                IconButton(
                  tooltip: 'Info',
                  icon: const Icon(Icons.info, size: 30),
                  onPressed: () async {
                    missedSchooldaysBadgesInformationDialog(context: context);
                  },
                ),
                const Gap(30),
                // FilterButton(
                //     isSearchBar: false,
                //     showBottomSheetFunction: () {
                //       showGenericFilterBottomSheet(
                //         context: context,
                //         filterList: [
                //           const CommonPupilFiltersWidget(),
                //           const MissedSchooldayFilters()
                //         ],
                //       );
                //     }),
                InkWell(
                  onTap: () {
                    showGenericFilterBottomSheet(
                      context: context,
                      filterList: [
                        const CommonPupilFiltersWidget(),
                        const MissedSchooldayFilters(),
                      ],
                    );
                  },
                  onLongPress: () {
                    di<FiltersStateManager>().resetFilters();
                  },
                  child: Icon(
                    Icons.filter_list,
                    color: filtersActive ? Colors.deepOrange : Colors.white,
                    size: 30,
                  ),
                ),
                const Gap(30),
                if (di<HubSessionManager>().isAdmin)
                  IconButton(
                    tooltip: 'PDF drucken',
                    icon: const Icon(Icons.print_rounded, size: 30),
                    onPressed: () async {
                      try {
                        final pdfFile =
                            await MissedSchooldaysPdfGenerator.generateMissedSchooldaysPdf(
                              pupils: pupils,
                            );
                        if (context.mounted) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
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
                                'Fehler beim Erstellen der PDF: $e',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                  ),
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
