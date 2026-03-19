import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/content_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/sliver_search_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/select_users/widgets/select_users_list_card.dart';
import 'package:school_data_hub_flutter/features/user/presentation/select_users/widgets/select_users_search_bar.dart';

class SelectUsersScreen extends WatchingStatefulWidget {
  final List<User> selectableUsers;
  final String? authorizedUsers;
  final bool? isMultiSelectMode;

  const SelectUsersScreen({
    required this.selectableUsers,
    this.authorizedUsers,
    this.isMultiSelectMode,
    super.key,
  });

  @override
  State<SelectUsersScreen> createState() => _SelectUsersScreenState();
}

class _SelectUsersScreenState extends State<SelectUsersScreen> {
  List<User>? users;
  final _selectableListenable = ValueNotifier<List<User>>([]);

  List<int> selectedUserIds = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  UserManager get _userManager => di<UserManager>();

  @override
  void dispose() {
    _selectableListenable.dispose();
    super.dispose();
  }

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
    final style = Style.of(context);
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
    _selectableListenable.value = selectableUsers;

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
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
                const SliverToBoxAdapter(child: SizedBox(height: 5)),
                SliverSearchBar(
                  height: 110,
                  searchWidgetWithStatsRow: SelectUsersSearchBar(
                    selectableUsers: selectableUsers,
                    selectedUsers: getSelectedUsers(),
                  ),
                ),
                ContentSliverList<User>(
                  itemsListenable: _selectableListenable,
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
      bottomNavigationBar: ActionBar(
        actions: [
          if (widget.isMultiSelectMode == true) ...[
            TappableIcon(
              onPressed: () {
                cancelSelect();
              },
              icon: Icon(
                Icons.close,
                color: style.colors.background,
              ),
            ),
            TappableIcon(
              tooltip: 'alle auswählen',
              icon: Icon(
                Icons.select_all_rounded,
                color: isSelectAllMode
                    ? style.colors.warning
                    : style.colors.background,
                size: 30,
              ),
              onPressed: () => toggleSelectAll(selectableUsers),
            ),
          ],
          TappableIcon(
            tooltip: 'Okay',
            icon: Icon(
              Icons.check,
              color: widget.isMultiSelectMode == true
                  ? isSelectMode
                        ? style.colors.success
                        : style.colors.background
                  : style.colors.background,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context, getSelectedUsers());
            },
          ),
        ],
      ),
    );
  }
}
