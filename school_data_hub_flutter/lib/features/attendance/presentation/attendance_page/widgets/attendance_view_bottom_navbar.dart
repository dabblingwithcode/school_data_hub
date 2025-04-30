import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_page/widgets/attendance_filters.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/missed_classes_badges_info_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schooldayManager = di<SchooldayManager>();

final _filterStateManager = di<FiltersStateManager>();

class AttendanceListPageBottomNavBar extends WatchingWidget {
  const AttendanceListPageBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime thisDate = watchValue((SchooldayManager x) => x.thisDate);
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
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
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(30),
              IconButton(
                tooltip: 'Info',
                icon: const Icon(Icons.info, size: 30),
                onPressed: () async {
                  missedClassesBadgesInformationDialog(
                      context: context, isAttendancePage: true);
                },
              ),
              const Gap(30),
              InkWell(
                onTap: () async {
                  final DateTime? newDate =
                      await selectSchooldayDate(context, thisDate);
                  if (newDate != null) {
                    _schooldayManager.setThisDate(newDate);
                  }
                },
                onLongPress: () => _schooldayManager.getThisDate(),
                child: const Icon(
                  Icons.today_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const Gap(30),
              InkWell(
                onTap: () =>
                    showGenericFilterBottomSheet(context: context, filterList: [
                  const CommonPupilFiltersWidget(),
                  const AttendanceFilters(),
                ]),
                onLongPress: () => _filterStateManager.resetFilters(),
                child: Icon(
                  Icons.filter_list,
                  color: filtersOn ? Colors.deepOrange : Colors.white,
                  size: 30,
                ),
              ),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}
