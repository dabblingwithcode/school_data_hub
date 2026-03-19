import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/matrix_room_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/widgets/matrix_user_list_card.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/widgets/matrix_user_list_searchbar.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/widgets/matrix_users_list_view_bottom_navbar.dart';

class MatrixRoomScreen extends WatchingWidget {
  final MatrixRoom matrixRoom;
  const MatrixRoomScreen({required this.matrixRoom, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    List<MatrixUser> matrixUsers = watchValue(
      (MatrixPolicyManager x) => x.matrixUsers,
    );
    List<MatrixUser> filteredMatrixUsers = watchValue(
      (MatrixPolicyFilterManager x) => x.filteredMatrixUsers,
    );
    final List<MatrixUser> matrixUsersInRoom = filteredMatrixUsers
        .where(
          (user) => MatrixRoomHelper.usersInRoom(matrixRoom.id).contains(user),
        )
        .toList();

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppHeader(iconData: Icons.room, title: matrixRoom.name!),
      body: RefreshIndicator(
        onRefresh: () async => di<MatrixPolicyManager>().fetchMatrixPolicy(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverAppBarWithSearchWidget(
                  searchWidgetWithStatsRow: MatrixUsersListSearchBar(
                    matrixUsers: matrixUsersInRoom,
                  ),
                  height: 110,
                ),
                matrixUsers.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Keine Ergebnisse',
                              style: context.typography.subtitle,
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // Your list view items go here
                            return MatrixUsersListCard(
                              matrixUsersInRoom[index],
                            );
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
