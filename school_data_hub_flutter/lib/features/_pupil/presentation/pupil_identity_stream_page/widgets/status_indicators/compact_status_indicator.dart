import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class CompactStatusIndicator extends StatelessWidget {
  final String label;
  final bool isActive;

  const CompactStatusIndicator({
    super.key,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final activeColor = style.colors.accent;
    final inactiveColor = style.colors.mutedForeground.withValues(alpha: 0.3);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? activeColor : inactiveColor,
          ),
          child:
              isActive
                  ? Icon(Icons.check, color: style.colors.background, size: 12)
                  : null,
        ),
        const Gap(4),
        Text(
          label,
          style: context.typography.caption.withColor(
            isActive ? activeColor : style.colors.mutedForeground,
          ).copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
