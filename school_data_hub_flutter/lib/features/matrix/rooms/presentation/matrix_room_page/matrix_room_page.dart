import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_room_helpers.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_user_list_card.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_user_list_searchbar.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_users_list_view_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

class MatrixRoomPage extends WatchingWidget {
  final MatrixRoom matrixRoom;
  const MatrixRoomPage({required this.matrixRoom, super.key});

  @override
  Widget build(BuildContext context) {
    List<MatrixUser> matrixUsers =
        watchValue((MatrixPolicyManager x) => x.matrixUsers);
    List<MatrixUser> filteredMatrixUsers =
        watchValue((MatrixPolicyFilterManager x) => x.filteredMatrixUsers);
    final List<MatrixUser> matrixUsersInRoom = filteredMatrixUsers
        .where((user) =>
            MatrixRoomHelper.usersInRoom(matrixRoom.id).contains(user))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: GenericAppBar(iconData: Icons.room, title: matrixRoom.name!),
      body: RefreshIndicator(
        onRefresh: () async => di<MatrixPolicyManager>().fetchMatrixPolicy(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverSearchAppBar(
                    title: MatrixUsersListSearchBar(
                        matrixUsers: matrixUsersInRoom),
                    height: 110),
                matrixUsers.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Keine Ergebnisse',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // Your list view items go here
                            return MatrixUsersListCard(
                                matrixUsersInRoom[index]);
                          },
                          childCount: matrixUsersInRoom
                              .length, // Adjust this based on your data
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MatrixUsersListViewBottomNavbar(),
    );
  }
}
