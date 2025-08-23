import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_search_text_field.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_helper_functions.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entries_filters_widget.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_stats_row.dart';
import 'package:watch_it/watch_it.dart';

final _pupilsFilter = di<PupilsFilter>();

class SchoolListPupilEntriesPageSearchBar extends WatchingWidget {
  final SchoolList schoolList;
  final List<PupilProxy> pupilsInList;

  const SchoolListPupilEntriesPageSearchBar({
    required this.pupilsInList,
    required this.schoolList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
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
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    children: [
                      SchoolListStatsRow(
                        schoolList: schoolList,
                        pupils: pupilsInList,
                      ),
                      const Gap(10),
                      schoolList.public != true
                          ? Text(
                            schoolList.createdBy,
                            style: const TextStyle(
                              color: AppColors.backgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : const Icon(
                            Icons.school_rounded,
                            color: AppColors.backgroundColor,
                          ),
                      Text(
                        SchoolListHelper.listOwners(schoolList),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 3.0,
              left: 10.0,
              right: 10.0,
              bottom: 3.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: PupilSearchTextField(
                    searchType: SearchType.pupil,
                    hintText: 'Schüler/in suchen',
                    refreshFunction: _pupilsFilter.refreshs,
                  ),
                ),
                const Gap(5),
                FilterButton(
                  isSearchBar: true,
                  showBottomSheetFunction:
                      () => showGenericFilterBottomSheet(
                        context: context,
                        filterList: [
                          const CommonPupilFiltersWidget(),
                          const SchoolListPupilEntriesFiltersWidget(),
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
