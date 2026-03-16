import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_schooldays_pupil_list_page/missed_schooldays_pupil_list_page.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_stats_pupil.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/missed_schoolday_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';

class PupilAttendanceContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilAttendanceContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceManager = di<AttendanceManager>();
    final missedHoursForActualReport =
        AttendanceHelper.missedHoursforSemesterOrSchoolyear(pupil);
    List<MissedSchoolday> missedSchooldays = watch(
      attendanceManager.getPupilMissedSchooldaysProxy(pupil.pupilId),
    ).missedSchooldays;

    // sort by missedDay
    missedSchooldays.sort(
      (b, a) => a.schoolday!.schoolday.compareTo(b.schoolday!.schoolday),
    );
    return PupilProfileContentCard(
      icon: Icons.calendar_month_rounded,
      title: 'Fehlzeiten',
      onTitleTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (ctx) => const MissedSchooldaysPupilListPage(),
          ),
        );
      },
      child: Column(
        children: [
          const Gap(15),
          Row(children: [const Gap(5), AttendanceStatsPupil(pupil)]),
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
              return MissedSchooldayCard(
                pupil: pupil,
                missedSchoolday: missedSchooldays[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
