import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class SelectUsersPageBottomNavBar extends StatelessWidget {
  final bool filtersOn;
  final bool isSelectMode;
  final bool isSelectAllMode;

  final Function cancelSelect;
  final Function toggleSelectAll;
  final Function sendSelectedUsers;

  const SelectUsersPageBottomNavBar({
    required this.filtersOn,
    required this.isSelectMode,
    required this.isSelectAllMode,

    required this.cancelSelect,
    required this.toggleSelectAll,
    required this.sendSelectedUsers,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Gap(30),
              isSelectMode
                  ? IconButton(
                      onPressed: () {
                        cancelSelect();
                      },
                      icon: const Icon(Icons.close),
                    )
                  : const SizedBox.shrink(),
              IconButton(
                tooltip: 'alle auswählen',
                icon: Icon(
                  Icons.select_all_rounded,
                  color: isSelectAllMode ? Colors.deepOrange : Colors.white,
                  size: 30,
                ),
                onPressed: () => toggleSelectAll(),
              ),
              IconButton(
                tooltip: 'Okay',
                icon: Icon(
                  Icons.check,
                  color: isSelectMode ? Colors.green : Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  sendSelectedUsers();
                },
              ),
              // Note: Filter functionality removed as there's no UsersFilter implementation
              // If needed in the future, implement similar to PupilsFilter
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
