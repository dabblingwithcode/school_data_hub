import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';

class ExpansionBody extends WatchingStatefulWidget {
  final Widget? title;
  final List<Widget> widgetList;
  final ExpansionController tileController;

  const ExpansionBody({
    super.key,
    required this.widgetList,
    this.title,
    required this.tileController,
  });

  @override
  State<ExpansionBody> createState() =>
      _ExpansionBodyState();
}

// Use TickerProviderStateMixin to provide 'vsync'
class _ExpansionBodyState extends State<ExpansionBody>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  bool _isAnimationDismissed = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this, // 'this' works because of the Mixin
      duration: const Duration(milliseconds: 200),
    );

    // Listen to animation status to know when it's fully collapsed
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _isAnimationDismissed = true;
        });
      } else if (_isAnimationDismissed) {
        setState(() {
          _isAnimationDismissed = false;
        });
      }
    });
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
      // Only build children when expanded OR when animation is in progress
      // This ensures smooth animation while still saving performance when fully collapsed
      child: _isAnimationDismissed
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.widgetList,
            ),
    );
  }
}
