import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyManager = di<MatrixPolicyManager>();

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
    List<MatrixRoom> namedMatrixRooms = _matrixPolicyManager.matrixRooms.value;
    final user = watch<MatrixUser>(matrixUser);

    return Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                'Räume:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
        const Gap(5),
        ListView.builder(
          padding: const EdgeInsets.only(left: 20, top: 5, bottom: 15),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: matrixRooms.length,
          itemBuilder: (BuildContext context, int index) {
            int powerLevel = 0;
            final List<MatrixRoom> matrixRoomList = List.from(matrixRooms);
            MatrixRoom matrixRoom = namedMatrixRooms.firstWhere(
              (element) => element.id == matrixRoomList[index].id,
            );
            if (matrixRoom.roomAdmins != null) {
              RoomAdmin? admin = matrixRoom.roomAdmins!.firstWhereOrNull(
                (element) => element.id == user.id,
              );
              if (admin != null) {
                powerLevel = admin.powerLevel;
              }
            }

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
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Gap(5),
                        InkWell(
                          onLongPress: () async {
                            final bool? result = await confirmationDialog(
                              context: context,
                              message:
                                  'Moderationsrechte für ${matrixUser.displayName} vergeben?',
                              title: 'Moderationsrechte vergeben',
                            );
                            if (result == true) {
                              matrixUser.setPowerLevel(
                                matrixRooms[index].id,
                                50,
                              );
                              // _matrixPolicyManager.rooms.changeRoomPowerLevels(
                              //   roomId: roomId,
                              //   roomAdmin: RoomAdmin(
                              //     id: matrixUser.id!,
                              //     powerLevel: 50,
                              //   ),
                              // );
                            }
                          },
                          child: Text(matrixRoom.id),
                        ),
                        const Gap(5),
                        powerLevel > 99
                            ? const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              )
                            : powerLevel > 49
                            ? const Icon(
                                Icons.chat,
                                color: Colors.orange,
                                size: 20,
                              )
                            : powerLevel > 29
                            ? const Icon(
                                Icons.remove_red_eye_outlined,
                                color: AppColors.groupColor,
                                size: 20,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

List<Widget> roomsList(
  MatrixUser matrixUser,
  List<MatrixRoom> matrixRooms,
  BuildContext context,
) {
  List<MatrixRoom> namedMatrixRooms = _matrixPolicyManager.matrixRooms.value;

  return [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        //margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        child: ElevatedButton(
          style: AppStyles.successButtonStyle,
          onPressed: () async {
            // changeCreditDialog(context, pupil);
          },
          child: const Text("RÄUME ÄNDERN", style: AppStyles.buttonTextStyle),
        ),
      ),
    ),
    const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 22),
          child: Text(
            'Räume:',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ],
    ),
    const Gap(5),
    ListView.builder(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: matrixRooms.length,
      itemBuilder: (BuildContext context, int index) {
        int powerLevel = 0;
        final List<MatrixRoom> matrixRoomList = List.from(matrixRooms);
        MatrixRoom matrixRoom = namedMatrixRooms.firstWhere(
          (element) => element.id == matrixRoomList[index].id,
        );
        RoomAdmin? admin = matrixRoom.roomAdmins!.firstWhereOrNull(
          (element) => element.id == matrixUser.id,
        );
        if (admin != null) {
          powerLevel = admin.powerLevel;
        }
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: GestureDetector(
            onTap: () {
              //- TO-DO: change missed class function
              //- like _changeMissedSchooldayHermannpupilPage
            },
            onLongPress: () async {},
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      matrixRoom.name!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Gap(5),
                    Text(matrixRoom.id),
                    const Gap(5),
                    powerLevel > 99
                        ? const Icon(Icons.star, color: Colors.yellow, size: 20)
                        : powerLevel > 49
                        ? const Icon(Icons.chat, color: Colors.orange, size: 20)
                        : powerLevel > 29
                        ? const Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColors.groupColor,
                            size: 20,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  ];
}
