import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/school_list_pupil_entries_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_helper_functions.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();

class SchoolListStatsRow extends WatchingWidget {
  final SchoolList schoolList;
  final List<PupilProxy> pupils;
  const SchoolListStatsRow({
    super.key,
    required this.schoolList,
    required this.pupils,
  });

  @override
  Widget build(BuildContext context) {
    watch<SchoolListPupilEntriesProxyMap>(
        _schoolListManager.getPupilEntriesProxyFromSchoolList(schoolList.id!));
    final Map<String, int> stats =
        SchoolListHelper.schoolListStatsForGivenPupils(
      schoolList,
      pupils,
    );

    return Row(
      children: [
        const Icon(
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
        const Icon(
          Icons.close,
          color: Colors.red,
        ),
        const Gap(5),
        Text(
          stats['no'].toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Icon(
          Icons.done,
          color: Colors.green,
        ),
        const Gap(5),
        Text(
          stats['yes'].toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Icon(
          Icons.question_mark_rounded,
          color: AppColors.accentColor,
        ),
        const Gap(5),
        Text(
          stats['null'].toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(10),
        const Icon(
          Icons.create,
          color: AppColors.backgroundColor,
        ),
        const Gap(5),
        Text(
          stats['comment'].toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
