import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_room_helpers.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/matrix_rooms_list_page/widgets/change_power_levels_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/matrix_rooms_list_page/widgets/users_in_room_list.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyManager = di<MatrixPolicyManager>();

class RoomListCard extends WatchingStatefulWidget {
  final MatrixRoom matrixRoom;
  const RoomListCard(this.matrixRoom, {super.key});

  @override
  State<RoomListCard> createState() => _RoomListCardState();
}

class _RoomListCardState extends State<RoomListCard> {
  late CustomExpansionTileController _tileController;
  @override
  void initState() {
    super.initState();
    _tileController = CustomExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = watchValue((MatrixPolicyManager x) => x.matrixRooms);
    final room =
        rooms.firstWhere((element) => element.id == widget.matrixRoom.id);
    final List<MatrixUser> matrixUsersInRoom =
        MatrixRoomHelper.usersInRoom(room.id);
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
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
                              onTap: () {
                                // locator<BottomNavManager>()
                                //     .setPupilProfileNavPage(2);
                                // TODO: implement this
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (ctx) => MatrixRoomPage(
                                //     matrixRoom: room,
                                //   ),
                                // ));
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
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: room.id));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Copied to clipboard')),
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
                    const Text('Berechtigungen',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const Text(
                                  'Schreiben: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
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
                                    _matrixPolicyManager.changeRoomPowerLevels(
                                      roomId: room.id,
                                      eventsDefault:
                                          room.eventsDefault == 50 ? 0 : 50,
                                    );
                                  },
                                  child: Text(
                                    room.eventsDefault.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.interactiveColor,
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                const Text(
                                  'Reaktionen:',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Gap(5),
                                InkWell(
                                  child: Text(
                                    room.powerLevelReactions.toString(),
                                    style: const TextStyle(
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
                    const Text('Rechte',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const Gap(5),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final roomAdmin in room.roomAdmins!)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onLongPress: () async {
                                      final bool? confirmation =
                                          await confirmationDialog(
                                              context: context,
                                              message:
                                                  'Moderationsrechte für ${roomAdmin.id} entziehen?',
                                              title:
                                                  'Moderationsrechte entziehen');
                                      if (confirmation != true) return;
                                      _matrixPolicyManager
                                          .changeRoomPowerLevels(
                                        roomId: room.id,
                                        removeAdminWithId: roomAdmin.id,
                                      );
                                    },
                                    child: Text(
                                      roomAdmin.id,
                                    ),
                                  ),
                                  const Gap(5),
                                  Text(
                                    roomAdmin.powerLevel.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
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
              tileController: _tileController,
              widgetList: [
                MatrixUsersInRoomList(
                    matrixUsers: matrixUsersInRoom, roomId: room.id)
              ])
        ],
      ),
    );
  }
}
