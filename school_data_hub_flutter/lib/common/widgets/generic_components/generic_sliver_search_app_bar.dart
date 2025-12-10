import 'package:flutter/material.dart';

class GenericSliverSearchAppBar extends StatelessWidget {
  final Widget title;
  final double height;

  const GenericSliverSearchAppBar({
    super.key,
    required this.title,
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
        background: title,
      ),
    );
  }
}
