import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:watch_it/watch_it.dart';

class UserListPageBottomNavBar extends WatchingWidget {
  const UserListPageBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
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
                const Gap(30),
                IconButton(
                  tooltip: 'Aktualisieren',
                  icon: const Icon(Icons.refresh, size: 30),
                  onPressed: () {
                    di<UserManager>().fetchUsers();
                  },
                ),
                const Gap(30),
                IconButton(
                  tooltip: 'Neuer Benutzer',
                  icon: const Icon(Icons.add, size: 30),
                  onPressed: () {
                    // TODO: Navigate to create user page
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (ctx) => const CreateUserPage(),
                    // ));
                  },
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
