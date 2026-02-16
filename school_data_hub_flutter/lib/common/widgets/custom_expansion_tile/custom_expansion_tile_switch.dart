import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';

class CustomExpansionTileSwitch extends WatchingWidget {
  final Widget? expansionSwitchWidget;
  final bool? includeSwitch;
  final Color? switchColor;
  final CustomExpansionTileController customExpansionTileController;
  final ValueChanged<bool>? onChanged;

  const CustomExpansionTileSwitch({
    this.expansionSwitchWidget,
    this.includeSwitch,
    this.switchColor,
    this.onChanged,
    required this.customExpansionTileController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = watch(customExpansionTileController.isExpanded).value;

    return InkWell(
      onTap: () {
        customExpansionTileController.toggle();
        onChanged?.call(customExpansionTileController.isExpanded.value);
      },
      child:
          expansionSwitchWidget != null &&
              includeSwitch != null &&
              includeSwitch == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                expansionSwitchWidget!,
                const Gap(10),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: switchColor!,
                ),
              ],
            )
          : expansionSwitchWidget != null && includeSwitch != true
          ? expansionSwitchWidget
          : Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: switchColor ?? Colors.white,
            ),
    );
  }
}
