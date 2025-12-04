import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/controller/select_matrix_users_list_controller.dart';
import 'package:watch_it/watch_it.dart';

class MatrixUsersInRoomList extends WatchingWidget {
  final List<MatrixUser> matrixUsers;
  final String roomId;

  const MatrixUsersInRoomList({
    required this.matrixUsers,
    required this.roomId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _matrixPolicyManager = di<MatrixPolicyManager>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            //margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            child: ElevatedButton(
              style: AppStyles.successButtonStyle,
              onPressed: () async {
                final availableUsers = MatrixUserHelper.restOfUsers(
                  MatrixUserHelper.userIdsFromUsers(matrixUsers),
                );

                final List<String> selectedUserIds =
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => SelectMatrixUsersList(
                          MatrixUserHelper.usersFromUserIds(availableUsers),
                        ),
                      ),
                    ) ??
                    [];
                if (selectedUserIds.isNotEmpty) {
                  for (final String userId in selectedUserIds) {
                    _matrixPolicyManager.users.addMatrixUserToRooms(userId, [
                      roomId,
                    ]);
                  }
                }
              },
              child: const Text(
                "KONTO HINZUFÜGEN",
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ),
        ),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                'Konten:',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
        const Gap(5),
        ListView.builder(
          padding: const EdgeInsets.only(left: 20, top: 5, bottom: 15),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: matrixUsers.length,
          itemBuilder: (BuildContext context, int index) {
            // final List<MatrixUser> matrixUserList = List.from(matrixUsers);
            MatrixUser matrixUser = matrixUsers[index];
            return MatrixUsersInRoomListItem(
              matrixUser: matrixUser,
              roomId: roomId,
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
    final _matrixPolicyManager = di<MatrixPolicyManager>();
    watch(matrixUser);
    final MatrixRoom room = watch(
      _matrixPolicyManager.rooms.getRoomById(roomId),
    );

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {},
        onLongPress: () async {},
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onLongPress: () async {
                    final bool? result = await confirmationDialog(
                      context: context,
                      message:
                          'Moderationsrechte für ${matrixUser.displayName} vergeben?',
                      title: 'Moderationsrechte vergeben',
                    );
                    if (result == true) {
                      matrixUser.setPowerLevel(roomId, 50);
                      // _matrixPolicyManager.rooms.changeRoomPowerLevels(
                      //   roomId: roomId,
                      //   roomAdmin: RoomAdmin(
                      //     id: matrixUser.id!,
                      //     powerLevel: 50,
                      //   ),
                      // );
                    }
                  },
                  child: Text(
                    matrixUser.displayName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                if (matrixUser.joinedRooms
                        .firstWhere((element) => element.roomId == roomId)
                        .powerLevel ==
                    50)
                  InkWell(
                    onLongPress: () async {
                      final confirmation = await confirmationDialog(
                        context: context,
                        title: 'Moderationsrechte entziehen',
                        message:
                            'Soll dem Konto die Moderationsrechte entzogen werden?',
                      );
                      if (confirmation == true) {
                        matrixUser.setPowerLevel(roomId, 0);
                        // _matrixPolicyManager.rooms.changeRoomPowerLevels(
                        //   roomId: roomId,
                        //   removeAdminWithId: matrixUser.id!,
                        // );
                      }
                    },
                    child: const Icon(Icons.check, color: Colors.green),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
