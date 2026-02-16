import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';

class CustomExpansionTileContent extends WatchingStatefulWidget {
  final Widget? title;
  final List<Widget> widgetList;
  final CustomExpansionTileController tileController;

  const CustomExpansionTileContent({
    super.key,
    required this.widgetList,
    this.title,
    required this.tileController,
  });

  @override
  State<CustomExpansionTileContent> createState() =>
      _CustomExpansionTileContentState();
}

// Use TickerProviderStateMixin to provide 'vsync'
class _CustomExpansionTileContentState extends State<CustomExpansionTileContent>
    with TickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this, // 'this' works because of the Mixin
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access 'watch' via the watch_it mixin functionality in WatchingStatefulWidget
    final isExpanded = watch(widget.tileController.isExpanded).value;

    // Drive the animation
    if (isExpanded) {
      _animController.forward();
    } else {
      _animController.reverse();
    }

    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: _animController,
        curve: Curves.easeIn,
      ),
      axisAlignment: -1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.widgetList,
      ),
    );
  }
}
