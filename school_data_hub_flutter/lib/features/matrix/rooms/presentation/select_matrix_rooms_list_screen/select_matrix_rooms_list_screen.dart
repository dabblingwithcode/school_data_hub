import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_screen/controller/select_matrix_rooms_list_controller.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_screen/widgets/select_matrix_room_card.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/select_matrix_rooms_list_screen/widgets/select_room_list_searchbar.dart';

class SelectMatrixRoomsListScreen extends WatchingWidget {
  final SelectMatrixRoomsListController controller;
  final List<MatrixRoom> filteredRoomsInLIst;
  const SelectMatrixRoomsListScreen(
    this.controller,
    this.filteredRoomsInLIst, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final filtersOn = watchValue((MatrixPolicyFilterManager x) => x.filtersOn);
    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.meeting_room_rounded,
        title: 'Räume auswählen',
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
      bottomNavigationBar: ActionBar(
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
                  ? style.colors.error
                  : style.colors.accentForeground,
              size: 30,
            ),
            onPressed: controller.toggleSelectAll,
          ),
          IconButton(
            tooltip: 'Okay',
            icon: Icon(
              Icons.check,
              color: controller.isSelectMode
                  ? style.colors.success
                  : style.colors.accentForeground,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context, controller.selectedRooms),
          ),

          IconButton(
            tooltip: 'Filter',
            icon: Icon(
              Icons.filter_list,
              color: filtersOn
                  ? style.colors.error
                  : style.colors.accentForeground,
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
