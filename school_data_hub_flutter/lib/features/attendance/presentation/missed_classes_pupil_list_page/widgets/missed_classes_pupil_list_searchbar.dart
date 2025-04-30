import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/list_view_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/missed_classes_pupil_list_page/widgets/missed_classes_filters.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/attendance_badges.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_search_text_field.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingListSearchbar extends WatchingWidget {
  final List<PupilProxy> pupils;

  const AttendanceRankingListSearchbar({required this.pupils, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          const Gap(5),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    excusedBadge(false),
                    const Gap(5),
                    Text(
                      AttendanceHelper.pupilListMissedclassSum(pupils)
                          .toString(),
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
                      AttendanceHelper.pupilListUnexcusedSum(pupils).toString(),
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
                      AttendanceHelper.pupilListPickedUpSum(pupils).toString(),
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
                      AttendanceHelper.pupilListContactedSum(pupils).toString(),
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
                      AttendanceHelper.pupilListPickedUpSum(pupils).toString(),
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                    child: PupilSearchTextField(
                        searchType: SearchType.pupil,
                        hintText: 'Schüler/in suchen',
                        refreshFunction: di<PupilsFilter>().refreshs)),
                const Gap(5),
                FilterButton(
                  isSearchBar: true,
                  showBottomSheetFunction: () => showGenericFilterBottomSheet(
                    context: context,
                    filterList: [
                      const CommonPupilFiltersWidget(),
                      const MissedClassFilters()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
