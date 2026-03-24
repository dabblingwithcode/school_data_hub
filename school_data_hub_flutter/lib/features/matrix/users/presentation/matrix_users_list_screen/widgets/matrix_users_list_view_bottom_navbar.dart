import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_generic_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/widgets/matrix_users_list_filter_bottom_sheet.dart';

class MatrixUsersListViewBottomNavbar extends WatchingWidget {
  const MatrixUsersListViewBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final matrixPolicyManager = di<MatrixPolicyManager>();
    final matrixPolicyFilterManager = di<MatrixPolicyFilterManager>();
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
        color: style.colors.accent,
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
                if (pendingChanges) ...[
                  const Gap(20),
                  IconButton(
                    tooltip: 'Änderungen speichern',
                    icon: const Icon(Icons.save, size: 30),
                    onPressed: () {
                      matrixPolicyManager.applyPolicyChanges();
                    },
                  ),
                ],
                const Gap(20),
                IconButton(
                  tooltip: 'neues Matrix-Konto',
                  icon: const Icon(Icons.add, size: 30),
                  onPressed: () => context.push(RoutePaths.adminMatrixNewUser),
                ),
                const Gap(20),
                IconButton(
                  tooltip: 'Matrix-Räume',
                  icon: const Icon(Icons.meeting_room_rounded, size: 30),
                  onPressed: () => context.push(RoutePaths.adminMatrixRooms),
                ),
                const Gap(20),
                IconButton(
                  tooltip: 'Event Reports',
                  icon: const Icon(Icons.flag_circle_rounded, size: 30),
                  onPressed: () =>
                      context.push(RoutePaths.adminMatrixEventReports),
                ),
                const Gap(20),
                IconButton(
                  tooltip: 'Zur Startseite',
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  icon: const Icon(Icons.home, size: 35),
                ),
                const Gap(20),
                IconButton(
                  tooltip: 'Matrix-Konten für SuS ohne Kontakt erstellen',
                  icon: const Icon(Icons.person_add_alt_1_rounded, size: 30),
                  onPressed: () async {
                    final file = await matrixPolicyManager.users
                        .createMatrixCredentialsForPupilsWithoutContactInfo();
                    if (!context.mounted) return;
                    if (file != null) {
                      context.push(
                        RoutePaths.utilPdfViewer,
                        extra: <String, dynamic>{
                          'pdfGenerator': () async => file,
                        },
                      );
                    }
                  },
                ),
                const Gap(20),
                IconButton(
                  tooltip: 'Mehrere neue Benutzer-Codes generieren',
                  icon: Icon(
                    Icons.print,
                    color: style.colors.warning,
                    size: 30,
                  ),
                  onPressed: () {
                    final matrixUsers = matrixPolicyManager.matrixUsers.value;
                    context.push(
                      RoutePaths.adminMatrixSelectUsers,
                      extra: <String, dynamic>{
                        'selectableMatrixUsers': matrixUsers,
                      },
                    );
                  },
                ),
                const Gap(30),
                InkWell(
                  onTap: () => showGenericBottomSheet(
                    context,
                    const GenericFilterBottomSheet(
                      children: [MatrixUsersFilterChips()],
                    ),
                  ),
                  onLongPress: () =>
                      matrixPolicyFilterManager.resetAllMatrixFilters(),
                  child: Icon(
                    Icons.filter_list,
                    color: filtersOn
                        ? style.colors.warning
                        : style.colors.background,
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
}
