import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_helper_functions.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_screen/widgets/school_list_stats_row.dart';

class SchoolListPupilEntriesSearchBarStats extends WatchingWidget {
  final SchoolList schoolList;
  final ValueListenable<List<PupilProxy>> pupilsInList;

  const SchoolListPupilEntriesSearchBarStats({
    required this.schoolList,
    required this.pupilsInList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final observedSchoolList = watchPropertyValue(
      (SchoolListManager m) => m.getSchoolListById(schoolList.id!),
    );
    final pupils = watch(pupilsInList).value;
    return Container(
      decoration: BoxDecoration(
        color: style.colors.canvas,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 3.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schoolList.description,
                        style: context.typography.body.withColor(
                          style.colors.foreground,
                        ),
                      ),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    children: [
                      SchoolListStatsRow(
                        schoolList: observedSchoolList,
                        pupils: pupils,
                      ),
                      const Gap(10),
                      observedSchoolList.public != true
                          ? Text(
                              observedSchoolList.createdBy,
                              style: context.typography.body.bold.withColor(
                                style.colors.accent,
                              ),
                            )
                          : Icon(
                              Icons.school_rounded,
                              color: style.colors.accent,
                            ),
                      Text(
                        SchoolListHelper.listOwners(observedSchoolList),
                        style: context.typography.title.withColor(
                          style.colors.foreground,
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
