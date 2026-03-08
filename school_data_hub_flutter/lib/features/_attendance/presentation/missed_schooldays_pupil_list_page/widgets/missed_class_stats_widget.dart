import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_stats_helper.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_badges.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

/// Wraps [AttendanceRankingListSearchbar] with a [ValueListenable<List<PupilProxy>>]
/// so the search bar rebuilds when the list changes.
class AttendanceRankingStats extends WatchingWidget {
  const AttendanceRankingStats({required this.pupilsListenable, super.key});

  final ValueListenable<List<PupilProxy>> pupilsListenable;

  @override
  Widget build(BuildContext context) {
    final pupils = watch(pupilsListenable).value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_alt_rounded,
                    color: AppColors.backgroundColor,
                  ),
                  const Gap(10),
                  Text(
                    pupils.length.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  excusedBadge(false),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListMissedclassSum(
                      pupils,
                    ).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  excusedBadge(true),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListUnexcusedSum(
                      pupils,
                    ).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  missedTypeBadge(MissedType.late),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListLateSum(pupils).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  contactedBadge(1),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListContactedSum(
                      pupils,
                    ).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  returnedBadge(true),
                  const Gap(5),
                  Text(
                    AttendanceStatsHelper.pupilListPickedUpSum(
                      pupils,
                    ).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
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
