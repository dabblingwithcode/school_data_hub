import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/bottom_nav_bar_no_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/select_users/widgets/select_users_list_card.dart';
import 'package:school_data_hub_flutter/features/user/presentation/select_users/widgets/select_users_search_bar.dart';
import 'package:watch_it/watch_it.dart';

class SelectUsersPage extends WatchingStatefulWidget {
  final List<User> selectableUsers;
  final String? authorizedUsers;
  final bool? isMultiSelectMode;

  const SelectUsersPage({
    required this.selectableUsers,
    this.authorizedUsers,
    this.isMultiSelectMode,
    super.key,
  });

  @override
  State<SelectUsersPage> createState() => _SelectUsersPageState();
}

class _SelectUsersPageState extends State<SelectUsersPage> {
  List<User>? users;

  List<int> selectedUserIds = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  UserManager get _userManager => di<UserManager>();

  @override
  void initState() {
    if (widget.authorizedUsers != null && widget.authorizedUsers!.isNotEmpty) {
      final authorizedUserNames = widget.authorizedUsers!;
      final authorizedUsers = widget.selectableUsers
          .where(
            (user) =>
                user.userInfo?.userName != null &&
                authorizedUserNames.contains(user.userInfo!.userName!),
          )
          .map((user) => user.id!)
          .toList();
      if (authorizedUsers.isNotEmpty) {
        setState(() {
          isSelectMode = true;
          selectedUserIds = authorizedUsers;
        });
      }
    }
    super.initState();
  }

  void cancelSelect() {
    setState(() {
      selectedUserIds.clear();
      isSelectMode = false;
    });
  }

  void onCardPress(int userId) {
    if (widget.isMultiSelectMode == false) {
      if (selectedUserIds.contains(userId)) {
        return;
      } else {
        setState(() {
          selectedUserIds = [userId];
        });
        return;
      }
    }
    if (selectedUserIds.contains(userId)) {
      setState(() {
        selectedUserIds.remove(userId);
        if (selectedUserIds.isEmpty) {
          isSelectMode = false;
        }
      });
    } else {
      setState(() {
        selectedUserIds.add(userId);
        isSelectMode = true;
      });
    }
  }

  void clearAll() {
    setState(() {
      isSelectMode = false;
      selectedUserIds.clear();
    });
  }

  void toggleSelectAll(List<User> selectableUsers) {
    setState(() {
      isSelectAllMode = !isSelectAllMode;
      if (isSelectAllMode) {
        isSelectMode = true;
        selectedUserIds = selectableUsers
            .where((user) => user.id != null)
            .map((user) => user.id!)
            .toList();
      } else {
        isSelectMode = false;
        selectedUserIds.clear();
      }
    });
  }

  List<User> getSelectedUsers() {
    return widget.selectableUsers
        .where((user) => user.id != null && selectedUserIds.contains(user.id!))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
    final List<User> allUsers = watchValue((UserManager x) => x.users);

    // Filter to only include selectable users
    final List<User> selectableUsers = widget.selectableUsers.isNotEmpty
        ? allUsers
              .where(
                (user) => widget.selectableUsers.any(
                  (selectableUser) =>
                      selectableUser.id != null && selectableUser.id == user.id,
                ),
              )
              .toList()
        : allUsers;

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        title: 'Benutzer auswählen',
        iconData: Icons.group_add_rounded,
      ),
      body: RefreshIndicator(
        onRefresh: () async => _userManager.fetchUsers(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverSearchAppBar(
                  height: 110,
                  title: SelectUsersSearchBar(
                    selectableUsers: selectableUsers,
                    selectedUsers: getSelectedUsers(),
                  ),
                ),
                GenericSliverListWithEmptyListCheck(
                  items: selectableUsers,
                  itemBuilder: (_, user) => SelectUsersListCard(
                    isSelectMode: isSelectMode,
                    isSelected:
                        user.id != null && selectedUserIds.contains(user.id!),
                    passedUser: user,
                    onCardPress: onCardPress,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBarWithActions(
        actions: [
          if (widget.isMultiSelectMode == true) ...[
            IconButton(
              onPressed: () {
                cancelSelect();
              },
              icon: const Icon(Icons.close),
            ),
            IconButton(
              tooltip: 'alle auswählen',
              icon: Icon(
                Icons.select_all_rounded,
                color: isSelectAllMode ? Colors.deepOrange : Colors.white,
                size: 30,
              ),
              onPressed: () => toggleSelectAll(selectableUsers),
            ),
          ],
          IconButton(
            tooltip: 'Okay',
            icon: Icon(
              Icons.check,
              color: widget.isMultiSelectMode == true
                  ? isSelectMode
                        ? Colors.green
                        : Colors.white
                  : Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context, getSelectedUsers());
            },
          ),
        ],
      ),
      // bottomNavigationBar: SelectUsersPageBottomNavBar(
      //   isSelectAllMode: isSelectAllMode,
      //   isSelectMode: isSelectMode,
      //   filtersOn: filtersOn,

      //   cancelSelect: cancelSelect,
      //   toggleSelectAll: () => toggleSelectAll(selectableUsers),
      //   sendSelectedUsers: () {
      //     Navigator.pop(context, getSelectedUsers());
      //   },
      // ),
    );
  }
}
