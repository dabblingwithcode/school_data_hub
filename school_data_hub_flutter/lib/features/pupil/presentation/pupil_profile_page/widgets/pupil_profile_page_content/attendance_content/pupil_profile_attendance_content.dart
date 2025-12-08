import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_classes_pupil_list_page/missed_classes_pupil_list_page.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_stats_pupil.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/missed_class_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfileAttendanceContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileAttendanceContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final _attendanceManager = di<AttendanceManager>();
    final missedHoursForActualReport =
        AttendanceHelper.missedHoursforSemesterOrSchoolyear(pupil);

    List<MissedSchoolday> missedSchooldays = _attendanceManager
        .getPupilMissedSchooldaysProxy(pupil.pupilId)
        .missedSchooldays;
    // sort by missedDay
    missedSchooldays.sort(
      (b, a) => a.schoolday!.schoolday.compareTo(b.schoolday!.schoolday),
    );
    return Container(
      decoration: BoxDecoration(color: AppColors.pupilProfileBackgroundColor),
      child: Column(
        children: [
          PupilProfileContentSection(
            icon: Icons.calendar_month_rounded,
            title: 'Fehlzeiten',
            onTitleTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const MissedSchooldayesPupilListPage(),
                ),
              );
            },
            child: Column(
              children: [
                attendanceStats(pupil),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Fehlstunden:', style: TextStyle(fontSize: 14)),
                    Text(
                      ' ${missedHoursForActualReport.missed.toString()}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(5),
                    const Text('davon unent:', style: TextStyle(fontSize: 14)),
                    Text(
                      ' ${missedHoursForActualReport.unexcused.toString()}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(15),
                  ],
                ),
                const Gap(10),
                ListView.builder(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: missedSchooldays.length,
                  itemBuilder: (BuildContext context, int index) {
                    // pupil.pupilMissedSchooldayes.sort(
                    //     (a, b) => a.missedDay.compareTo(b.missedDay));

                    return MissedSchooldayCard(
                      pupil: pupil,
                      missedSchoolday: missedSchooldays[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
