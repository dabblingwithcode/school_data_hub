// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entries_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entries_searchbar.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entry_card.dart';
import 'package:watch_it/watch_it.dart';

class SchoolListPupilEntriesPage extends WatchingWidget {
  final SchoolList schoolList;

  const SchoolListPupilEntriesPage(this.schoolList, {super.key});

  @override
  Widget build(BuildContext context) {
    final _schoolListManager = di<SchoolListManager>();
    final _schoolListFilterManager = di<SchoolListFilterManager>();
    final _pupilManager = di<PupilProxyManager>();
    final unfilteredPupilListEntries = watch(
      _schoolListManager.getPupilEntriesProxyFromSchoolList(schoolList.id!),
    ).pupilEntries.values.map((e) => e.pupilEntry).toList();

    final pupilListEntries = _schoolListFilterManager
        .addPupilEntryFiltersToFilteredPupils(unfilteredPupilListEntries);
    final List<PupilProxy> filteredPupils = watchValue(
      (PupilsFilter x) => x.filteredPupils,
    );

    List<PupilProxy> pupilsInList = filteredPupils
        .where(
          (pupil) => pupilListEntries.any(
            (pupilList) => pupilList.pupilId == pupil.pupilId,
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: GenericAppBar(iconData: Icons.list, title: schoolList.name),
      body: RefreshIndicator(
        onRefresh: () async => _schoolListManager.fetchSchoolLists(),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: CustomScrollView(
                slivers: [
                  GenericSliverSearchAppBar(
                    height: 135,
                    title: SchoolListPupilEntriesPageSearchBar(
                      pupilsInList: pupilsInList,
                      schoolList: schoolList,
                    ),
                  ),
                  pupilsInList.isEmpty
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Keine Ergebnisse',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate((
                            BuildContext context,
                            int index,
                          ) {
                            return SchoolListPupilEntryCard(
                              pupilsInList[index].pupilId,
                              schoolList.id!,
                            );
                          }, childCount: pupilsInList.length),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SchoolListPupilEntriesBottomNavBar(
        listId: schoolList.id!,
        pupilsInList: _pupilManager.getPupilIdsFromPupils(pupilsInList),
      ),
    );
  }
}
