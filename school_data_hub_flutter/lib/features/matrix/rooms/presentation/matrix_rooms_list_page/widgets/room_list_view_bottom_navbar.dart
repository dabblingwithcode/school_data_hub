import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/matrix_users_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/new_matrix_room_page/new_matrix_room_page.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyManager = di<MatrixPolicyManager>();
final _matrixPolicyFilterManager = di<MatrixPolicyFilterManager>();

class RoomListPageBottomNavBar extends WatchingWidget {
  const RoomListPageBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool filtersOn =
        watchValue((MatrixPolicyFilterManager x) => x.filtersOn);
    final bool pendingChanges =
        watchValue((MatrixPolicyManager x) => x.pendingChanges);

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
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                if (pendingChanges) ...<Widget>[
                  const Gap(30),
                  IconButton(
                    tooltip: 'Änderungen speichern',
                    icon: const Icon(
                      Icons.save,
                      size: 30,
                    ),
                    onPressed: () {
                      _matrixPolicyManager.applyPolicyChanges();
                    },
                  ),
                ],
                const Gap(30),
                IconButton(
                  tooltip: 'Neuer Raum',
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const NewMatrixRoomPage(),
                    ));
                  },
                ),
                const Gap(30),
                IconButton(
                  tooltip: 'Matrix-Konten',
                  icon: const Icon(
                    Icons.people_alt_rounded,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const MatrixUsersListPage(),
                    ));
                  },
                ),
                const Gap(30),
                IconButton(
                    tooltip: 'Zur Startseite',
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => route.isFirst),
                    icon: const Icon(
                      Icons.home,
                      size: 35,
                    )),
                const Gap(30),
                InkWell(
                  // TODO: implement this
                  // onTap: () => showRoomsFilterBottomSheet(context),
                  onLongPress: () =>
                      _matrixPolicyFilterManager.resetAllMatrixFilters(),
                  child: Icon(
                    Icons.filter_list,
                    color: filtersOn ? Colors.deepOrange : Colors.white,
                    size: 30,
                  ),
                ),
                const Gap(15)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
