import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/batch_import_users/batch_import_users_screen.dart';
import 'package:school_data_hub_flutter/features/user/presentation/create_user/create_user_screen.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_list_card.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_list_searchbar.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _filteredListenable =
      ValueNotifier<List<UserWithDevices>>([]);

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
    showSheet(
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
    _filteredListenable.dispose();
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
        _filteredListenable.value = filteredUsersWithDevices;
        final users = filteredUsersWithDevices.map((e) => e.user).toList();

        return ListScreen<UserWithDevices>(
          iconData: Icons.people,
          title: 'Benutzer',
          maxWidth: 700,
          searchWidgetWithStatsRow: UserListSearchBar(
            users: users,
            searchController: _searchController,
            filtersOn: _filtersOn,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: _resetFilters,
            onSearchChanged: _onSearchChanged,
            onResetFilters: _resetFilters,
            onOpenFilter: _openFilterBottomSheet,
          ),
          itemsListenable: _filteredListenable,
          itemBuilder: (_, userWithDevices) =>
              UserListCard(userWithDevices),
          onRefresh: () async => di<UserManager>().fetchUsers(),
          bottomBarActions: [
            TappableIcon(
              tooltip: 'Aktualisieren',
              icon: const Icon(Icons.refresh, size: 30),
              onPressed: () => di<UserManager>().fetchUsers(),
            ),
            TappableIcon(
              tooltip: 'Import aus Excel',
              icon: const Icon(Icons.upload_file, size: 30),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (ctx) => const BatchImportUsersScreen(),
                  ),
                );
              },
            ),
            TappableIcon(
              tooltip: 'Neuer Benutzer',
              icon: const Icon(Icons.add, size: 30),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (ctx) => const CreateOrEditUserScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
