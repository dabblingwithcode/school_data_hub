import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class StatusIndicators extends StatelessWidget {
  final String label;
  final bool isActive;

  const StatusIndicators({
    super.key,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final activeColor = style.colors.accent;
    final inactiveColor = style.colors.mutedForeground.withValues(alpha: 0.3);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? activeColor : inactiveColor,
            ),
            child:
                isActive
                    ? Icon(Icons.check, color: style.colors.background, size: 16)
                    : null,
          ),
          const Gap(16),
          Text(
            label,
            style: context.typography.subtitle.withColor(
              isActive ? activeColor : style.colors.mutedForeground,
            ).copyWith(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
