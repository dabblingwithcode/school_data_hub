import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:flutter_it/flutter_it.dart';

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
    final style = Style.of(context);
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Style.spacing.sm,
              right: Style.spacing.sm,
              top: Style.spacing.xs,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Verfügbare Benutzer: ${selectableUsers.length}',
                      style: context.typography.subtitle.bold
                          .withColor(style.colors.foreground),
                    ),
                  ],
                ),
                const Gap(3),
                if (selectedUsers.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        'Ausgewählt: ${selectedUsers.length}',
                        style: context.typography.body.bold
                            .withColor(style.colors.accent),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (selectedUsers.isNotEmpty) ...[
            const Gap(3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Style.spacing.xs),
              child: SizedBox(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedUsers.length,
                  itemBuilder: (context, index) {
                    final user = selectedUsers[index];
                    return Container(
                      margin: EdgeInsets.only(right: Style.spacing.xs),
                      padding: EdgeInsets.symmetric(
                        horizontal: Style.spacing.md,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: style.colors.accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            user.role == Role.admin
                                ? Icons.admin_panel_settings
                                : Icons.person,
                            color: style.colors.background,
                            size: 16,
                          ),
                          const Gap(5),
                          Text(
                            user.userInfo?.userName ?? 'Unknown',
                            style: context.typography.bodySmall.bold
                                .withColor(style.colors.background),
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
    );
  }
}
