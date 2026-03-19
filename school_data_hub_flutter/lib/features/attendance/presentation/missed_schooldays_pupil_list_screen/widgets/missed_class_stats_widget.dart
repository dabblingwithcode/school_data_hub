import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_stats_helper.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/attendance_badges.dart';

/// Displays aggregated attendance stats for a filtered pupil list.
/// Watches [AttendanceManager.missedSchooldays] so the stats rebuild
/// when any missed-schoolday entry changes.
class AttendanceRankingStats extends WatchingWidget {
  const AttendanceRankingStats({required this.pupilsListenable, super.key});

  final ValueListenable<List<PupilProxy>> pupilsListenable;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupils = watch(pupilsListenable).value;
    watchValue((AttendanceManager m) => m.missedSchooldays);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.spacing.md),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_alt_rounded, color: style.colors.accent),
                  const Gap(10),
                  Text(
                    pupils.length.toString(),
                    style: context.typography.subtitle.bold,
                  ),
                  const Gap(10),
                  excusedBadge(false),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListMissedclassSum(
                      pupils,
                    ).toString(),
                    style: context.typography.subtitle.bold,
                  ),
                  const Gap(10),
                  excusedBadge(true),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListUnexcusedSum(
                      pupils,
                    ).toString(),
                    style: context.typography.subtitle.bold,
                  ),
                  const Gap(10),
                  missedTypeBadge(MissedType.late),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListLateSum(pupils).toString(),
                    style: context.typography.subtitle.bold,
                  ),
                  const Gap(10),
                  contactedBadge(1),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListContactedSum(
                      pupils,
                    ).toString(),
                    style: context.typography.subtitle.bold,
                  ),
                  const Gap(10),
                  returnedBadge(true),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListPickedUpSum(
                      pupils,
                    ).toString(),
                    style: context.typography.subtitle.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
