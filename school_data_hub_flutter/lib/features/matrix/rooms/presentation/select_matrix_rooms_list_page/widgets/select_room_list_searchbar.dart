import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/widgets/matrix_search_text_field.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_page/controller/select_matrix_rooms_list_controller.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_page/widgets/select_matrix_rooms_filter_bottom_sheet.dart';

final _matrixPolicyFilterManager = di<MatrixPolicyFilterManager>();

class SelectRoomListSearchBar extends WatchingWidget {
  final List<MatrixRoom> matrixRooms;
  final SelectMatrixRoomsListController controller;
  const SelectRoomListSearchBar({
    required this.matrixRooms,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool filtersOn = watchValue(
      (MatrixPolicyFilterManager x) => x.filtersOn,
    );
    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          const Gap(5),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.meeting_room_rounded,
                    color: AppColors.backgroundColor,
                  ),
                  const Gap(10),
                  Text(
                    matrixRooms.length.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  const Text('Ausgewählt:', style: TextStyle(fontSize: 13)),
                  const Gap(10),
                  Text(
                    controller.selectedRooms.length.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: MatrixSearchTextField(
                    searchType: SearchType.room,
                    hintText: 'Raum suchen',
                    refreshFunction:
                        _matrixPolicyFilterManager.setRoomsFilterText,
                  ),
                ),
                InkWell(
                  onTap: () => showSelectMatrixRoomsFilterBottomSheet(context),
                  onLongPress: () =>
                      _matrixPolicyFilterManager.resetAllMatrixFilters(),
                  // onPressed: () => showBottomSheetFilters(context),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.filter_list,
                      color: filtersOn ? Colors.deepOrange : Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
