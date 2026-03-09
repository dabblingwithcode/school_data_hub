import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_user_filter_category.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user_relationship.dart';

class MatrixPolicyFilterManager {
  final _filtersOn = ValueNotifier<bool>(false);
  ValueListenable<bool> get filtersOn => _filtersOn;

  final _includedCategories = ValueNotifier<Set<MatrixUserFilterCategory>>({});
  ValueListenable<Set<MatrixUserFilterCategory>> get includedCategories =>
      _includedCategories;

  final _filteredMatrixUsers = ValueNotifier<List<MatrixUser>>([]);
  ValueListenable<List<MatrixUser>> get filteredMatrixUsers =>
      _filteredMatrixUsers;

  final _filteredMatrixRooms = ValueNotifier<List<MatrixRoom>>([]);
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
    _filteredMatrixUsers.value = _policyManager.matrixUsers.value;
    _filteredMatrixRooms.value = _policyManager.matrixRooms.value;
    refreshFilteredMatrixUsers();
    _policyManager.matrixUsers.addListener(refreshFilteredMatrixUsers);
    _policyManager.matrixRooms.addListener(reactWhenRoomListChanges);
  }

  final MatrixPolicyManager _policyManager;

  void dispose() {
    _searchController.value.dispose();
    _policyManager.matrixUsers.removeListener(refreshFilteredMatrixUsers);
    _policyManager.matrixRooms.removeListener(reactWhenRoomListChanges);
  }

  void resetAllMatrixFilters() {
    _searchText.value = '';
    _includedCategories.value = {};
    _filteredMatrixUsers.value = _policyManager.matrixUsers.value;
    _filteredMatrixRooms.value = _policyManager.matrixRooms.value;
    _filtersOn.value = false;
    _searchController.value.clear();
  }

  void refreshFilteredMatrixUsers() {
    setUsersFilterText(_searchText.value);
  }

  void setIncludedCategories(Set<MatrixUserFilterCategory> categories) {
    _includedCategories.value = Set.from(categories);
    refreshFilteredMatrixUsers();
    _filtersOn.value =
        _searchText.value.isNotEmpty || _includedCategories.value.isNotEmpty;
  }

  void toggleCategory(MatrixUserFilterCategory category) {
    final current = Set<MatrixUserFilterCategory>.from(_includedCategories.value);
    if (current.contains(category)) {
      current.remove(category);
    } else {
      current.add(category);
    }
    setIncludedCategories(current);
  }

  bool isCategoryIncluded(MatrixUserFilterCategory category) {
    final set = _includedCategories.value;
    if (set.isEmpty) return true;
    return set.contains(category);
  }

  static MatrixUserFilterCategory? _categoryFromRelationship(
    MatrixUserRelationship? rel,
  ) {
    if (rel == null) return MatrixUserFilterCategory.noRelation;
    if (rel.isTeacher) return MatrixUserFilterCategory.staff;
    if (rel.isLinked) return MatrixUserFilterCategory.pupil;
    if (rel.isFamily) return MatrixUserFilterCategory.familyParent;
    if (rel.isParent) return MatrixUserFilterCategory.parent;
    return MatrixUserFilterCategory.noRelation;
  }

  void reactWhenRoomListChanges() {
    _filteredMatrixRooms.value = _policyManager.matrixRooms.value;
  }

  void refreshFilteredMatrixRooms() {
    setRoomsFilterText(_searchText.value);
  }

  void setUsersFilterText(String text) {
    _searchText.value = text;
    List<MatrixUser> matrixUsers = List.from(_policyManager.matrixUsers.value);
    if (text.isNotEmpty) {
      matrixUsers = matrixUsers
          .where(
            (MatrixUser user) =>
                user.displayName.toLowerCase().contains(text.toLowerCase()),
          )
          .toList();
    }
    final categories = _includedCategories.value;
    if (categories.isNotEmpty) {
      matrixUsers = matrixUsers.where((MatrixUser user) {
        final rel = MatrixUserHelper.getUserRelationship(user);
        final cat = _categoryFromRelationship(rel);
        return cat != null && categories.contains(cat);
      }).toList();
    }
    _filteredMatrixUsers.value = matrixUsers;
    _filtersOn.value = text.isNotEmpty || categories.isNotEmpty;
  }

  void setRoomsFilterText(String text) {
    if (text == '') {
      _searchText.value = text;
      _filteredMatrixRooms.value = _policyManager.matrixRooms.value;
      _filtersOn.value = false;
      return;
    }
    final List<MatrixRoom> matrixRooms = List.from(
      _policyManager.matrixRooms.value,
    );
    List<MatrixRoom> filteredMatrixRooms = [];
    filteredMatrixRooms = matrixRooms
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
