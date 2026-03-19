import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_screen/controller/select_matrix_rooms_list_controller.dart';
import 'package:flutter_it/flutter_it.dart';

class SelectMatrixRoomCard extends WatchingWidget {
  final SelectMatrixRoomsListController controller;
  final MatrixRoom passedRoom;

  const SelectMatrixRoomCard(this.controller, this.passedRoom, {super.key});
  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    List<MatrixRoom> rooms = watchValue(
      (MatrixPolicyManager x) => x.matrixRooms,
    );
    final MatrixRoom room = rooms
        .where((element) => element.id == passedRoom.id)
        .first;

    return GestureDetector(
      onLongPress: () => controller.onCardPress(room.id),
      onTap: () =>
          controller.isSelectMode ? controller.onCardPress(room.id) : {},
      child: Card(
        color: controller.selectedRooms.contains(room.id)
            ? style.colors.selectedCard
            : style.colors.background,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          room.name!,
                          style: context.typography.subtitle.bold,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Schreibrecht ab:',
                          style: context.typography.body,
                        ),
                        const Gap(5),
                        Text(
                          room.eventsDefault!.toString(),
                          style: context.typography.body.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
