import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';

class GenericFilterButton extends WatchingWidget {
  final bool isSearchBar;
  final void Function(BuildContext) showBottomSheetFunction;
  final ValueListenable<bool> filtersActive;
  final VoidCallback? onLongPress;

  const GenericFilterButton({
    required this.isSearchBar,
    required this.showBottomSheetFunction,
    required this.filtersActive,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filtersOn = watch(filtersActive).value;

    return IconButton(
      tooltip: 'Filter',
      icon: Icon(
        Icons.filter_list,
        color: filtersOn
            ? Colors.deepOrange
            : isSearchBar
            ? Colors.grey
            : Colors.white,
        size: 30,
      ),
      onPressed: () => showBottomSheetFunction(context),
      onLongPress: onLongPress,
    );
  }
}
