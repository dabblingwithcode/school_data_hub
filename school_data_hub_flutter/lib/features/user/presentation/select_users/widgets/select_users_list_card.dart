import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:watch_it/watch_it.dart';

class SelectUsersListCard extends WatchingWidget {
  final bool isSelectMode;
  final bool isSelected;
  final User passedUser;
  final Function(int) onCardPress;

  const SelectUsersListCard({
    required this.isSelectMode,
    required this.isSelected,
    required this.passedUser,
    required this.onCardPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected
          ? AppColors.interactiveColor.withValues(alpha: 0.3)
          : Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: InkWell(
        onTap: () {
          if (passedUser.id != null) {
            onCardPress(passedUser.id!);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Selection indicator
            if (isSelectMode)
              Container(
                width: 60,
                height: 80,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.interactiveColor
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isSelected ? Icons.check : Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
              )
            else
              // User avatar/icon
              Container(
                width: 60,
                height: 80,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  passedUser.role == Role.admin
                      ? Icons.admin_panel_settings
                      : Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          passedUser.userInfo?.userName ?? 'Unknown User',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          passedUser.userInfo?.fullName ?? 'N/A',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Text(
                        'Rolle: ${passedUser.role.name}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Gap(10),
                      if (passedUser.userInfo?.email?.isNotEmpty == true)
                        Expanded(
                          child: Text(
                            passedUser.userInfo!.email!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  const Gap(5),
                ],
              ),
            ),
            // Credit display
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Gap(10),
                  const Text('Credit', style: TextStyle(fontSize: 12)),
                  Text(
                    passedUser.credit.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
