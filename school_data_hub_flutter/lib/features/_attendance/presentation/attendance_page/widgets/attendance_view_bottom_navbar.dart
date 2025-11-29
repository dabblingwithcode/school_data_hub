import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/services/pdf_generation_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_filters.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/missed_classes_badges_info_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceListPageBottomNavBar extends WatchingWidget {
  const AttendanceListPageBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final _schoolCalendarManager = di<SchoolCalendarManager>();
    final _filterStateManager = di<FiltersStateManager>();
    DateTime thisDate =
        watchValue((SchoolCalendarManager x) => x.thisDate).toLocal();
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
    final pupils = watchValue((PupilsFilter x) => x.filteredPupils);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(10),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
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
                  missedSchooldaysBadgesInformationDialog(
                    context: context,
                    isAttendancePage: true,
                  );
                },
              ),
              const Gap(30),
              InkWell(
                onTap: () async {
                  final DateTime? newDate = await selectSchooldayDate(
                    context,
                    thisDate,
                  );
                  if (newDate != null) {
                    _schoolCalendarManager.setThisDate(newDate);
                  }
                },
                onLongPress: () => _schoolCalendarManager.getThisDate(),
                child: const Icon(
                  Icons.today_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const Gap(30),
              InkWell(
                onTap:
                    () => showGenericFilterBottomSheet(
                      context: context,
                      filterList: [
                        const CommonPupilFiltersWidget(),
                        const AttendanceFilters(),
                      ],
                    ),
                onLongPress: () => _filterStateManager.resetFilters(),
                child: Icon(
                  Icons.filter_list,
                  color: filtersOn ? Colors.deepOrange : Colors.white,
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
                          await AttendancePdfGenerator.generateAttendancePdf(
                            date: thisDate,
                            pupils: pupils,
                          );
                      if (context.mounted) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    AttendancePdfViewPage(pdfFile: pdfFile),
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
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
