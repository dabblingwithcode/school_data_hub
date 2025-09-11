import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyManager = di<MatrixPolicyManager>();

class MatrixPolicyFilterManager {
  final _filtersOn = ValueNotifier<bool>(false);
  ValueListenable<bool> get filtersOn => _filtersOn;

  final _filteredMatrixUsers = ValueNotifier<List<MatrixUser>>(
    _matrixPolicyManager.matrixUsers.value,
  );
  ValueListenable<List<MatrixUser>> get filteredMatrixUsers =>
      _filteredMatrixUsers;

  final _filteredMatrixRooms = ValueNotifier<List<MatrixRoom>>(
    _matrixPolicyManager.matrixRooms.value,
  );
  ValueListenable<List<MatrixRoom>> get filteredMatrixRooms =>
      _filteredMatrixRooms;

  final _searchText = ValueNotifier<String>('');
  ValueListenable<String> get searchText => _searchText;

  final _searchController = ValueNotifier<TextEditingController>(
    TextEditingController(),
  );
  ValueListenable<TextEditingController> get searchController =>
      _searchController;

  MatrixPolicyFilterManager(MatrixPolicyManager matrixPolicyManager)
    : _policyManager = matrixPolicyManager {
    refreshFilteredMatrixUsers();
    _policyManager.addListener(refreshFilteredMatrixUsers);
    _policyManager.rooms.matrixRooms.addListener(reactWhenRoomListChanges);
  }

  final MatrixPolicyManager _policyManager;

  void dispose() {
    _searchController.value.dispose();
    _policyManager.removeListener(refreshFilteredMatrixUsers);
    _policyManager.rooms.matrixRooms.removeListener(reactWhenRoomListChanges);
  }

  void resetAllMatrixFilters() {
    _searchText.value = '';
    _filteredMatrixUsers.value = _matrixPolicyManager.matrixUsers.value;
    _filteredMatrixRooms.value = _matrixPolicyManager.matrixRooms.value;
    _filtersOn.value = false;
    _searchController.value.clear();
  }

  void refreshFilteredMatrixUsers() {
    setUsersFilterText(_searchText.value);
  }

  void reactWhenRoomListChanges() {
    _filteredMatrixRooms.value = _matrixPolicyManager.matrixRooms.value;
  }

  void refreshFilteredMatrixRooms() {
    setRoomsFilterText(_searchText.value);
  }

  void setUsersFilterText(String text) {
    if (text == '') {
      _searchText.value = text;
      _filteredMatrixUsers.value = _matrixPolicyManager.matrixUsers.value;
      _filtersOn.value = false;
      return;
    }
    List<MatrixUser> matrixUsers = List.from(
      _matrixPolicyManager.matrixUsers.value,
    );
    List<MatrixUser> filteredMatrixUsers = [];
    filteredMatrixUsers =
        matrixUsers
            .where(
              (MatrixUser user) =>
                  user.displayName.toLowerCase().contains(text.toLowerCase()),
            )
            .toList();
    _filteredMatrixUsers.value = filteredMatrixUsers;
    _filtersOn.value = true;
  }

  setRoomsFilterText(String text) {
    if (text == '') {
      _searchText.value = text;
      _filteredMatrixRooms.value = _matrixPolicyManager.matrixRooms.value;
      _filtersOn.value = false;
      return;
    }
    final List<MatrixRoom> matrixRooms = List.from(
      _matrixPolicyManager.matrixRooms.value,
    );
    List<MatrixRoom> filteredMatrixRooms = [];
    filteredMatrixRooms =
        matrixRooms
            .where(
              (MatrixRoom room) =>
                  room.name!.toLowerCase().contains(text.toLowerCase()) ||
                  room.id.toLowerCase().contains(text.toLowerCase()),
            )
            .toList();
    _filteredMatrixRooms.value = filteredMatrixRooms;
    _filtersOn.value = true;
  }
}
