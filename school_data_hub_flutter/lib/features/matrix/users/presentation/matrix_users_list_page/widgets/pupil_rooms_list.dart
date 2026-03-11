import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_room_edit_page/matrix_room_edit_page.dart';

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
    '$matrixBaseUrl/_matrix/client/v1/media/thumbnail/$server/$mediaId?width=64&height=64&method=crop',
    '$matrixBaseUrl/_matrix/media/v3/thumbnail/$server/$mediaId?width=64&height=64&method=crop',
  ];
}

Future<int?> selectPowerLevelByIconDialog({
  required BuildContext context,
  required String displayName,
  required int currentPowerLevel,
}) {
  Widget levelOption({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required int powerLevel,
  }) {
    final isSelected = currentPowerLevel == powerLevel;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => Navigator.of(context).pop(powerLevel),
        icon: Icon(icon, color: color),
        label: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(subtitle, style: const TextStyle(fontSize: 12)),
          ],
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(
            color: isSelected ? AppColors.backgroundColor : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }

  return showDialog<int>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Moderationsrechte setzen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rolle für $displayName wählen:'),
            const Gap(12),
            levelOption(
              context: dialogContext,
              icon: Icons.remove_red_eye_outlined,
              color: AppColors.groupColor,
              title: 'Leserechte',
              subtitle: 'Power Level 0',
              powerLevel: 0,
            ),
            const Gap(8),
            levelOption(
              context: dialogContext,
              icon: Icons.chat,
              color: Colors.orange,
              title: 'Moderation',
              subtitle: 'Power Level 50',
              powerLevel: 50,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Abbrechen'),
          ),
        ],
      );
    },
  );
}

class MatrixUserRoomsList extends WatchingWidget {
  final MatrixUser matrixUser;
  final List<MatrixRoom> matrixRooms;

  const MatrixUserRoomsList({
    required this.matrixUser,
    required this.matrixRooms,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final matrixUser = watch(this.matrixUser);
    final userRooms = matrixUser.matrixRooms;

    return Column(
      children: [
        const Gap(5),
        ListView.builder(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 5,
            bottom: 15,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: userRooms.length,
          itemBuilder: (BuildContext context, int index) {
            final roomId = userRooms[index].id;
            return MatrixUserRoomsListItem(
              matrixUser: matrixUser,
              roomId: roomId,
              key: ValueKey('matrix-user-room-${matrixUser.id}-$roomId'),
            );
          },
        ),
      ],
    );
  }
}

class MatrixUserRoomsListItem extends WatchingWidget {
  final MatrixUser matrixUser;
  final String roomId;

  const MatrixUserRoomsListItem({
    required this.matrixUser,
    required this.roomId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final matrixPolicyManager = di<MatrixPolicyManager>();
    final user = watch(matrixUser);
    final MatrixRoom matrixRoom = watch(
      matrixPolicyManager.rooms.getRoomById(roomId),
    );
    final roomAvatarUrls = _toMediaThumbnailUrls(
      avatarUrl: matrixRoom.avatarUrl,
      matrixBaseUrl: matrixPolicyManager.matrixUrl,
    );
    final imageHeaders = {'Authorization': matrixPolicyManager.matrixToken};
    final primaryAvatarUrl = roomAvatarUrls.isNotEmpty
        ? roomAvatarUrls[0]
        : null;
    final fallbackAvatarUrl = roomAvatarUrls.length > 1
        ? roomAvatarUrls[1]
        : null;

    int powerLevel = user.powerLevelForRoom(matrixRoom.id);
    if (powerLevel == 0 && matrixRoom.roomAdmins != null) {
      final RoomAdmin? admin = matrixRoom.roomAdmins!.firstWhereOrNull(
        (element) => element.id == user.id,
      );
      if (admin != null) {
        powerLevel = admin.powerLevel;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: ClipOval(
                child: primaryAvatarUrl != null
                    ? Image.network(
                        primaryAvatarUrl,
                        headers: imageHeaders,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => fallbackAvatarUrl != null
                            ? Image.network(
                                fallbackAvatarUrl,
                                headers: imageHeaders,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.group, size: 16),
                                ),
                              )
                            : Container(
                                color: Colors.grey.shade300,
                                alignment: Alignment.center,
                                child: const Icon(Icons.group, size: 16),
                              ),
                      )
                    : Container(
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(Icons.group, size: 16),
                      ),
              ),
            ),
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (ctx) =>
                                    MatrixRoomEditPage(room: matrixRoom),
                              ),
                            );
                          },
                          onLongPress: () async {
                            final bool? confirm = await confirmationDialog(
                              context: context,
                              title: 'Raum verlassen?',
                              message:
                                  'Diese/n Nutzer/in wirklich aus dem Raum entfernen?',
                            );
                            if (confirm == true) {
                              user.leaveRoom(matrixRoom);
                            }
                          },
                          child: Text(
                            matrixRoom.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      InkWell(
                        onTap: () async {
                          final int? selectedPowerLevel =
                              await selectPowerLevelByIconDialog(
                                context: context,
                                displayName: user.displayName,
                                currentPowerLevel: powerLevel >= 50 ? 50 : 0,
                              );
                          if (selectedPowerLevel != null &&
                              selectedPowerLevel != powerLevel) {
                            user.setPowerLevel(
                              matrixRoom.id,
                              selectedPowerLevel,
                            );
                          }
                        },
                        onLongPress: () async {
                          final int? selectedPowerLevel =
                              await selectPowerLevelByIconDialog(
                                context: context,
                                displayName: user.displayName,
                                currentPowerLevel: powerLevel >= 50 ? 50 : 0,
                              );
                          if (selectedPowerLevel != null &&
                              selectedPowerLevel != powerLevel) {
                            user.setPowerLevel(
                              matrixRoom.id,
                              selectedPowerLevel,
                            );
                          }
                        },
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: powerLevel >= 50
                              ? const Icon(
                                  Icons.chat,
                                  color: Colors.orange,
                                  size: 20,
                                )
                              : powerLevel >= 0
                              ? Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: AppColors.groupColor,
                                  size: 20,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                      const Gap(8),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ID: ${matrixRoom.id}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 16),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: matrixUser.id!),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('In die Zwischenablge kopiert!'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
