import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/select_matrix_rooms_list_page/controller/select_matrix_rooms_list_controller.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyFilterManager = di<MatrixPolicyFilterManager>();

class SelectMatrixRoomsListViewBottomNavBar extends WatchingWidget {
  final SelectMatrixRoomsListController controller;

  const SelectMatrixRoomsListViewBottomNavBar(
      {required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final bool filtersOn =
        watchValue((MatrixPolicyFilterManager x) => x.filtersOn);
    return BottomAppBar(
      padding: const EdgeInsets.all(9),
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
              const Gap(30),
              controller.isSelectMode
                  ? IconButton(
                      onPressed: () {
                        controller.cancelSelect();
                      },
                      icon: const Icon(Icons.close))
                  : const SizedBox.shrink(),
              IconButton(
                tooltip: 'alle auswählen',
                icon: Icon(
                  Icons.select_all_rounded,
                  color: controller.isSelectAllMode
                      ? Colors.deepOrange
                      : Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  controller.toggleSelectAll();
                },
              ),
              IconButton(
                tooltip: 'Okay',
                icon: Icon(
                  Icons.check,
                  color: controller.isSelectMode ? Colors.green : Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context, controller.selectedRooms);
                },
              ),
              InkWell(
                // TODO: uncomment this when the filter is implemented
                // onTap: () => showGenericBottomSheet(
                //     context, const SelectMatrixUsersFilterBottomSheet()),
                // onTap: () => showSelectPupilsFilterBottomSheet(context),
                onLongPress: () =>
                    _matrixPolicyFilterManager.resetAllMatrixFilters(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.filter_list,
                    color: filtersOn ? Colors.deepOrange : Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const Gap(10)
            ],
          ),
        ),
      ),
    );
  }
}
