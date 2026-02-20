import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_filter_button.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_search_text_field.dart';

class UserListSearchBar extends StatelessWidget {
  final List<User> users;
  final TextEditingController searchController;
  final bool filtersOn;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onResetFilters;
  final VoidCallback onOpenFilter;

  const UserListSearchBar({
    required this.users,
    required this.searchController,
    required this.filtersOn,
    required this.onSearchChanged,
    required this.onResetFilters,
    required this.onOpenFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate totals for all users
    final int totalUsers = users.length;
    final int totalCredit = users.fold(0, (sum, user) => sum + user.credit);
    final int totalTimeUnits = users.fold(
      0,
      (sum, user) => sum + user.timeUnits,
    );
    final int adminCount = users
        .where((user) => user.role == Role.admin)
        .length;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          const Gap(5),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people, color: AppColors.backgroundColor),
                    const Gap(10),
                    Text(
                      totalUsers.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      'Admins:',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      adminCount.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      'Gesamt Credit:',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      totalCredit.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      'Zeiteinheiten:',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      totalTimeUnits.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: UserSearchTextField(
                    hintText: 'Benutzer suchen',
                    filtersOn: filtersOn,
                    controller: searchController,
                    onChanged: onSearchChanged,
                    onReset: onResetFilters,
                  ),
                ),
                const Gap(5),
                GenericFilterButton(
                  isSearchBar: true,
                  showBottomSheetFunction: onOpenFilter,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
