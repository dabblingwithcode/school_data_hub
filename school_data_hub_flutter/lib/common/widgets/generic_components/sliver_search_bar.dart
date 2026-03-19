import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class SliverSearchBar extends StatelessWidget {
  final Widget searchWidgetWithStatsRow;
  final double height;

  const SliverSearchBar({
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
      backgroundColor: Style.of(context).colors.canvas,
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
