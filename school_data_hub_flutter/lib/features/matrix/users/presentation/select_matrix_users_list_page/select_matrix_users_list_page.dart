import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/controller/select_matrix_users_list_controller.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/widgets/select_matrix_user_list_card.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/widgets/select_matrix_users_list_searchbar.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/widgets/select_pupils_filter_bottom_sheet.dart';

class SelectMatrixUsersListPage extends WatchingWidget {
  final SelectMatrixUsersListController controller;
  final List<MatrixUser> filteredPupilsInLIst;
  const SelectMatrixUsersListPage(
    this.controller,
    this.filteredPupilsInLIst, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filtersOn = watchValue((MatrixPolicyFilterManager x) => x.filtersOn);
    final List<MatrixUser> filteredUsers = watchValue(
      (MatrixPolicyFilterManager x) => x.filteredMatrixUsers,
    );
    final selectableUsers = filteredUsers
        .where((user) => controller.users!.contains(user))
        .toList();
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        leading: controller.isSelectMode
            ? IconButton(
                onPressed: () {
                  controller.cancelSelect();
                },
                icon: const Icon(Icons.close),
              )
            : null,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Konten auswählen', style: AppStyles.appBarTextStyle),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<PupilProxyManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: CustomScrollView(
                slivers: [
                  const SliverGap(5),
                  SliverAppBar(
                    pinned: false,
                    floating: true,
                    scrolledUnderElevation: null,
                    automaticallyImplyLeading: false,
                    leading: const SizedBox.shrink(),
                    backgroundColor: Colors.transparent,
                    collapsedHeight: 110,
                    expandedHeight: 110.0,
                    stretch: false,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SelectUserListSearchBar(
                          matrixUsers: selectableUsers,
                          controller: controller,
                        ),
                      ),
                    ),
                  ),
                  selectableUsers.isEmpty
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
                            return SelectMatrixUserCard(
                              controller,
                              selectableUsers[index],
                            );
                          }, childCount: selectableUsers.length),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          if (controller.isSelectMode)
            IconButton(
              tooltip: 'Abbrechen',
              icon: const Icon(Icons.close, size: 30),
              onPressed: controller.cancelSelect,
            ),
          IconButton(
            tooltip: 'alle auswählen',
            icon: Icon(
              Icons.select_all_rounded,
              color: controller.isSelectAllMode
                  ? Colors.deepOrange
                  : Colors.white,
              size: 30,
            ),
            onPressed: controller.toggleSelectAll,
          ),
          IconButton(
            tooltip: 'Okay',
            icon: Icon(
              Icons.check,
              color: controller.isSelectMode ? Colors.green : Colors.white,
              size: 30,
            ),
            onPressed: () =>
                Navigator.pop(context, controller.selectedUsers),
          ),
          if (controller.isSelectMode &&
              controller.selectedUsers.isNotEmpty)
            IconButton(
              tooltip: 'Bulk-Credentials generieren',
              icon: const Icon(Icons.print, color: Colors.orange, size: 30),
              onPressed: () => controller.generateBulkCredentials(context),
            ),
          IconButton(
            tooltip: 'Filter',
            icon: Icon(
              Icons.filter_list,
              color: filtersOn ? Colors.deepOrange : Colors.white,
              size: 30,
            ),
            onPressed: () =>
                showSelectPupilsFilterBottomSheet(context),
            onLongPress: () =>
                di<MatrixPolicyFilterManager>().resetAllMatrixFilters(),
          ),
        ],
      ),
    );
  }
}
