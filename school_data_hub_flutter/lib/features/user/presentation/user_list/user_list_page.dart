import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_generic_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_list_card.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_list_page_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_list_searchbar.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final TextEditingController _searchController = TextEditingController();

  String _searchText = '';
  Role? _selectedRole;

  bool get _filtersOn => _searchText.isNotEmpty || _selectedRole != null;

  void _syncGlobalFilterState() {
    di<FiltersStateManager>().setFilterState(
      filterState: FilterState.user,
      value: _filtersOn,
    );
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchText = value.trim().toLowerCase();
    });
    _syncGlobalFilterState();
  }

  void _setRole(Role? role) {
    setState(() {
      _selectedRole = role;
    });
    _syncGlobalFilterState();
  }

  void _resetFilters() {
    _searchController.clear();
    setState(() {
      _searchText = '';
      _selectedRole = null;
    });
    _syncGlobalFilterState();
  }

  List<UserWithDevices> _applyFilters(List<UserWithDevices> source) {
    return source.where((item) {
      final user = item.user;

      if (_selectedRole != null && user.role != _selectedRole) {
        return false;
      }

      if (_searchText.isEmpty) {
        return true;
      }

      final userName = user.userInfo?.userName?.toLowerCase() ?? '';
      final fullName = user.userInfo?.fullName?.toLowerCase() ?? '';
      final email = user.userInfo?.email?.toLowerCase() ?? '';
      final matrixUserId = user.matrixUserId?.toLowerCase() ?? '';
      final roleName = user.role.name.toLowerCase();

      return userName.contains(_searchText) ||
          fullName.contains(_searchText) ||
          email.contains(_searchText) ||
          matrixUserId.contains(_searchText) ||
          roleName.contains(_searchText);
    }).toList();
  }

  void _openFilterBottomSheet() {
    showGenericBottomSheet(
      context,
      UserFilterBottomSheet(
        selectedRole: _selectedRole,
        onRoleChanged: _setRole,
        onReset: _resetFilters,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    di<FiltersStateManager>().setFilterState(
      filterState: FilterState.user,
      value: false,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UserWithDevices>>(
      valueListenable: di<UserManager>().usersWithDevices,
      builder: (context, usersWithDevices, _) {
        final filteredUsersWithDevices = _applyFilters(usersWithDevices);
        final users = filteredUsersWithDevices.map((e) => e.user).toList();

        return Scaffold(
          backgroundColor: AppColors.canvasColor,
          appBar: const GenericAppBar(
            iconData: Icons.people,
            title: 'Benutzer',
          ),
          body: RefreshIndicator(
            onRefresh: () async => di<UserManager>().fetchUsers(),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: CustomScrollView(
                  slivers: [
                    const SliverGap(5),
                    GenericSliverSearchAppBar(
                      height: 110,
                      title: UserListSearchBar(
                        users: users,
                        searchController: _searchController,
                        filtersOn: _filtersOn,
                        onSearchChanged: _onSearchChanged,
                        onResetFilters: _resetFilters,
                        onOpenFilter: _openFilterBottomSheet,
                      ),
                    ),
                    GenericSliverListWithEmptyListCheck(
                      items: filteredUsersWithDevices,
                      itemBuilder: (_, userWithDevices) =>
                          UserListCard(userWithDevices),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: const UserListPageBottomNavBar(),
        );
      },
    );
  }
}
