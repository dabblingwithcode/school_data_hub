import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_page/widgets/atendance_list_card.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_page/widgets/attendance_list_search_bar.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_page/widgets/attendance_view_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final _attendanceManager = di<AttendanceManager>();

final _client = di<Client>();

final _log = Logger('AttendanceListPage');

final _attendancePupilFilterManager = di<AttendancePupilFilterManager>();

class AttendanceListPage extends WatchingWidget {
  const AttendanceListPage({super.key});
  @override
  Widget build(BuildContext context) {
    createOnce<StreamSubscription<MissedClassDto>>(() {
      return _client.missedClass.streamMyModels().listen((event) {
        switch (event.operation) {
          case 'add':
            _log.info('add missedClass ${event.missedClass}');
            _attendanceManager
                .updateMissedClassInCollections(event.missedClass);
            break;
          case 'update':
            _log.info('update missedClass ${event.missedClass}');
            _attendanceManager
                .updateMissedClassInCollections(event.missedClass);
            break;
          case 'delete':
            _log.info('delete missedClass ${event.missedClass}');
            _attendanceManager.removeMissedClassFromCollections(
                event.missedClass.pupilId,
                event.missedClass.schoolday!.schoolday);
            break;
        }
      }, onError: (error) {
        throw Exception('Error in missedClass stream: $error');
      }, onDone: () {
        // Handle stream completion if needed
      });
    }, dispose: (value) {
      value.cancel();
    });
    DateTime thisDate = watchValue((SchooldayManager x) => x.thisDate);
    _attendanceManager.fetchMissedClassesOnASchoolday(
      thisDate,
    );
    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils)
        .where((x) =>
            _attendancePupilFilterManager.isMatchedByAttendanceFilters(x))
        .toList();
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
                GenericSliverSearchAppBar(
                    height: 110,
                    title: AttendanceListSearchBar(
                      pupils: pupils,
                    )),
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
