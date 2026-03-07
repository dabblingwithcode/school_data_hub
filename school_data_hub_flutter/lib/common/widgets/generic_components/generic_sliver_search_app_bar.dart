import 'package:flutter/material.dart';

class GenericSliverAppBarWithSearchWidget extends StatelessWidget {
  final Widget searchWidgetWithStatsRow;
  final double height;

  const GenericSliverAppBarWithSearchWidget({
    super.key,
    required this.searchWidgetWithStatsRow,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      automaticallyImplyLeading: false,
      leading: const SizedBox.shrink(),
      backgroundColor: Colors.transparent,
      collapsedHeight: height,
      expandedHeight: height,
      stretch: false,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        collapseMode: CollapseMode.none,
        background: searchWidgetWithStatsRow,
      ),
    );
  }
}
