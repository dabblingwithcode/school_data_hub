// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupils_page/widgets/school_list_pupil_card.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupils_page/widgets/school_list_pupils_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupils_page/widgets/school_list_pupils_searchbar.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();

final _pupilManager = di<PupilManager>();

class SchoolListPupilsPage extends WatchingWidget {
  final SchoolList schoolList;

  const SchoolListPupilsPage(this.schoolList, {super.key});

  @override
  Widget build(BuildContext context) {
    final pupilListEntries = watch(_schoolListManager
            .getPupilEntriesProxyFromSchoolList(schoolList.id!))
        .pupilEntries
        .values;

    final List<PupilProxy> filteredPupils =
        watchValue((PupilsFilter x) => x.filteredPupils);

    List<PupilProxy> pupilsInList = filteredPupils
        .where((pupil) => pupilListEntries
            .any((pupilList) => pupilList.pupilEntry.pupilId == pupil.pupilId))
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
              constraints: const BoxConstraints(maxWidth: 800),
              child: CustomScrollView(
                slivers: [
                  const SliverGap(10),
                  GenericSliverSearchAppBar(
                    height: 135,
                    title: SchoolListPupilsPageSearchBar(
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
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return SchoolListPupilCard(
                                  pupilsInList[index].pupilId, schoolList.id!);
                            },
                            childCount: pupilsInList.length,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SchoolListPupilsPageBottomNavBar(
          listId: schoolList.id!,
          pupilsInList: _pupilManager.pupilIdsFromPupils(pupilsInList)),
    );
  }
}
