import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';

class SelectUsersListCard extends WatchingWidget {
  final bool isSelectMode;
  final bool isSelected;
  final User passedUser;
  final void Function(int) onCardPress;

  const SelectUsersListCard({
    required this.isSelectMode,
    required this.isSelected,
    required this.passedUser,
    required this.onCardPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Style.spacing.xs,
        vertical: Style.spacing.xs,
      ),
      child: CardBox(
        padding: EdgeInsets.zero,
        onTap: () {
          if (passedUser.id != null) {
            onCardPress(passedUser.id!);
          }
        },
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  color: style.colors.interactive.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(Style.radii.medium),
                )
              : null,
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
                  margin: EdgeInsets.all(Style.spacing.sm),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? style.colors.interactive
                        : style.colors.border,
                    borderRadius: BorderRadius.circular(Style.radii.small),
                  ),
                  child: Icon(
                    isSelected ? Icons.check : Icons.person,
                    size: 30,
                    color: style.colors.background,
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.all(Style.spacing.sm),
                  child: Builder(
                    builder: (context) {
                      final url = passedUser.userInfo?.imageUrl;
                      final resolvedUrl = url != null && url.isNotEmpty
                          ? '${di<EnvManager>().activeEnv!.serverUrl}serverpod_cloud_storage?method=file&path=$url'
                          : null;
                      return CircleAvatar(
                        radius: 15,
                        backgroundColor: style.colors.border,
                        backgroundImage: resolvedUrl != null
                            ? NetworkImage(resolvedUrl)
                            : null,
                        onBackgroundImageError: resolvedUrl != null
                            ? (_, __) {}
                            : null,
                        child: resolvedUrl == null
                            ? Icon(
                                Icons.person,
                                size: 18,
                                color: style.colors.background,
                              )
                            : null,
                      );
                    },
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
                            style: context.typography.subtitle.bold
                                .withColor(style.colors.foreground),
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
                            style: context.typography.body
                                .withColor(style.colors.mutedForeground),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Text(
                          'Rolle: ${passedUser.role.name}',
                          style: context.typography.bodySmall,
                        ),
                        const Gap(10),
                        if (passedUser.userInfo?.email?.isNotEmpty == true)
                          Expanded(
                            child: Text(
                              passedUser.userInfo!.email!,
                              overflow: TextOverflow.ellipsis,
                              style: context.typography.bodySmall,
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
                margin: EdgeInsets.all(Style.spacing.sm),
                child: Column(
                  children: [
                    const Gap(10),
                    Text(
                      'Credit',
                      style: context.typography.bodySmall,
                    ),
                    Text(
                      passedUser.credit.toString(),
                      style: context.typography.heading
                          .withColor(style.colors.accent),
                    ),
                  ],
                ),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
