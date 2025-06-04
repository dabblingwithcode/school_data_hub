import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/atendance_list_card.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_list_search_bar.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_view_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

final _attendanceManager = di<AttendanceManager>();

final _log = Logger('AttendanceListPage');

final _attendancePupilFilterManager = di<AttendancePupilFilterManager>();

class AttendanceListPage extends WatchingWidget {
  const AttendanceListPage({super.key});
  @override
  Widget build(BuildContext context) {
    createOnce<StreamSubscription<MissedClassDto>>(() {
      return _attendanceManager.missedClassStreamSubscription();
    }, dispose: (value) {
      _log.info('Cancelling missed class stream subscription');
      value.cancel();
    });
    DateTime thisDate = watchValue((SchoolCalendarManager x) => x.thisDate);

    callOnce((context) {
      _attendanceManager.fetchMissedClassesOnASchoolday(thisDate);
    });

    watchValue((AttendanceManager x) => x.missedClasses);
    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);
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
                '${thisDate.asWeekdayName(context)}, ${thisDate.formatForUser()}',
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            _attendanceManager.fetchMissedClassesOnASchoolday(thisDate),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                const GenericSliverSearchAppBar(
                    height: 110, title: AttendanceListSearchBar()),
                GenericSliverListWithEmptyListCheck(
                  items: pupils,
                  itemBuilder: (_, pupil) => AttendanceCard(pupil, thisDate),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AttendanceListPageBottomNavBar(),
    );
  }
}
