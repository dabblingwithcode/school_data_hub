import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/atendance_list_card.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_list_search_bar.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_view_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_controller.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('AttendanceListPage');

class AttendanceListPage extends WatchingWidget {
  const AttendanceListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final _attendanceManager = di<AttendanceManager>();
    final _notificationService = di<NotificationService>();
    final bool isAuthenticated = watchPropertyValue(
      (HubSessionManager x) => x.isSignedIn,
    );

    // If not authenticated, redirect to login page
    if (!isAuthenticated) {
      _notificationService.showInformationDialog(
        'Die Sitzung ist abgelaufen.\nBitte erneut anmelden.',
      );
      // Use Future.microtask to avoid build-phase navigation issues
      Future.microtask(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login()),
        );
      });
      // Return an empty container or loading indicator while navigating
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    createOnce<StreamSubscription<MissedSchooldayDto>>(
      () {
        return _attendanceManager.missedSchooldayStreamSubscription();
      },
      dispose: (value) {
        _log.info('Cancelling missed class stream subscription');
        value.cancel();
      },
    );
    DateTime thisDate = watchValue(
      (SchoolCalendarManager x) => x.thisDate,
    ).toLocal();

    callOnce((context) {
      _attendanceManager.fetchMissedSchooldayesOnASchoolday(thisDate);
    });

    watchValue((AttendanceManager x) => x.missedSchooldays);
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
                '${thisDate.asWeekdayName(context)}, ${thisDate.formatDateForUser()}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            _attendanceManager.fetchMissedSchooldayesOnASchoolday(thisDate),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                const GenericSliverSearchAppBar(
                  height: 110,
                  title: AttendanceListSearchBar(),
                ),
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
