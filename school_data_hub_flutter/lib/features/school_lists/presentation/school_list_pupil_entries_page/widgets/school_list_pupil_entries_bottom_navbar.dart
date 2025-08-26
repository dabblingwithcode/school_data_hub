import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_page/widgets/school_list_pupil_entries_filters_widget.dart';
import 'package:school_data_hub_flutter/features/school_lists/services/school_list_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/select_users/select_users_page.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();
final _hubSessionManager = di<HubSessionManager>();
final _pupilManager = di<PupilManager>();

class SchoolListPupilEntriesBottomNavBar extends StatelessWidget {
  final int listId;

  final List<int> pupilsInList;
  const SchoolListPupilEntriesBottomNavBar({
    required this.listId,
    required this.pupilsInList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final schoolList = _schoolListManager.getSchoolListById(listId);
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(9),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              if (schoolList.public != true ||
                  _hubSessionManager.userName == schoolList.createdBy)
                Row(
                  children: [
                    const Gap(30),
                    IconButton(
                      tooltip: 'Liste teilen',
                      onPressed: () async {
                        final users = di<UserManager>().users.value;
                        final List<int>? selectedUsers = await Navigator.of(
                          context,
                        ).push(
                          MaterialPageRoute(
                            builder:
                                (ctx) => SelectUsersPage(
                                  selectableUsers:
                                      users
                                          .where(
                                            (user) =>
                                                user.userInfo?.userName !=
                                                _hubSessionManager.userName,
                                          )
                                          .toList(),
                                  authorizedUsers: schoolList.authorizedUsers,
                                ),
                          ),
                        );
                        if (selectedUsers == null) return;

                        final userManager = di<UserManager>();
                        final authorizedUsernames =
                            selectedUsers.isEmpty
                                ? null
                                : selectedUsers
                                    .map(
                                      (userId) =>
                                          userManager.users.value
                                              .firstWhere(
                                                (user) => user.id == userId,
                                              )
                                              .userInfo
                                              ?.userName ??
                                          'Unknown',
                                    )
                                    .join('*');

                        _schoolListManager.updateSchoolListProperty(
                          listId: listId,
                          authorizedUsers: (value: authorizedUsernames),
                        );
                      },
                      icon: const Icon(Icons.share, size: 30),
                    ),
                  ],
                ),
              const Gap(AppPaddings.bottomNavBarButtonGap),
              IconButton(
                tooltip: 'Kinder hinzufügen',
                icon: const Icon(Icons.add, size: 30),
                onPressed: () async {
                  final List<int> selectedPupilIds =
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (ctx) => SelectPupilsListPage(
                                selectablePupils: _pupilManager
                                    .getPupilsNotListed(pupilsInList),
                              ),
                        ),
                      ) ??
                      [];
                  if (selectedPupilIds.isEmpty) return;
                  _schoolListManager.updateSchoolListProperty(
                    listId: listId,
                    operation: (
                      pupilIds: selectedPupilIds,
                      operation: MemberOperation.add,
                    ),
                  );
                },
              ),
              const Gap(AppPaddings.bottomNavBarButtonGap),
              IconButton(
                tooltip: 'Liste als PDF',
                icon: const Icon(Icons.print, size: 30),
                onPressed: () async {
                  final pupils = _schoolListManager.getPupilsinSchoolList(
                    listId,
                  );
                  final pdfFile =
                      await SchoolListPdfGenerator.generateSchoolListPdf(
                        schoolList: schoolList,
                        pupils: pupils,
                      );

                  if (context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (ctx) => SchoolListPdfViewPage(pdfFile: pdfFile),
                      ),
                    );
                  }
                },
              ),
              const Gap(AppPaddings.bottomNavBarButtonGap),
              FilterButton(
                isSearchBar: false,
                showBottomSheetFunction: () {
                  return showGenericFilterBottomSheet(
                    context: context,
                    filterList: [
                      const CommonPupilFiltersWidget(),
                      const SchoolListPupilEntriesFiltersWidget(),
                    ],
                  );
                },
              ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
