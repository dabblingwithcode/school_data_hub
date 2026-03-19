import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';

class ExpansionHeader extends WatchingWidget {
  final Widget? expansionSwitchWidget;
  final bool? includeSwitch;
  final Color? switchColor;
  final ExpansionController expansionController;
  final ValueChanged<bool>? onChanged;

  const ExpansionHeader({
    this.expansionSwitchWidget,
    this.includeSwitch,
    this.switchColor,
    this.onChanged,
    required this.expansionController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = watch(expansionController.isExpanded).value;

    return InkWell(
      onTap: () {
        expansionController.toggle();
        onChanged?.call(expansionController.isExpanded.value);
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
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.keyboard_arrow_down, color: switchColor!),
                ),
              ],
            )
          : expansionSwitchWidget != null && includeSwitch != true
          ? expansionSwitchWidget
          : AnimatedRotation(
              turns: isExpanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: switchColor ?? Colors.white,
              ),
            ),
    );
  }
}
