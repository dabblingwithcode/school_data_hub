import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_page/select_matrix_rooms_list_page.dart';

class SelectMatrixRoomsList extends WatchingStatefulWidget {
  final List<String>? selectableRooms;
  const SelectMatrixRoomsList(this.selectableRooms, {super.key});

  @override
  SelectMatrixRoomsListController createState() =>
      SelectMatrixRoomsListController();
}

class SelectMatrixRoomsListController extends State<SelectMatrixRoomsList> {
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  List<String> selectedRooms = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  MatrixPolicyFilterManager get _matrixPolicyFilterManager =>
      di<MatrixPolicyFilterManager>();

  void cancelSelect() {
    setState(() {
      selectedRooms.clear();
      isSelectMode = false;
    });
  }

  void onCardPress(String roomId) {
    if (selectedRooms.contains(roomId)) {
      setState(() {
        selectedRooms.remove(roomId);
        if (selectedRooms.isEmpty) {
          isSelectMode = false;
        }
      });
    } else {
      setState(() {
        selectedRooms.add(roomId);
        isSelectMode = true;
      });
    }
  }

  void clearAll() {
    setState(() {
      isSelectMode = false;
      selectedRooms.clear();
    });
  }

  void toggleSelectAll() {
    setState(() {
      isSelectAllMode = !isSelectAllMode;
      if (isSelectAllMode) {
        final List<MatrixRoom> shownRooms =
            _matrixPolicyFilterManager.filteredMatrixRooms.value;
        isSelectMode = true;
        selectedRooms = shownRooms.map((room) => room.id).toList();
      } else {
        isSelectMode = false;
        selectedRooms.clear();
      }
    });
  }

  List<String> getSelectedPupilIds() {
    return selectedRooms.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<MatrixRoom> filteredRooms = watchValue(
      (MatrixPolicyFilterManager x) => x.filteredMatrixRooms,
    );

    List<MatrixRoom> filteredListedRooms = MatrixRoomHelper.roomsFromRoomIds(
      widget.selectableRooms!,
    ).where((room) => filteredRooms.contains(room)).toList();
    return SelectMatrixRoomsListPage(this, filteredListedRooms);
  }
}
