import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:watch_it/watch_it.dart';

class UserListSearchBar extends WatchingWidget {
  final List<User> users;

  const UserListSearchBar({required this.users, super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate totals for all users
    final int totalUsers = users.length;
    final int totalCredit = users.fold(0, (sum, user) => sum + user.credit);
    final int totalTimeUnits = users.fold(
      0,
      (sum, user) => sum + user.timeUnits,
    );
    final int adminCount =
        users.where((user) => user.role == Role.admin).length;

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
                    const Icon(Icons.people, color: AppColors.backgroundColor),
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
                    const Text(
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
                    const Text(
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
                    const Text(
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
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: 'Benutzer suchen',
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      // TODO: Implement search functionality
                      // This would require implementing a filter system similar to PupilsFilter
                    },
                  ),
                ),
                const Gap(5),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {
                      // TODO: Implement filter bottom sheet
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
