import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_content_widgets.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_helper.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/attendance_stats_pupil.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/missed_schoolday_card.dart';

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
      iconColor: const Color.fromARGB(255, 61, 61, 61),
      title: 'Fehlzeiten',
      onTitleTap: () {
        context.push(RoutePaths.pupilMissedSchooldays);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Gap(Style.spacing.xs), AttendanceStatsPupil(pupil)],
          ),
          Gap(Style.spacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fehlstunden:', style: context.typography.body),
              Text(
                ' ${missedHoursForActualReport.missed.toString()}',
                style: context.typography.subtitle.bold.withColor(
                  Style.of(context).colors.foreground,
                ),
              ),
              Gap(Style.spacing.xs),
              Text('davon unent:', style: context.typography.body),
              Text(
                ' ${missedHoursForActualReport.unexcused.toString()}',
                style: context.typography.subtitle.bold.withColor(
                  Style.of(context).colors.foreground,
                ),
              ),
              Gap(Style.spacing.lg),
            ],
          ),
          Gap(Style.spacing.md),
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
