import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';

class FilterButton extends WatchingWidget {
  final bool isSearchBar;
  final void Function(BuildContext) showBottomSheetFunction;
  final ValueListenable<bool> filtersActive;
  final VoidCallback? onLongPress;

  const FilterButton({
    required this.isSearchBar,
    required this.showBottomSheetFunction,
    required this.filtersActive,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filtersOn = watch(filtersActive).value;
    final style = Style.of(context);
    // When filters are active, use warning color; otherwise inherit from
    // parent IconTheme (white in ActionBar, muted in search bars).
    final Color iconColor = filtersOn
        ? style.colors.warning
        : isSearchBar
        ? style.colors.mutedForeground
        : IconTheme.of(context).color ?? style.colors.background;

    return GestureDetector(
      onLongPress: onLongPress,
      child: TappableIcon(
        tooltip: 'Filter',
        icon: const Icon(Icons.filter_list, size: 30),
        color: iconColor,
        onPressed: () => showBottomSheetFunction(context),
      ),
    );
  }
}
