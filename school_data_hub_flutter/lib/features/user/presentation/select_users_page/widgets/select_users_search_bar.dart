import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:watch_it/watch_it.dart';

class SelectUsersSearchBar extends WatchingWidget {
  final List<User> selectableUsers;
  final List<User> selectedUsers;

  const SelectUsersSearchBar({
    required this.selectableUsers,
    required this.selectedUsers,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Verfügbare Benutzer: ${selectableUsers.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Gap(3),
                  if (selectedUsers.isNotEmpty)
                    Row(
                      children: [
                        Text(
                          'Ausgewählt: ${selectedUsers.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.backgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (selectedUsers.isNotEmpty) ...[
              const Gap(3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SizedBox(
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedUsers.length,
                    itemBuilder: (context, index) {
                      final user = selectedUsers[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 4.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              user.role == Role.admin
                                  ? Icons.admin_panel_settings
                                  : Icons.person,
                              color: Colors.white,
                              size: 16,
                            ),
                            const Gap(5),
                            Text(
                              user.userInfo?.userName ?? 'Unknown',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            const Gap(3),
          ],
        ),
      ),
    );
  }
}
