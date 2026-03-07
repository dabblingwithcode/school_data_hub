import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_page/controller/select_matrix_rooms_list_controller.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_page/widgets/select_matrix_room_card.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_page/widgets/select_room_list_searchbar.dart';

class SelectMatrixRoomsListPage extends WatchingWidget {
  final SelectMatrixRoomsListController controller;
  final List<MatrixRoom> filteredRoomsInLIst;
  const SelectMatrixRoomsListPage(
    this.controller,
    this.filteredRoomsInLIst, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filtersOn = watchValue((MatrixPolicyFilterManager x) => x.filtersOn);
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        leading: controller.isSelectMode
            ? IconButton(
                onPressed: () {
                  controller.cancelSelect();
                },
                icon: const Icon(Icons.close, color: Colors.white),
              )
            : null,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Räume auswählen', style: AppStyles.appBarTextStyle)],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                SliverAppBar(
                  pinned: false,
                  floating: true,
                  scrolledUnderElevation: null,
                  automaticallyImplyLeading: false,
                  leading: const SizedBox.shrink(),
                  backgroundColor: Colors.transparent,
                  collapsedHeight: 110,
                  expandedHeight: 110.0,
                  stretch: false,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                      left: 5,
                      top: 5,
                      right: 5,
                      bottom: 5,
                    ),
                    collapseMode: CollapseMode.none,
                    title: SelectRoomListSearchBar(
                      matrixRooms: filteredRoomsInLIst,
                      controller: controller,
                    ),
                  ),
                ),
                filteredRoomsInLIst.isEmpty
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
                        delegate: SliverChildBuilderDelegate((
                          BuildContext context,
                          int index,
                        ) {
                          // Your list view items go here
                          return SelectMatrixRoomCard(
                            controller,
                            filteredRoomsInLIst[index],
                          );
                        }, childCount: filteredRoomsInLIst.length),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          if (controller.isSelectMode)
            IconButton(
              tooltip: 'Abbrechen',
              icon: const Icon(Icons.close, size: 30),
              onPressed: controller.cancelSelect,
            ),
          IconButton(
            tooltip: 'alle auswählen',
            icon: Icon(
              Icons.select_all_rounded,
              color: controller.isSelectAllMode
                  ? Colors.deepOrange
                  : Colors.white,
              size: 30,
            ),
            onPressed: controller.toggleSelectAll,
          ),
          IconButton(
            tooltip: 'Okay',
            icon: Icon(
              Icons.check,
              color: controller.isSelectMode ? Colors.green : Colors.white,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context, controller.selectedRooms),
          ),

          IconButton(
            tooltip: 'Filter',
            icon: Icon(
              Icons.filter_list,
              color: filtersOn ? Colors.deepOrange : Colors.white,
              size: 30,
            ),
            onPressed: () => {},
            onLongPress: () =>
                di<MatrixPolicyFilterManager>().resetAllMatrixFilters(),
          ),
        ],
      ),
    );
  }
}
