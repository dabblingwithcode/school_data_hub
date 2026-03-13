// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entries_filters_widget.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entries_search_bar_stats.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entry_card.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/features/_school_lists/services/school_list_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/select_users/select_users_page.dart';

class SchoolListPupilEntriesPage extends WatchingWidget {
  final SchoolList schoolList;

  const SchoolListPupilEntriesPage(this.schoolList, {super.key});

  @override
  Widget build(BuildContext context) {
    final schoolListManager = di<SchoolListManager>();
    final pupilsFilter = di<PupilsFilter>();
    final filterStateManager = di<FiltersStateManager>();

    // Stable ValueNotifier — created once, never triggers page rebuild.
    final pupilsInList = createOnce(() => ValueNotifier<List<PupilProxy>>([]));

    void recompute() {
      final entriesProxy = schoolListManager.getPupilEntriesProxyFromSchoolList(
        schoolList.id!,
      );
      final unfilteredEntries = entriesProxy.pupilEntries.values
          .map((e) => e.pupilEntry)
          .toList();
      final filteredEntries = di<SchoolListFilterManager>()
          .addPupilEntryFiltersToFilteredPupils(unfilteredEntries);
      final filteredPupils = pupilsFilter.filteredPupils.value;
      final newList = filteredPupils
          .where(
            (pupil) => filteredEntries.any((e) => e.pupilId == pupil.pupilId),
          )
          .toList();

      // Only notify when the set of pupils actually changes — entry-level
      // data changes (status, comment) are handled by granular card widgets.
      final oldIds = pupilsInList.value.map((p) => p.pupilId).toList();
      final newIds = newList.map((p) => p.pupilId).toList();
      if (oldIds.length != newIds.length ||
          !oldIds.every((id) => newIds.contains(id))) {
        pupilsInList.value = newList;
      }
    }

    // Subscribe to entries proxy (ChangeNotifier) + initial computation.
    callOnce((_) {
      recompute();
      final entriesProxy = schoolListManager.getPupilEntriesProxyFromSchoolList(
        schoolList.id!,
      );
      entriesProxy.addListener(recompute);
      onDispose(() => entriesProxy.removeListener(recompute));
    });

    // React to filtered-pupils changes (text search, grade filters, etc.).
    registerHandler(
      target: pupilsFilter.filteredPupils,
      handler: (_, __, ___) => recompute(),
    );

    // React to school-list entry filter changes (yes/no/null/comment chips).
    registerHandler(
      target: di<PupilFilterManager>().pupilFilterState,
      handler: (_, __, ___) => recompute(),
    );

    return GenericListPage<PupilProxy>(
      iconData: Icons.list,
      title: schoolList.name,
      backgroundColor: AppColors.canvasColor,
      maxWidth: 700,
      sliverAppBarHeight: 135,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: SchoolListPupilEntriesSearchBarStats(
          schoolList: schoolList,
          pupilsInList: pupilsInList,
        ),
        searchType: SearchType.pupil,
        hintText: 'Schüler/in suchen',
        refreshFunction: pupilsFilter.refreshs,
        onChanged: (value) => pupilsFilter.textFilter.setFilterText(value),
        searchTextSource: pupilsFilter.textFilter,
        filtersActive: filterStateManager.filtersActive,
        onResetFilters: filterStateManager.resetFilters,
      ),
      filterSheetChildren: const [
        CommonPupilFiltersWidget(),
        SchoolListPupilEntriesFiltersWidget(),
      ],
      itemsListenable: pupilsInList,
      itemBuilder: (_, PupilProxy pupil) =>
          SchoolListPupilEntryCard(pupil.pupilId, schoolList.id!),
      onRefresh: () async => schoolListManager.fetchSchoolLists(),
      bottomBarActions: [
        // TODO: Implement clearance helper
        if (schoolList.public != true &&
            di<HubSessionManager>().userName == schoolList.createdBy)
          IconButton(
            tooltip: 'Liste teilen',
            onPressed: () async {
              final users = di<UserManager>().users.value;
              final List<User>? selectedUsers = await Navigator.of(context)
                  .push(
                    MaterialPageRoute<List<User>>(
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

              schoolListManager.updateSchoolListProperty(
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
                  MaterialPageRoute<List<int>>(
                    builder: (ctx) => SelectPupilsListPage(
                      selectablePupils: di<PupilProxyManager>()
                          .getPupilsNotListed(
                            pupilsInList.value
                                .map((pupil) => pupil.pupilId)
                                .toList(),
                          ),
                    ),
                  ),
                ) ??
                [];
            if (selectedPupilIds.isEmpty) return;
            schoolListManager.updateSchoolListProperty(
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
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (ctx) => PdfViewerPage(
                  pdfGenerator: () =>
                      SchoolListPdfGenerator.generateSchoolListPdf(
                        schoolList: schoolList,
                        pupils: schoolListManager.getPupilsinSchoolList(
                          schoolList.id!,
                        ),
                      ),
                  title: 'Schulliste PDF',
                  iconData: Icons.list_alt_rounded,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
