import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/widgets/change_power_levels_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/widgets/users_in_room_list.dart';
import 'package:watch_it/watch_it.dart';

class RoomListCard extends WatchingWidget {
  final MatrixRoom matrixRoom;
  const RoomListCard(this.matrixRoom, {super.key});

  @override
  Widget build(BuildContext context) {
    final _matrixPolicyManager = di<MatrixPolicyManager>();
    final _tileController = createOnce<CustomExpansionTileController>(
      () => CustomExpansionTileController(),
    );

    final room = watch<MatrixRoom>(
      MatrixRoomHelper.roomsFromRoomIds([matrixRoom.id]).first,
    );

    final List<MatrixUser> matrixUsersInRoom = MatrixRoomHelper.usersInRoom(
      room.id,
    );
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
              //AvatarWithBadges(pupil: pupil, size: 80),
              const Gap(10),
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
                              onTap: () async {
                                final confirm = await confirmationDialog(
                                  context: context,
                                  message:
                                      'Raum ${room.name} aus der Policy löschen?',
                                  title: 'Raum aus der Policy rausnehmen',
                                );
                                if (confirm == true) {
                                  await _matrixPolicyManager.rooms
                                      .removeManagedRoom(room);
                                }
                              },
                              child: Text(
                                '${room.name}',
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SelectableText(
                                  room.id,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: room.id),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Copied to clipboard'),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    const Text(
                      'Berechtigungen',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const Text(
                                  'Schreiben: ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const Gap(5),
                                InkWell(
                                  onTap: () async {
                                    final int? newPowerLevel =
                                        await changePowerLevelsDialog(context);
                                    if (newPowerLevel == null ||
                                        newPowerLevel < 0) {
                                      return;
                                    }
                                    _matrixPolicyManager.rooms
                                        .changeRoomPowerLevels(
                                          roomId: room.id,
                                          eventsDefault: newPowerLevel,
                                        );
                                  },
                                  child: Text(
                                    room.eventsDefault.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.interactiveColor,
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                const Text(
                                  'Reaktionen:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const Gap(5),
                                InkWell(
                                  onTap: () async {
                                    final int? newPowerLevel =
                                        await changePowerLevelsDialog(context);
                                    if (newPowerLevel == null ||
                                        newPowerLevel < 0) {
                                      return;
                                    }
                                    _matrixPolicyManager.rooms
                                        .changeRoomPowerLevels(
                                          roomId: room.id,
                                          reactions: newPowerLevel,
                                        );
                                  },
                                  child: Text(
                                    room.powerLevelReactions.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.interactiveColor,
                                    ),
                                  ),
                                ),
                                const Gap(10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    const Text(
                      'Rechte',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    // Row(
                    //   children: [
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         for (final roomAdmin in room.roomAdmins!)
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [
                    //               InkWell(
                    //                 onLongPress: () async {
                    //                   final bool?
                    //                   confirmation = await confirmationDialog(
                    //                     context: context,
                    //                     message:
                    //                         'Moderationsrechte für ${roomAdmin.id} entziehen?',
                    //                     title: 'Moderationsrechte entziehen',
                    //                   );
                    //                   if (confirmation != true) return;
                    //                   _matrixPolicyManager.rooms
                    //                       .changeRoomPowerLevels(
                    //                         roomId: room.id,
                    //                         removeAdminWithId: roomAdmin.id,
                    //                       );
                    //                 },
                    //                 child: Text(roomAdmin.id),
                    //               ),
                    //               const Gap(5),
                    //               Text(
                    //                 roomAdmin.powerLevel.toString(),
                    //                 style: const TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    const Gap(10),
                  ],
                ),
              ),
              const Gap(20),
              InkWell(
                onTap: () {
                  _tileController.isExpanded
                      ? _tileController.collapse()
                      : _tileController.expand();
                },
                child: Column(
                  children: [
                    const Gap(20),
                    const Text('Konten'),
                    Center(
                      child: Text(
                        matrixUsersInRoom.length.toString(),
                        style: TextStyle(
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
            tileController: _tileController,
            widgetList: [
              MatrixUsersInRoomList(
                matrixUsers: matrixUsersInRoom,
                roomId: room.id,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
