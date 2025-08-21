import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_classes_pupil_list_page/missed_classes_pupil_list_page.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_stats_pupil.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/missed_class_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

final _attendanceManager = di<AttendanceManager>();

class PupilAttendanceContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilAttendanceContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final missedHoursForActualReport =
        AttendanceHelper.missedHoursforSemesterOrSchoolyear(pupil);
    List<MissedSchoolday> missedSchooldays =
        watch(_attendanceManager.getPupilMissedSchooldayesProxy(pupil.pupilId))
            .missedSchooldays;

    // sort by missedDay
    missedSchooldays.sort(
        (b, a) => a.schoolday!.schoolday.compareTo(b.schoolday!.schoolday));
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
      child: Card(
        color: AppColors.pupilProfileCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: AppPaddings.pupilProfileCardPadding,
          child: Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(
                Icons.calendar_month_rounded,
                color: Colors.grey[700],
                size: 24,
              ),
              const Gap(5),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const MissedSchooldayesPupilListPage(),
                  ));
                },
                child: const Text('Fehlzeiten',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor,
                    )),
              )
            ]),
            const Gap(15),
            attendanceStats(pupil),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Fehlstunden:',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  ' ${missedHoursForActualReport.missed.toString()}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Gap(5),
                const Text(
                  'davon unent:',
                  style: TextStyle(fontSize: 14),
                ),
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
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: missedSchooldays.length,
              itemBuilder: (BuildContext context, int index) {
                // pupil.pupilMissedSchooldayes.sort(
                //     (a, b) => a.missedDay.compareTo(b.missedDay));

                return MissedSchooldayCard(
                    pupil: pupil, missedSchoolday: missedSchooldays[index]);
              },
            ),
          ]),
        ),
      ),
    );
  }
}

// List<Widget> pupilAttendanceContentList(PupilProxy pupil, context) {
//   List<MissedSchoolday> missedSchooldays = List.from(pupil.missedSchooldays!);
//   // sort by missedDay
//   missedSchooldays
//       .sort((b, a) => a.schoolday!.schoolday.compareTo(b.schoolday!.schoolday));
//   return [
//     ListView.builder(
//       padding: const EdgeInsets.only(top: 5, bottom: 15),
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: missedSchooldays.length,
//       itemBuilder: (BuildContext context, int index) {
//         // pupil.pupilMissedSchooldayes.sort(
//         //     (a, b) => a.missedDay.compareTo(b.missedDay));

//         return MissedSchooldayCard(pupil: pupil, missedSchoolday: missedSchooldays[index]);
//       },
//     ),
//   ];
// }
