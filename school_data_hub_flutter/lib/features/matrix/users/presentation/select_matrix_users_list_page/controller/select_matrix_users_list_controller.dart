import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/services/matrix_bulk_credentials_service.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/select_matrix_users_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class SelectMatrixUsersList extends WatchingStatefulWidget {
  final List<MatrixUser>? selectableMatrixUsers;
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
      users = widget.selectableMatrixUsers;
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

  List<MatrixUser> getSelectedMatrixUsers() {
    if (users == null) return [];
    return users!.where((user) => selectedUsers.contains(user.id)).toList();
  }

  Future<void> generateBulkCredentials(BuildContext context) async {
    if (selectedUsers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte wählen Sie mindestens einen Benutzer aus.'),
        ),
      );
      return;
    }

    final selectedMatrixUsers = getSelectedMatrixUsers();

    // Show confirmation dialog

    // Show progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Credentials werden generiert...'),
            ],
          ),
        );
      },
    );

    try {
      // Import the service
      final matrixDomain = di<MatrixPolicyManager>().matrixUrl;
      final isStaff = true; // You might want to determine this dynamically

      final pdfFile =
          await MatrixBulkCredentialsService.generateBulkCredentials(
            matrixDomain: matrixDomain,
            selectedUsers: selectedMatrixUsers,
            isStaff: isStaff,
            onProgress: (String progress) {
              // Update progress dialog if needed
            },
            onError: (String error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(error)));
            },
          );

      // Close progress dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      if (pdfFile != null) {
        // Show PDF preview
        if (context.mounted) {
          print('Navigating to BulkPdfViewPage with file: ${pdfFile.path}');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfViewerPage(pdfFile: pdfFile),
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fehler beim Generieren der Credentials.'),
            ),
          );
        }
      }
    } catch (e) {
      // Close progress dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Fehler: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<MatrixUser> filteredUsers = watchValue(
    //   (MatrixPolicyFilterManager x) => x.filteredMatrixUsers,
    // );

    return SelectMatrixUsersListPage(this, users ?? []);
  }
}
