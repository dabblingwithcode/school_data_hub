import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/generic_async_action_button.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/controller/select_matrix_users_list_controller.dart';

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
    '$matrixBaseUrl/_matrix/client/v1/media/thumbnail/$server/$mediaId?width=96&height=96&method=crop',
    '$matrixBaseUrl/_matrix/media/v3/thumbnail/$server/$mediaId?width=96&height=96&method=crop',
    '$matrixBaseUrl/_matrix/media/r0/thumbnail/$server/$mediaId?width=96&height=96&method=crop',
  ];
}

Future<int?> selectPowerLevelByIconDialog({
  required BuildContext context,
  required String displayName,
  required int currentPowerLevel,
}) {
  final style = Style.of(context);
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
            Text(subtitle, style: context.typography.bodySmall),
          ],
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isSelected ? style.colors.accent : style.colors.border,
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
              color: style.colors.groupColor,
              title: 'Leserechte',
              subtitle: 'Power Level 0',
              powerLevel: 0,
            ),
            const Gap(8),
            levelOption(
              context: dialogContext,
              icon: Icons.chat,
              color: style.colors.warning,
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

class MatrixUsersInRoomList extends WatchingWidget {
  final MatrixRoom room;

  const MatrixUsersInRoomList({required this.room, super.key});

  @override
  Widget build(BuildContext context) {
    final matrixPolicyManager = di<MatrixPolicyManager>();
    watch(di<MatrixPolicyManager>().users.matrixUsers);
    final List<MatrixUser> matrixUsers = (MatrixRoomHelper.usersInRoom(
      room.id,
    ));
    return Column(
      children: [
        GenericAsyncActionButton(
          onPressed: () async {
            final availableUsers = MatrixUserHelper.restOfUsers(
              MatrixUserHelper.userIdsFromUsers(matrixUsers),
            );

            final List<String> selectedUserIds =
                await Navigator.of(context).push(
                  MaterialPageRoute<List<String>>(
                    builder: (ctx) => SelectMatrixUsersList(
                      MatrixUserHelper.usersFromUserIds(availableUsers),
                    ),
                  ),
                ) ??
                [];
            if (selectedUserIds.isNotEmpty) {
              for (final String userId in selectedUserIds) {
                matrixPolicyManager.users.addMatrixUserToRooms(userId, [
                  room.id,
                ]);
              }
            }
          },
          title: "KONTO HINZUFÜGEN",
          buttonType: ButtonType.accept,
        ),

        Row(
          children: [
            const Gap(5),
            if (matrixUsers.isEmpty)
              Text(
                'Keine Konten in diesem Raum!',
                style: context.typography.subtitle
                    .withColor(Style.of(context).colors.foreground),
              ),
          ],
        ),
        const Gap(5),
        ListView.builder(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: matrixUsers.length,
          itemBuilder: (BuildContext context, int index) {
            MatrixUser matrixUser = matrixUsers[index];
            return MatrixUsersInRoomListItem(
              matrixUser: matrixUser,
              roomId: room.id,
            );
          },
        ),
      ],
    );
  }
}

class MatrixUsersInRoomListItem extends WatchingWidget {
  final String roomId;
  final MatrixUser matrixUser;
  const MatrixUsersInRoomListItem({
    required this.matrixUser,
    required this.roomId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final matrixPolicyManager = di<MatrixPolicyManager>();
    watch(matrixUser);
    final MatrixRoom room = watch(
      matrixPolicyManager.rooms.getRoomById(roomId),
    );
    final powerLevel = matrixUser.powerLevelForRoom(roomId);
    final linkedPupil = MatrixUserHelper.linkedPupil(matrixUser);
    final imageHeaders = {'Authorization': matrixPolicyManager.matrixToken};

    Widget buildAvatar() {
      if (linkedPupil != null && linkedPupil.avatar != null) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (ctx) => PupilProfilePage(pupil: linkedPupil),
              ),
            );
          },
          child: AvatarWithBadges(pupil: linkedPupil, size: 56),
        );
      }

      return FutureBuilder<String?>(
        future: matrixUser.id == null
            ? Future.value(null)
            : matrixPolicyManager.users.fetchUserAvatarUrl(matrixUser.id!),
        builder: (context, snapshot) {
          final avatarUrls = _toMediaThumbnailUrls(
            avatarUrl: snapshot.data,
            matrixBaseUrl: matrixPolicyManager.matrixUrl,
          );
          final primaryAvatarUrl = avatarUrls.isNotEmpty
              ? avatarUrls.first
              : null;
          final fallbackAvatarUrl = avatarUrls.length > 1
              ? avatarUrls[1]
              : null;

          return SizedBox(
            width: 56,
            height: 56,
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
                                color: style.colors.mutedForeground,
                                alignment: Alignment.center,
                                child: const Icon(Icons.person, size: 26),
                              ),
                            )
                          : Container(
                              color: style.colors.mutedForeground,
                              alignment: Alignment.center,
                              child: const Icon(Icons.person, size: 26),
                            ),
                    )
                  : Container(
                      color: style.colors.mutedForeground,
                      alignment: Alignment.center,
                      child: const Icon(Icons.person, size: 26),
                    ),
            ),
          );
        },
      );
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
              child: Center(child: buildAvatar()),
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
                          onLongPress: () async {
                            final bool? confirm = await confirmationDialog(
                              context: context,
                              title: 'Aus Raum entfernen?',
                              message:
                                  'Diese/n Nutzer/in wirklich aus dem Raum entfernen?',
                            );
                            if (confirm == true) {
                              matrixUser.leaveRoom(room);
                            }
                          },
                          child: Text(
                            matrixUser.displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.typography.subtitle.bold
                                .withColor(style.colors.foreground),
                          ),
                        ),
                      ),
                      const Gap(10),
                      InkWell(
                        onTap: () async {
                          final int? selectedPowerLevel =
                              await selectPowerLevelByIconDialog(
                                context: context,
                                displayName: matrixUser.displayName,
                                currentPowerLevel: powerLevel >= 50 ? 50 : 0,
                              );
                          if (selectedPowerLevel != null &&
                              selectedPowerLevel != powerLevel) {
                            matrixUser.setPowerLevel(
                              room.id,
                              selectedPowerLevel,
                            );
                          }
                        },
                        onLongPress: () async {
                          final int? selectedPowerLevel =
                              await selectPowerLevelByIconDialog(
                                context: context,
                                displayName: matrixUser.displayName,
                                currentPowerLevel: powerLevel >= 50 ? 50 : 0,
                              );
                          if (selectedPowerLevel != null &&
                              selectedPowerLevel != powerLevel) {
                            matrixUser.setPowerLevel(
                              room.id,
                              selectedPowerLevel,
                            );
                          }
                        },
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: powerLevel >= 50
                              ? Icon(
                                  Icons.chat,
                                  color: style.colors.warning,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: style.colors.groupColor,
                                  size: 20,
                                ),
                        ),
                      ),
                      const Gap(8),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ID: ${matrixUser.id ?? '-'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.typography.body
                              .withColor(style.colors.mutedForeground),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 16),
                        onPressed: () {
                          if (matrixUser.id == null) {
                            return;
                          }
                          Clipboard.setData(
                            ClipboardData(text: matrixUser.id!),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('In die Zwischenablage kopiert!'),
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
