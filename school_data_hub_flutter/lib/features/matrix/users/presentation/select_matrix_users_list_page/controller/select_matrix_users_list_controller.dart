import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/select_matrix_users_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class SelectMatrixUsersList extends WatchingStatefulWidget {
  final List<String>? selectableMatrixUsers;
  const SelectMatrixUsersList(this.selectableMatrixUsers, {super.key});

  @override
  SelectMatrixUsersListController createState() =>
      SelectMatrixUsersListController();
}

class SelectMatrixUsersListController extends State<SelectMatrixUsersList> {
  List<MatrixUser>? users;
  List<MatrixUser>? filteredUsers;
  //TODO: This needs to be changed to specific filters!
  Map<PupilFilter, bool>? inheritedFilters;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  List<String> selectedUsers = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  @override
  void initState() {
    //di<PupilFilterManager>().refreshFilteredPupils();
    setState(() {
      inheritedFilters = di<PupilFilterManager>().pupilFilterState.value;
      users = di<MatrixPolicyManager>().matrixUsers.value;
    });
    super.initState();
  }

  void cancelSelect() {
    setState(() {
      selectedUsers.clear();
      isSelectMode = false;
    });
  }

  void onCardPress(String userId) {
    if (selectedUsers.contains(userId)) {
      setState(() {
        selectedUsers.remove(userId);
        if (selectedUsers.isEmpty) {
          isSelectMode = false;
        }
      });
    } else {
      setState(() {
        selectedUsers.add(userId);
        isSelectMode = true;
      });
    }
  }

  void clearAll() {
    setState(() {
      selectedUsers.clear();
    });
  }

  void toggleSelectAll() {
    setState(() {
      isSelectAllMode = !isSelectAllMode;
      if (isSelectAllMode) {
        final List<MatrixUser> shownUsers =
            di<MatrixPolicyFilterManager>().filteredMatrixUsers.value;
        isSelectMode = true;
        selectedUsers = shownUsers.map((user) => user.id!).toList();
      } else {
        isSelectMode = false;
        selectedUsers.clear();
      }
    });
  }

  List<String> getSelectedPupilIds() {
    return selectedUsers.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<MatrixUser> filteredUsers =
        watchValue((MatrixPolicyFilterManager x) => x.filteredMatrixUsers);
    // List<
    //     MatrixUser> filteredListedUsers = MatrixUserHelper.usersFromUserIds(widget
    //         .selectableMatrixUsers!) //di<MatrixPolicyManager>().matrixUsers.value

    //     .where((user) => filteredUsers.contains(user))
    //     .toList();
    return SelectMatrixUsersListPage(this, filteredUsers);
  }
}
