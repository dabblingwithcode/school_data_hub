import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class CompactStatusIndicator extends StatelessWidget {
  final String label;
  final bool isActive;

  const CompactStatusIndicator({
    Key? key,
    required this.label,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.accentColor : Colors.grey.shade300,
          ),
          child:
              isActive
                  ? const Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? AppColors.accentColor : Colors.black54,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
