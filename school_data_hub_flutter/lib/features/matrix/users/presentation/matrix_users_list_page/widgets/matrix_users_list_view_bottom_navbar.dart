import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/matrix_rooms_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/new_matrix_user_page/new_matrix_user_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/controller/select_matrix_users_list_controller.dart';
import 'package:watch_it/watch_it.dart';

class MatrixUsersListViewBottomNavbar extends WatchingWidget {
  const MatrixUsersListViewBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final _matrixPolicyManager = di<MatrixPolicyManager>();
    final _matrixPolicyFilterManager = di<MatrixPolicyFilterManager>();
    final bool filtersOn = watchValue(
      (MatrixPolicyFilterManager x) => x.filtersOn,
    );
    final bool pendingChanges = watchValue(
      (MatrixPolicyManager x) => x.pendingChanges,
    );
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        padding: const EdgeInsets.all(10),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  tooltip: 'zurück',
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                if (pendingChanges) ...<Widget>[
                  const Gap(30),
                  IconButton(
                    tooltip: 'Änderungen speichern',
                    icon: const Icon(Icons.save, size: 30),
                    onPressed: () {
                      _matrixPolicyManager.applyPolicyChanges();
                    },
                  ),
                ],
                const Gap(30),
                IconButton(
                  tooltip: 'neues Matrix-Konto',
                  icon: const Icon(Icons.add, size: 30),
                  onPressed: () {
                    // TODo: implement this
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const NewMatrixUserPage(),
                      ),
                    );
                  },
                ),
                const Gap(30),
                IconButton(
                  tooltip: 'Matrix-Räume',
                  icon: const Icon(Icons.meeting_room_rounded, size: 30),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const MatrixRoomsListPage(),
                      ),
                    );
                  },
                ),
                const Gap(30),
                IconButton(
                  tooltip: 'Zur Startseite',
                  onPressed:
                      () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                  icon: const Icon(Icons.home, size: 35),
                ),
                const Gap(30),
                IconButton(
                  tooltip: 'Mehrere neue Benutzer-Codes generieren',
                  icon: const Icon(Icons.print, color: Colors.orange, size: 30),
                  onPressed: () {
                    final matrixUsers = _matrixPolicyManager.matrixUsers.value;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => SelectMatrixUsersList(matrixUsers),
                      ),
                    );
                  },
                ),
                const Gap(30),
                InkWell(
                  // TODO: this needs to be implemented
                  //   onTap: () => showCreditFilterBottomSheet(context),
                  onLongPress:
                      () => _matrixPolicyFilterManager.resetAllMatrixFilters(),
                  child: Icon(
                    Icons.filter_list,
                    color: filtersOn ? Colors.deepOrange : Colors.white,
                    size: 30,
                  ),
                ),
                const Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _showBulkCredentialsDialog(BuildContext context) {
  //   final matrixUsers = _matrixPolicyManager.matrixUsers.value;

  //   if (matrixUsers.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Keine Matrix-Benutzer verfügbar.')),
  //     );
  //     return;
  //   }

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Bulk-Credentials generieren'),
  //         content: const Text(
  //           'Möchten Sie neue Benutzer-Codes generieren?\n\n'
  //           'Dies wird die Passwörter der Konten zurücksetzen und neue Credentials erstellen.',
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('Abbrechen'),
  //           ),
  //           TextButton(
  //             onPressed: () {

  //             },
  //             child: const Text('Bestätigen'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
