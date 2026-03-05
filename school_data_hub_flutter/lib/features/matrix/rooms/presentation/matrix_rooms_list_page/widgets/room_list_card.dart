import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/dialogs/remove_room_from_policy_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_room_edit_page/matrix_room_edit_page.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/widgets/change_power_levels_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/widgets/users_in_room_list.dart';

class RoomListCard extends WatchingWidget {
  final MatrixRoom matrixRoom;
  const RoomListCard(this.matrixRoom, {super.key});

  List<String> _toMediaThumbnailUrls({
    required String? avatarUrl,
    required String matrixBaseUrl,
  }) {
    if (avatarUrl == null || avatarUrl.isEmpty) {
      return const [];
    }

    if (!avatarUrl.startsWith('mxc://')) {
      return [avatarUrl];
    }

    final uri = Uri.tryParse(avatarUrl);
    if (uri == null || uri.host.isEmpty || uri.pathSegments.isEmpty) {
      return const [];
    }

    final server = Uri.encodeComponent(uri.host);
    final mediaId = Uri.encodeComponent(uri.pathSegments.join('/'));

    return [
      '$matrixBaseUrl/_matrix/client/v1/media/thumbnail/$server/$mediaId?width=80&height=80&method=crop',
      '$matrixBaseUrl/_matrix/media/v3/thumbnail/$server/$mediaId?width=80&height=80&method=crop',
      '$matrixBaseUrl/_matrix/media/r0/thumbnail/$server/$mediaId?width=80&height=80&method=crop',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final matrixPolicyManager = di<MatrixPolicyManager>();
    final roomManager = matrixPolicyManager.rooms;
    watch(roomManager.compulsoryRooms);
    final compulsory = roomManager.getCompulsoryRoomFor(matrixRoom.id);
    final tileController = createOnce<CustomExpansionTileController>(
      () => CustomExpansionTileController(),
    );

    final room = watch<MatrixRoom>(
      MatrixRoomHelper.roomsFromRoomIds([matrixRoom.id]).first,
    );
    final roomAvatarUrls = _toMediaThumbnailUrls(
      avatarUrl: room.avatarUrl,
      matrixBaseUrl: matrixPolicyManager.matrixUrl,
    );
    final imageHeaders = {'Authorization': matrixPolicyManager.matrixToken};
    final primaryAvatarUrl = roomAvatarUrls.isNotEmpty
        ? roomAvatarUrls[0]
        : null;
    final fallbackAvatarUrl = roomAvatarUrls.length > 1
        ? roomAvatarUrls[1]
        : null;
    final matrixUsersInRoom = MatrixRoomHelper.usersInRoom(room.id);

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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipOval(
                      child: primaryAvatarUrl != null
                          ? Image.network(
                              primaryAvatarUrl,
                              fit: BoxFit.cover,
                              headers: imageHeaders,
                              errorBuilder: (_, __, ___) =>
                                  fallbackAvatarUrl != null
                                  ? Image.network(
                                      fallbackAvatarUrl,
                                      fit: BoxFit.cover,
                                      headers: imageHeaders,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: Colors.grey.shade300,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.group,
                                          size: 18,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      color: Colors.grey.shade300,
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.group, size: 18),
                                    ),
                            )
                          : Container(
                              color: Colors.grey.shade300,
                              alignment: Alignment.center,
                              child: const Icon(Icons.group, size: 18),
                            ),
                    ),
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
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Navigator.of(context).push<void>(
                                        MaterialPageRoute<void>(
                                          builder: (ctx) =>
                                              MatrixRoomEditPage(room: room),
                                        ),
                                      );
                                    },
                                    onLongPress: () async {
                                      final result =
                                          await showRemoveRoomFromPolicyDialog(
                                            context,
                                            roomName: room.name ?? room.id,
                                          );
                                      if (result != null) {
                                        await matrixPolicyManager.rooms
                                            .removeManagedRoom(
                                              room,
                                              purgeRoom: result.purge,
                                            );
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
                                  if (compulsory != null) ...[
                                    const Gap(8),
                                    Chip(
                                      label: Text(
                                        _compulsoryRoomTypeLabel(
                                          compulsory.roomType,
                                        ),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      backgroundColor: _compulsoryRoomTypeColor(
                                        compulsory.roomType,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ],
                                ],
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            tooltip: 'Raum-Avatar setzen',
                            icon: const Icon(Icons.add_a_photo_outlined),
                            onPressed: () async {
                              final FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(
                                    type: FileType.image,
                                    withData: true,
                                  );
                              if (result == null || result.files.isEmpty) {
                                return;
                              }

                              final file = result.files.first;
                              final bytes = file.bytes;
                              final fileName = file.name;

                              if (bytes == null || fileName.isEmpty) {
                                return;
                              }

                              await matrixPolicyManager.rooms.setRoomAvatar(
                                roomId: room.id,
                                fileBytes: bytes,
                                fileName: fileName,
                              );
                            },
                          ),
                          const Gap(10),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: room.id));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'In die Zwischenablge kopiert!',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

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
                    ],
                  ),
                ),
                const Gap(20),
                InkWell(
                  onTap: () => tileController.toggle(),
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
              ],
            ),
            const Row(
              children: [
                Text(
                  'Berechtigungen',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                        const Text(
                          'Schreiben: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Gap(5),
                        InkWell(
                          onTap: () async {
                            final int? newPowerLevel =
                                await changePowerLevelsDialog(context);
                            if (newPowerLevel == null || newPowerLevel < 0) {
                              return;
                            }
                            matrixPolicyManager.rooms.changeRoomPowerLevels(
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
                            if (newPowerLevel == null || newPowerLevel < 0) {
                              return;
                            }
                            matrixPolicyManager.rooms.changeRoomPowerLevels(
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

            CustomExpansionTileContent(
              title: null,
              tileController: tileController,
              widgetList: [MatrixUsersInRoomList(room: room)],
            ),
          ],
        ),
      ),
    );
  }

  static String _compulsoryRoomTypeLabel(MatrixRoomType t) {
    switch (t) {
      case MatrixRoomType.contacts:
        return 'Kontakte';
      case MatrixRoomType.globalParents:
        return 'Eltern';
      case MatrixRoomType.globalChildrem:
        return 'Kinder';
      case MatrixRoomType.globalTeacher:
        return 'Lehrer';
      case MatrixRoomType.groupChildren:
        return 'Kinder Gr.';
      case MatrixRoomType.groupParents:
        return 'Eltern Gr.';
      case MatrixRoomType.staff:
        return 'Mitarbeiter';
      case MatrixRoomType.other:
        return 'Sonstige';
    }
  }

  static Color _compulsoryRoomTypeColor(MatrixRoomType t) {
    switch (t) {
      case MatrixRoomType.contacts:
        return Colors.blue.shade100;
      case MatrixRoomType.globalParents:
        return Colors.orange.shade100;
      case MatrixRoomType.globalChildrem:
        return Colors.green.shade100;
      case MatrixRoomType.globalTeacher:
        return Colors.purple.shade100;
      case MatrixRoomType.groupChildren:
        return Colors.teal.shade100;
      case MatrixRoomType.groupParents:
        return Colors.amber.shade100;
      case MatrixRoomType.staff:
        return Colors.indigo.shade100;
      case MatrixRoomType.other:
        return Colors.grey.shade300;
    }
  }
}
