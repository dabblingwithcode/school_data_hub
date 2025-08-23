import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class StatusIndicators extends StatelessWidget {
  final String label;
  final bool isActive;

  const StatusIndicators({
    Key? key,
    required this.label,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.accentColor : Colors.grey.shade300,
            ),
            child:
                isActive
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
          ),
          const Gap(16),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isActive ? AppColors.accentColor : Colors.black54,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
