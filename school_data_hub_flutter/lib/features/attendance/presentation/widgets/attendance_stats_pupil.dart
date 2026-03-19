import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_stats_helper.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/attendance_badges.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class AttendanceStatsPupil extends WatchingWidget {
  final PupilProxy pupil;
  const AttendanceStatsPupil(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    watch(di<AttendanceManager>().getPupilMissedSchooldaysProxy(pupil.pupilId));

    return Row(
      children: [
        excusedBadge(false),
        const Gap(3),
        Text(
          AttendanceStatsHelper.pupilListMissedclassSum([pupil]).toString(),
          style: context.typography.subtitle.bold,
        ),
        const Gap(5),
        excusedBadge(true),
        const Gap(3),
        Text(
          AttendanceStatsHelper.pupilListUnexcusedSum([pupil]).toString(),
          style: context.typography.subtitle.bold,
        ),
        const Gap(5),
        missedTypeBadge(MissedType.late),
        const Gap(3),
        Text(
          AttendanceStatsHelper.pupilListLateSum([pupil]).toString(),
          style: context.typography.subtitle.bold,
        ),
        const Gap(5),
        contactedBadge(1),
        const Gap(3),
        Text(
          AttendanceStatsHelper.pupilListContactedSum([pupil]).toString(),
          style: context.typography.subtitle.bold,
        ),
        const Gap(5),
        returnedBadge(true),
        const Gap(3),
        Text(
          AttendanceStatsHelper.pupilListPickedUpSum([pupil]).toString(),
          style: context.typography.subtitle.bold,
        ),
      ],
    );
  }
}
