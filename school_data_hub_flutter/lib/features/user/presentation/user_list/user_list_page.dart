import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_list_card.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_list_page_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/widgets/user_list_searchbar.dart';
import 'package:watch_it/watch_it.dart';

class UserListPage extends WatchingWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<User> users = watchValue((UserManager x) => x.users);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(iconData: Icons.people, title: 'Benutzer'),
      body: RefreshIndicator(
        onRefresh: () async => di<UserManager>().fetchUsers(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverSearchAppBar(
                  height: 110,
                  title: UserListSearchBar(users: users),
                ),
                GenericSliverListWithEmptyListCheck(
                  items: users,
                  itemBuilder: (_, user) => UserListCard(user),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const UserListPageBottomNavBar(),
    );
  }
}
