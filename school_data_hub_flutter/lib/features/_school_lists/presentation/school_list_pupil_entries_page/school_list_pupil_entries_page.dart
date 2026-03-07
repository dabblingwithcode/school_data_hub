// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entries_filters_widget.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entries_searchbar.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entry_card.dart';
import 'package:school_data_hub_flutter/features/_school_lists/services/school_list_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/select_users/select_users_page.dart';

class SchoolListPupilEntriesPage extends WatchingWidget {
  final SchoolList schoolList;

  const SchoolListPupilEntriesPage(this.schoolList, {super.key});

  @override
  Widget build(BuildContext context) {
    final _schoolListManager = di<SchoolListManager>();
    final _schoolListFilterManager = di<SchoolListFilterManager>();
    final _pupilManager = di<PupilProxyManager>();
    // TODO: is this necessary? Other pages are not a watchingwidget
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
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          // TODO: Implement clearance helper
          if (schoolList.public != true &&
              di<HubSessionManager>().userName == schoolList.createdBy)
            IconButton(
              tooltip: 'Liste teilen',
              onPressed: () async {
                final users = di<UserManager>().users.value;
                final List<User>? selectedUsers = await Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (ctx) => SelectUsersPage(
                          selectableUsers: users
                              .where(
                                (user) =>
                                    user.userInfo?.userName !=
                                    di<HubSessionManager>().userName,
                              )
                              .toList(),
                          authorizedUsers: schoolList.authorizedUsers,
                        ),
                      ),
                    );
                if (selectedUsers == null) return;

                final authorizedUsernames = selectedUsers.isEmpty
                    ? null
                    : selectedUsers
                          .map((user) => user.userInfo!.userName!)
                          .join('*');

                di<SchoolListManager>().updateSchoolListProperty(
                  listId: schoolList.id!,
                  authorizedUsers: (value: authorizedUsernames),
                );
              },
              icon: const Icon(Icons.share, size: 30),
            ),
          IconButton(
            tooltip: 'Kinder hinzufügen',
            icon: const Icon(Icons.add, size: 30),
            onPressed: () async {
              final List<int> selectedPupilIds =
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => SelectPupilsListPage(
                        selectablePupils: di<PupilProxyManager>()
                            .getPupilsNotListed(
                              pupilsInList
                                  .map((pupil) => pupil.pupilId)
                                  .toList(),
                            ),
                      ),
                    ),
                  ) ??
                  [];
              if (selectedPupilIds.isEmpty) return;
              di<SchoolListManager>().updateSchoolListProperty(
                listId: schoolList.id!,
                operation: (
                  pupilIds: selectedPupilIds,
                  operation: MemberOperation.add,
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Liste als PDF',
            icon: const Icon(Icons.print, size: 30),
            onPressed: () async {
              final pupils = di<SchoolListManager>().getPupilsinSchoolList(
                schoolList.id!,
              );
              final pdfFile =
                  await SchoolListPdfGenerator.generateSchoolListPdf(
                    schoolList: schoolList,
                    pupils: pupils,
                  );

              if (context.mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => SchoolListPdfViewPage(pdfFile: pdfFile),
                  ),
                );
              }
            },
          ),
          GenericFilterButton(
            isSearchBar: false,
            showBottomSheetFunction: (context) {
              showGenericFilterBottomSheet(
                context: context,
                filterList: [
                  const CommonPupilFiltersWidget(),
                  const SchoolListPupilEntriesFiltersWidget(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
