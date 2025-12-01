import 'package:flutter/material.dart';

class AnimatedBranchContainer extends StatelessWidget {
  const AnimatedBranchContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children.map((Widget child) {
        final int index = children.indexOf(child);
        return IgnorePointer(
          ignoring: index != currentIndex,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: index == currentIndex ? 1 : 0,
            child: child,
          ),
        );
      }).toList(),
    );
  }
}

class SlidingBranchContainer extends StatefulWidget {
  const SlidingBranchContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  State<SlidingBranchContainer> createState() => _SlidingBranchContainerState();
}

class _SlidingBranchContainerState extends State<SlidingBranchContainer> {
  int? _previousIndex;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(SlidingBranchContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine direction
    // If first build or same index, default to forward (though it won't matter for first frame)
    // If index increased, we went 'forward' (right to left transition)
    // If index decreased, we went 'backward' (left to right transition)
    final int direction =
        (widget.currentIndex > (_previousIndex ?? widget.currentIndex))
            ? 1
            : -1;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation) {
        final bool isEntering = child.key == ValueKey(widget.currentIndex);

        // Slide In from Right (1.0 -> 0.0) if going forward
        // Slide In from Left (-1.0 -> 0.0) if going backward
        Offset begin = direction > 0
            ? const Offset(1.0, 0.0)
            : const Offset(-1.0, 0.0);
        Offset end = Offset.zero;

        if (!isEntering) {
          // Slide Out to Left (0.0 -> -1.0) if going forward
          // Slide Out to Right (0.0 -> 1.0) if going backward
          begin = Offset.zero;
          end = direction > 0
              ? const Offset(-1.0, 0.0)
              : const Offset(1.0, 0.0);
        }

        return SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: end,
          ).animate(animation),
          child: child,
        );
      },
      child: KeyedSubtree(
        key: ValueKey(widget.currentIndex),
        child: widget.children[widget.currentIndex],
      ),
    );
  }
}

