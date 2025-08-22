import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:watch_it/watch_it.dart';

class UserListCard extends WatchingWidget {
  final User user;
  const UserListCard(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => CustomExpansionTileController());

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // User avatar/icon
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  user.role == Role.admin
                      ? Icons.admin_panel_settings
                      : Icons.person,
                  size: 40,
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
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                tileController.isExpanded
                                    ? tileController.collapse()
                                    : tileController.expand();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    user.userInfo?.userName ?? 'Unknown User',
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Gap(5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(user.userInfo?.fullName ?? 'N/A'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text('Rolle: ${user.role.name}'),
                                const Gap(10),
                                Text('Email: ${user.userInfo?.email ?? 'N/A'}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const Text('Zeiteinheiten:'),
                                const Gap(5),
                                Text(
                                  user.timeUnits.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(20),
              InkWell(
                onTap: () {
                  tileController.isExpanded
                      ? tileController.collapse()
                      : tileController.expand();
                },
                child: Column(
                  children: [
                    const Gap(20),
                    const Text('Credit'),
                    Center(
                      child: Text(
                        user.credit.toString(),
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
          CustomExpansionTileContent(
            title: null,
            tileController: tileController,
            widgetList: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User ID: ${user.id ?? 'N/A'}'),
                    const Gap(5),
                    Text('User Info ID: ${user.userInfoId}'),
                    const Gap(5),
                    Text(
                      'Erstellt: ${user.userInfo?.created != null ? user.userInfo!.created.formatForUser() : 'N/A'}',
                    ),
                    const Gap(5),
                    Text(
                      'Autorisierte Schüler: ${user.pupilsAuth?.length ?? 0}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
