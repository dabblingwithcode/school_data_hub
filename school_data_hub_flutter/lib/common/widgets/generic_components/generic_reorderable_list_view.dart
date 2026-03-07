import 'package:flutter/material.dart';

class GenericReorderableListView extends StatelessWidget {
  final List<Widget> children;
  final void Function(int oldIndex, int newIndex) onReorder;
  const GenericReorderableListView({
    super.key,
    required this.children,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      buildDefaultDragHandles: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      proxyDecorator: (child, index, animation) => Material(
        elevation: 0, // Removes the default shadow/glow
        color: Colors.transparent,
        type: MaterialType.transparency,
        child: child,
      ),
      onReorder: onReorder,
      children: children,
    );
  }
}
